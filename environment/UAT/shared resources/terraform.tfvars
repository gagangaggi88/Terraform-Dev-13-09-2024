resourcegroup = {
  rg = {
    name     = "rg-uks-poc-01"
    location = "uk south"
  }
}

storageaccount = {
  storage1 = {
    storagename              = "strgpc01"
    rgname                   = "rg-uks-poc-01"
    location                 = "uk south"
    account_tier             = "Standard"
    account_replication_type = "LRS"
  }
}

container = {
  cont1 = {
    containername = "uks-poc-docstorage"
    storagename   = "strgpc01"
    accesstype    = "private"
  }
}

keyvault = {
  keyvault1 = {
    kvname   = "kv-uks-pc-01"
    location = "uk south"
    rgname   = "rg-uks-poc-01"
  }
}