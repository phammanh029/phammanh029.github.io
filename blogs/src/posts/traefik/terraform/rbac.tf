# HTTPRoute Writer ClusterRoleBinding for each service's workload identity
resource "kubernetes_role_binding" "httproute_writer_binding_pr" {
  count = var.enable_pr_resources ? 1 : 0
  metadata {
    name = "httproute-writer-binding-${var.name}-pr"
    namespace = kubernetes_namespace.pr[0].metadata.0.name
  }
  
  role_ref {
    api_group = "rbac.authorization.k8s.io"
    kind      = "ClusterRole"
    name      = var.httproute_writer_role_name
  }

  subject {
    kind      = "User"
    name      = azurerm_user_assigned_identity.service_workload_identity_deploy.principal_id
    api_group = "rbac.authorization.k8s.io"
  }
}

resource "kubernetes_role_binding" "httproute_writer_binding_deploy" {
  metadata {
    name = "httproute-writer-binding-${var.name}-deploy"
    namespace = kubernetes_namespace.default.metadata.0.name
  }
  
  role_ref {
    api_group = "rbac.authorization.k8s.io"
    kind      = "ClusterRole"
    name      = var.httproute_writer_role_name
  }

  subject {
    kind      = "User"
    name      = azurerm_user_assigned_identity.service_workload_identity_deploy.principal_id
    api_group = "rbac.authorization.k8s.io"
  }
}

resource "kubernetes_role_binding" "httproute_reader_binding" {
  metadata {
    name = "httproute-reader-binding-${var.name}-deploy"
    namespace = kubernetes_namespace.default.metadata.0.name
  }
  
  role_ref {
    api_group = "rbac.authorization.k8s.io"
    kind      = "ClusterRole"
    name      = var.httproute_reader_role_name
  }

  subject {
    kind      = "User"
    name      = azurerm_user_assigned_identity.service_workload_identity_pr.principal_id
    api_group = "rbac.authorization.k8s.io"
  }
}