locals {

  traefik_config = {
    version    = "38.0.1"
    minReplicas = 1
    maxReplicas = 10
    cpu_target_percentage = 70
    memory_target_percentage = 70
  }
  helm_values = {
    providers = {
      kubernetesIngress = {
        enabled = false
      }
      kubernetesGateway = {
        enabled = true
      }
    }
    gateway = {
      enabled = true
      listeners = {
        web = {
          namespacePolicy = {
            from = "All"
          }
        }
      }
    }
    service = {
      type = "LoadBalancer"
      annotations = {
        "service.beta.kubernetes.io/azure-load-balancer-internal" = "true"
      }
    }
    autoscaling = {
      enabled     = true
      minReplicas = local.traefik_config.minReplicas
      maxReplicas = local.traefik_config.maxReplicas
      metrics = [
        {
          type = "Resource"
          resource = {
            name = "cpu"
            target = {
              type               = "Utilization"
              averageUtilization = local.traefik_config.cpu_target_percentage
            }
          }
        },
        {
          type = "Resource"
          resource = {
            name = "memory"
            target = {
              type               = "Utilization"
              averageUtilization = local.traefik_config.memory_target_percentage
            }
          }
        }
      ]
      behavior = {
        scaleUp = {
          stabilizationWindowSeconds = 0
          selectPolicy = "Max"
          policies = [
            {
              type          = "Percent"
              value         = 100
              periodSeconds = 15
            }
          ]
        }
        scaleDown = {
          stabilizationWindowSeconds = 300
          selectPolicy = "Min"
          policies = [
            {
              type          = "Percent"
              value         = 100
              periodSeconds = 15
            },
            {
              type          = "Pods"
              value         = 5
              periodSeconds = 15
            }
          ]
        }
      }

    }
    # Pod anti-affinity to spread Traefik pods across nodes
    affinity = {
      podAntiAffinity = {
        requiredDuringSchedulingIgnoredDuringExecution = [
          {
            labelSelector = {
              matchLabels = {
                "app.kubernetes.io/name"     = "{{ template \"traefik.name\" . }}"
                "app.kubernetes.io/instance" = "{{ .Release.Name }}-{{ include \"traefik.namespace\" . }}"
              }
            }
            topologyKey = "kubernetes.io/hostname"
          }
        ]
      }
    }
  }
}

resource "kubernetes_namespace" "gateway" {
  metadata {
    name = "traefik"
  }
  depends_on = [azurerm_kubernetes_cluster.default]
}

resource "helm_release" "traefik" {
  name       = "traefik"
  namespace  = kubernetes_namespace.gateway.metadata[0].name
  repository = "https://traefik.github.io/charts"
  version    = local.traefik_config.version
  chart      = "traefik"
  values     = [yamlencode(local.helm_values)]
}

data "kubernetes_resources" "traefik_service" {

  api_version = "v1"
  kind        = "Service"
  namespace   = kubernetes_namespace.gateway.metadata[0].name
  label_selector = "app.kubernetes.io/name=traefik"
  

  depends_on = [data.azurerm_lb.kubernetes_internal]
}

# Data source for internal load balancer
data "azurerm_lb" "kubernetes_internal" {

  name                = "kubernetes-internal"
  resource_group_name = azurerm_kubernetes_cluster.default.node_resource_group

}

# Private Link Service for Gateway
resource "azurerm_private_link_service" "traefik_gateway" {

  name                           = "gateway-pls"
  resource_group_name            = azurerm_resource_group.default.name
  location                       = var.location
  auto_approval_subscription_ids = [data.azurerm_client_config.current.subscription_id]
  visibility_subscription_ids    = [data.azurerm_client_config.current.subscription_id]

  # The Traefik service is not created in when plan, use try to bypass errors
  load_balancer_frontend_ip_configuration_ids = try([
    data.azurerm_lb.kubernetes_internal.frontend_ip_configuration[
      index(data.azurerm_lb.kubernetes_internal.frontend_ip_configuration.*.private_ip_address,
        try(data.kubernetes_resources.traefik_service.objects[0].status.loadBalancer.ingress[0].ip, "")
      )
    ].id
  ], [])

  nat_ip_configuration {
    name      = "primary"
    subnet_id = azurerm_subnet.private_link.id
    primary   = true
  }
}

# HTTPRoute Writer ClusterRole
# Allows services to manage HTTPRoute resources
resource "kubernetes_cluster_role" "httproute_writer" {
  metadata {
    name = "httproute-writer"
  }

  rule {
    api_groups = ["gateway.networking.k8s.io"]
    resources  = ["httproutes"]
    verbs      = ["get", "list", "watch", "create", "update", "patch", "delete"]
  }
}

resource "kubernetes_cluster_role" "httproute_reader" {
  metadata {
    name = "httproute-reader"
  }

  rule {
    api_groups = ["gateway.networking.k8s.io"]
    resources  = ["httproutes"]
    verbs      = ["get", "list", "watch"]
  }
}