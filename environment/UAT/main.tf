module "vnet" {
  source = "../../Vnet"
  vnet   = var.vnet
  subnet = var.subnet
  # depends_on = [module.resourcegroup]
}

module "virtual_machine" {
  source          = "../../WindowsVM"
  virtual_machine = var.virtual_machine
  depends_on      = [module.vnet]


}

module "servicebus" {
  source     = "../../service ns"
  servicebus = var.servicebus
  # depends_on = [module.resourcegroup]

}

module "azurerm_servicebus_queue" {
  source                   = "../../service queue"
  azurerm_servicebus_queue = var.azurerm_servicebus_queue
  depends_on               = [module.servicebus]

}

module "azurerm_servicebus_topic" {
  source                   = "../../Service topics"
  azurerm_servicebus_topic = var.azurerm_servicebus_topic
  depends_on               = [module.servicebus]


}

module "azurerm_servicebus_subscription" {
  source                          = "../../Service Subscription"
  azurerm_servicebus_subscription = var.azurerm_servicebus_subscription
  depends_on                      = [module.servicebus, module.azurerm_servicebus_topic]

}

module "sqlsrvr" {
  source  = "../../sql srvr"
  sqlsrvr = var.sqlsrvr
  # depends_on = [ module.resourcegroup ]

}

module "sqldatabase" {
  source      = "../../SQL DB"
  sqldatabase = var.sqldatabase
  depends_on  = [module.sqlsrvr]


}

module "waf" {
  source = "../../WAF"
  waf    = var.waf
  # depends_on = [module.resourcegroup]

}
# module "acr" {
#   source = "../../AKS"
#   aks    = var.aks
#   depends_on = [ module.resourcegroup ]
# }

module "aks" {
  source     = "../../AKS"
  aks        = var.aks
  depends_on = [module.vnet, module.appgw]
}

# module "aks_acr_pull" {
#   source       = "../../role assignment"
#   aks_acr_pull = var.aks_acr_pull
#   depends_on   = [module.aks]

# }




module "appgw" {
  source     = "../../App GW"
  appgw      = var.appgw
  depends_on = [module.vnet, module.waf]

}