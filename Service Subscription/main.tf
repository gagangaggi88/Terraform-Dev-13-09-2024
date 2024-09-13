data "azurerm_servicebus_namespace" "svbus" {
    for_each = var.azurerm_servicebus_subscription
  name                = each.value.svname
  resource_group_name = each.value.rgname
}

data "azurerm_servicebus_topic" "svtopic" {
    for_each = var.azurerm_servicebus_subscription
  name         = each.value.topicname
  namespace_id = data.azurerm_servicebus_namespace.svbus[each.key].id
}

resource "azurerm_servicebus_subscription" "sub" {
  for_each = var.azurerm_servicebus_subscription
  name               = each.value.subname
  topic_id           = data.azurerm_servicebus_topic.svtopic[each.key].id
  max_delivery_count = 10
}