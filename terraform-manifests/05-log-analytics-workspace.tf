# Create Log Analytics Workspace
resource "azurerm_log_analytics_workspace" "insights" {
  name                = "${var.environment}-${random_integer.aksrandom.id-la}"
  location            = azurerm_resource_group.aks_rg.location
  resource_group_name = azurerm_resource_group.aks_rg.name
  retention_in_days   = 30
}

resource "azurerm_log_analytics_solution" "test" {
    solution_name         = "ContainerInsights"
    location              = azurerm_resource_group.aks_rg.location
    resource_group_name   = azurerm_resource_group.aks_rg.name
    workspace_resource_id = azurerm_log_analytics_workspace.insights.id
    workspace_name        = azurerm_log_analytics_workspace.insights.name

    plan {
        publisher = "Microsoft"
        product   = "OMSGallery/ContainerInsights"
    }
}