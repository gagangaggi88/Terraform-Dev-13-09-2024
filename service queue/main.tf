data "azurerm_servicebus_namespace" "svbus" {
  for_each = var.azurerm_servicebus_queue
  name                = each.value.svname
  resource_group_name = each.value.rgname
}

resource "azurerm_servicebus_queue" "svque" {
  for_each = var.azurerm_servicebus_queue
  name         = each.value.svquename
  namespace_id = data.azurerm_servicebus_namespace.svbus[each.key].id

  # enable_partitioning = true
  
}