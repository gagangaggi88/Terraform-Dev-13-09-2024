data "azurerm_servicebus_namespace" "svbus" {
  for_each = var.azurerm_servicebus_topic
  name                = each.value.svname
  resource_group_name = each.value.rgname
}

resource "azurerm_servicebus_topic" "svtopic" {
  for_each = var.azurerm_servicebus_topic
  name         = each.value.topicname
  namespace_id = data.azurerm_servicebus_namespace.svbus[each.key].id

  # enable_partitioning = true
}
