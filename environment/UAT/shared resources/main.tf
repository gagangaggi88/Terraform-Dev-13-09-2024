module "resourcegroup" {
  source        = "../../../resourcegroup"
  resourcegroup = var.resourcegroup

}
module "storageaccount" {
  source         = "../../../StorageAccount"
  storageaccount = var.storageaccount
  depends_on     = [module.resourcegroup]

}

module "container" {
  source     = "../../../Containers"
  container  = var.container
  depends_on = [module.resourcegroup, module.storageaccount]

}

module "keyvault" {
  source     = "../../../KeyVault"
  keyvault   = var.keyvault
  depends_on = [module.resourcegroup]

}