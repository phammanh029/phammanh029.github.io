# Overview

Using app overview for something like k8s but less managed.

To use container name as hostname, we need to enable ingress, and enable internal communication like:
** NOTE **
For http, if the header contains `host`, it will proxy call to the host
```hcl
  ingress {
    external_enabled           = false
    # container port
    target_port                = 3100
    # allow http connection
    allow_insecure_connections = true
    traffic_weight {
      percentage = 100
      latest_revision = true
    }
  }
```

To use private registry from ACR, we need to create a service principal with role `AcrPull` on the registry (User assigned identity)
```hcl
resource "azurerm_container_app_environment" "env" {
  name                       = "env"
  location                   = var.location
  resource_group_name        = var.resource_group_name
  log_analytics_workspace_id = var.log_analytics_workspace_id
}

# load azure container registry
data "azurerm_container_registry" "acr" {
  name                = var.acr_name
  resource_group_name = var.resource_group_name
}

# We need to use user assigned identity to pull images from ACR as we need to have pull access while provisioning the container apps
resource "azurerm_user_assigned_identity" "workload_uai" {
  name                = "uai"
  location            = var.location
  resource_group_name = var.resource_group_name
}

resource "azurerm_role_assignment" "acr_pull" {
  scope                = data.azurerm_container_registry.acr.id
  role_definition_name = "AcrPull"
  principal_id         = azurerm_user_assigned_identity.workload_uai.principal_id
}

resource "azurerm_container_app" "ext_api" {
  name                         = "ext_api"
  resource_group_name          = var.resource_group_name
  container_app_environment_id = azurerm_container_app_environment.simulator_env.id
  revision_mode                = "Single"

  ingress {
    external_enabled           = false
    target_port                = 3000
    allow_insecure_connections = true
    traffic_weight {
      percentage = 100
      latest_revision = true
    }
  }

  template {
    # should only be 1 replica, should not scale as it holds state in memory and must be consistent
    min_replicas = 1
    max_replicas = 1

    container {
      name   = "ext_api"
      image  = "nginx:alpine"
      cpu    = 0.25
      memory = "0.5Gi"
      readiness_probe {
        path                    = "/health"
        port                    = "80"
        transport               = "HTTP"
        failure_count_threshold = 5
        initial_delay           = 2
      }
    }

  }
}

resource "azurerm_container_app" "apis" {
  name                         = "apis"
  resource_group_name          = var.resource_group_name
  container_app_environment_id = azurerm_container_app_environment.simulator_env.id
  revision_mode                = "Single"
  # It should not take that long to create the container app (default to 30m)
  timeouts {
    create = "15m"
    update = "15m"
    delete = "10m"
  }

  identity {
    type         = "UserAssigned"
    identity_ids = [azurerm_user_assigned_identity.workload_uai.id]
  }

  registry {
    server   = data.azurerm_container_registry.acr.login_server
    identity = azurerm_user_assigned_identity.workload_uai.id
  }

  ingress {
    external_enabled           = false
    target_port                = 4010
    allow_insecure_connections = true
    traffic_weight {
      percentage = 100
      latest_revision = true
    }
  }

  secret {
    name  = "client-secret"
    value = var.client_secret
  }

  template {
    min_replicas = 1
    # auto scale just in case the load test is too high
    max_replicas = 5

    container {
      name   = "apis"
      image  = "${data.azurerm_container_registry.acr.login_server}/apis:${var.image_tag}"
      cpu    = 0.25
      memory = "0.5Gi"

      env {
        name  = "ENV_1"
        value = var.env1
      }
      env {
        name  = "EXT_API_URL"
        value = "http://ext_api:80"
      }

      env {
        name = "CLIENT_SECRET"
        # load from above secret
        secret_name = "client-secret"
      }

      args = [
        "--some-arg", "value",
        "--other-arg", "value"
      ]

      readiness_probe {
        path                    = "/health"
        port                    = "3000"
        transport               = "HTTP"
        failure_count_threshold = 5
        initial_delay           = 2
      }
    }
  }
}
```