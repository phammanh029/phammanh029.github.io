resource "azurerm_service_plan" "plan" {
  name                = "fa-plan-${local.name}-${var.environment}"
  location            = azurerm_resource_group.default.location
  resource_group_name = azurerm_resource_group.default.name
  os_type             = "Linux"
  sku_name            = "FC1" # Flexible Consumption Plan
}

# This function isn't require always run & always on, so we should choose a flexible consumption plan (ability to integrate to vnet)
resource "azurerm_function_app_flex_consumption" "fa" {
  name                = "fa-${local.name}-${var.environment}"
  location            = azurerm_resource_group.default.location
  resource_group_name = azurerm_resource_group.default.name
  service_plan_id     = azurerm_service_plan.plan.id

  storage_container_type      = "blobContainer"
  storage_container_endpoint  = "${azurerm_storage_account.sa.primary_blob_endpoint}${azurerm_storage_container.container.name}"
  storage_authentication_type = "StorageAccountConnectionString"
  storage_access_key          = azurerm_storage_account.sa.primary_access_key
  runtime_name                = "python"
  runtime_version             = "3.11"
  maximum_instance_count      = 50
  instance_memory_in_mb       = 512

  site_config {
    minimum_tls_version = "1.2" # Event grid currently have an issue with TLS 1.3 https://github.com/Azure/azure-functions-dotnet-worker/issues/2962
  }
  
  identity{
    type = "SystemAssigned"
  }

  app_settings = {
    "ROTATION_DAYS" : "90",
  }
}