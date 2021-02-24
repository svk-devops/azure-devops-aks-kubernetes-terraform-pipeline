# Create Azure AD Group in Active Directory for AKS Admins
data "azuread_user" "aks_administrators_user" {
  user_principal_name = "sergey.kozlov_hotmail.com#EXT#@sergeykozlovhotmail.onmicrosoft.com "
}

resource "azuread_group" "aks_administrators" {
  display_name  = "${azurerm_resource_group.aks_rg.name}-cluster-administrators"
  description   = "Azure AKS Kubernetes administrators for the ${azurerm_resource_group.aks_rg.name}-cluster."
}

resource "azuread_group_member" "example" {
  group_object_id  = azuread_group.aks_administrators.id
  member_object_id = data.azuread_user.aks_administrators_user.id
}
