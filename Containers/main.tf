resource "azurerm_storage_container" "container" {
  for_each              = var.container
  name                  = each.value.containername
  storage_account_name  = each.value.storagename
  container_access_type = each.value.accesstype
}