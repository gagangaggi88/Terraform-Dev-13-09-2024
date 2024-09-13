resource "azurerm_virtual_network" "vnet" {
  for_each            = var.vnet
  name                = each.value.vnetname
  location            = each.value.location
  resource_group_name = each.value.rgname
  address_space       = each.value.address_space

  dynamic "subnet" {

    for_each = var.subnet

    content {
      name           = subnet.value.subnet_name
      address_prefixes  = subnet.value.subnet_address
    }
  }
        tags                                = {
        "Deployment Name"  = "IaC POC"
        "Deployment Owner" = "Rajiv Tanwar"
        "Backup"            = "No"
        "Creation Date"     = "09-Aug-2024"
        "Environment"       = "Uat" # UAT
        "SLA"               = "INS_SCR_001"
    }

}