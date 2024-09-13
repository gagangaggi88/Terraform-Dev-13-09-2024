resource "azurerm_servicebus_namespace" "svbus" {
  for_each = var.servicebus
  name                = each.value.svname
  location            = each.value.location
  resource_group_name = each.value.rgname
  sku                 = "Standard"


        tags                                = {
        "Deployment Name"  = "IaC POC"
        "Deployment Owner" = "Rajiv Tanwar"
        "Backup"            = "No"
        "Creation Date"     = "09-Aug-2024"
        "Environment"       = "Uat"
        "SLA"               = "INS_SCR_001"
    }
}

resource "azurerm_servicebus_namespace_authorization_rule" "svrule" {
  for_each = var.servicebus
  name         = each.value.svrule
  namespace_id = resource.azurerm_servicebus_namespace.svbus[each.key].id

  listen = true
  send   = true
  manage = true
}
