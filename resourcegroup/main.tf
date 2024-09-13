resource "azurerm_resource_group" "resourcegroup" {
  for_each = var.resourcegroup
  name     = each.value.name
  location = each.value.location
        tags                                = {
        ApplicationName  = "IaC POC"
        ApplicationOwner = "Rajiv Tanwar"
        Backup            = "No"
        CreationDate    = "09-Aug-2024"
        Billing = "Billable"
        Environment       = "Uat"
        SLA               = "INS_SCR_001"
    }
}
 