data "azurerm_client_config" "current" {}

resource "azurerm_key_vault" "keyvault" {
    for_each = var.keyvault
  name                        = each.value.kvname
  location                    = each.value.location
  resource_group_name         = each.value.rgname
  enabled_for_disk_encryption = true
  tenant_id                   = data.azurerm_client_config.current.tenant_id
  soft_delete_retention_days  = 7
  purge_protection_enabled    = false

  sku_name = "standard"

  access_policy {
    tenant_id = data.azurerm_client_config.current.tenant_id
    object_id = data.azurerm_client_config.current.object_id

    key_permissions = [
      "Create",
      "Get",
      "Delete",
      "Purge",
      "Recover",
    ]

    secret_permissions = [
      "Set",
      "Get",
      "Delete",
      "Purge",
      "Recover",
    ]

    storage_permissions = [
      "Set",
      "Get",
      "Delete",
      "Purge",
      "Recover",
    ]
  }

        tags                                = {
        "Deployment Name"  = "IaC POC"
        "Deployment Owner" = "Rajiv Tanwar"
        "Backup"            = "No"
        "Creation Date"     = "09-Aug-2024"
        "Environment"       = "Uat"
        "SLA"               = "INS_SCR_001"
    }
}


# resource "azurerm_key_vault" "kv" {
#   for_each = var.keyvault
# name                            = each.value.kvname
# location                        = each.value.location
# resource_group_name             = each.value.rgname
# enabled_for_disk_encryption     = false 
# tenant_id                       = "48de6fe2-e408-44bf-8020-340bdb92a77b"
# soft_delete_retention_days      = 90
# purge_protection_enabled        = false
# sku_name                        = "standard"
# access_policy                   = []
# enable_rbac_authorization       = true
# enabled_for_deployment          = false
# enabled_for_template_deployment = false
# public_network_access_enabled   = true
#     tags                                = {
#         "Application Name"  = "Claims Ops Platform"
#         "Application Owner" = "Amit Dhamija"
#         "Backup"            = "Yes"
#         "Creation Date"     = "13-Sep-2023"
#         "Environment"       = "Uat"
#         "SLA"               = "CL_U"
#     }
# network_acls {
#         bypass                     = "AzureServices"
#         default_action             = "Allow"
#         ip_rules                   = []
#         virtual_network_subnet_ids = []
#     }
# }
