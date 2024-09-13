data "azurerm_key_vault" "keyvault" {
  for_each = var.sqlsrvr
  name                = each.value.kvname
  resource_group_name = each.value.rgname
}

data "azurerm_key_vault_secret" "keyvaultsecret" {
  for_each = var.sqlsrvr
  name         = each.value.kvsuname
  key_vault_id = data.azurerm_key_vault.keyvault[each.key].id
}
data "azurerm_key_vault_secret" "keyvaultsecret1" {
  for_each = var.sqlsrvr
  name         = each.value.kvspname
  key_vault_id = data.azurerm_key_vault.keyvault[each.key].id
}


# resource "azurerm_sql_server" "sqlsrvr" {
#   for_each = var.sqlsrvr
#   name                         = each.value.srvrname
#   resource_group_name          = each.value.rgname
#   location                     = each.value.location
#   version                      = each.value.version
#   administrator_login          = data.azurerm_key_vault_secret.keyvaultsecret[each.key].value
#   administrator_login_password = data.azurerm_key_vault_secret.keyvaultsecret1[each.key].value

#         tags                                = {
#         "Deployment Name"  = "IaC POC"
#         "Deployment Owner" = "Rajiv Tanwar"
#         "Backup"            = "No"
#         "Creation Date"     = "09-Aug-2024"
#         "Environment"       = "Uat"
#         "SLA"               = "INS_SCR_001"
#     }
# }

resource "azurerm_mssql_server" "sqlsrvr" {
  for_each = var.sqlsrvr
  name                         = each.value.srvrname
  resource_group_name          = each.value.rgname
  location                     = each.value.location
   version                      = each.value.version
  administrator_login          = data.azurerm_key_vault_secret.keyvaultsecret[each.key].value
  administrator_login_password = data.azurerm_key_vault_secret.keyvaultsecret1[each.key].value
  minimum_tls_version          = "1.2"

  azuread_administrator {
    login_username = "Gagandeep Sharma"
    object_id      = "0792dfe8-0c37-4b88-803f-bbed2f2fae0d"
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