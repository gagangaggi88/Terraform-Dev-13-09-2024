# data "azurerm_key_vault" "keyvault" {
#   for_each = var.sqlsrvr
#   name                = each.value.kvname
#   resource_group_name = each.value.rgname
# }

# data "azurerm_key_vault_secret" "keyvaultsecret" {
#   for_each = var.sqlsrvr
#   name         = each.value.kvsuname
#   key_vault_id = data.azurerm_key_vault.keyvault[each.key].id
# }
# data "azurerm_key_vault_secret" "keyvaultsecret1" {
#   for_each = var.sqlsrvr
#   name         = each.value.kvspname
#   key_vault_id = data.azurerm_key_vault.keyvault[each.key].id
# }

# resource "azurerm_sql_database" "sqldatabase" {
#   for_each = var.sqldatabase
#   name                = each.value.dbname
#   resource_group_name          = each.value.rgname
#   location                     = each.value.location
#   server_name         = each.value.srvrname

#         tags                                = {
#         "Deployment Name"  = "IaC POC"
#         "Deployment Owner" = "Rajiv Tanwar"
#         "Backup"            = "No"
#         "Creation Date"     = "09-Aug-2024"
#         "Environment"       = "Uat"
#         "SLA"               = "INS_SCR_001"
#     }

#   # prevent the possibility of accidental data loss
#   lifecycle {
#     prevent_destroy = true
#   }
# }

data "azurerm_mssql_server" "sqlsrvr" {
  for_each = var.sqldatabase
  name                = each.value.srvrname
  resource_group_name          = each.value.rgname
}

resource "azurerm_mssql_database" "sqldatabase" {
for_each = var.sqldatabase
name                = each.value.dbname
  server_id      = data.azurerm_mssql_server.sqlsrvr[each.key].id
  collation      = "SQL_Latin1_General_CP1_CI_AS"
  license_type   = "LicenseIncluded"
  max_size_gb    = 2
  read_scale     = false
  sku_name       = "S0"
  zone_redundant = false
  enclave_type   = "VBS"

  tags = {
    foo = "bar"
  }

  # prevent the possibility of accidental data loss
  lifecycle {
    prevent_destroy = false
  }
}