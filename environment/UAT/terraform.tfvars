vnet = {
  vnet1 = {
    vnetname      = "vnet-uks-poc-02"
    location      = "uk south"
    rgname        = "rg-uks-poc-01"
    address_space = ["172.16.52.0/22"]
  }
}

subnet = {
  subnet1 = {
    subnet_name    = "snet-uks-agw-poc-02"
    subnet_address = ["172.16.54.160/28"]
    vnetname       = "vnet-uks-poc-02"
    rgname         = "rg-uks-poc-01"
  },
  subnet2 = {
    subnet_name    = "snet-uks-poc-aks-u-02"
    subnet_address = ["172.16.52.0/23"]
    vnetname       = "vnet-uks-poc-02"
    rgname         = "rg-uks-poc-01"
  },
  subnet3 = {
    subnet_name    = "AzureFirewallSubnet"
    subnet_address = ["172.16.54.0/26"]
    vnetname       = "vnet-uks-poc-02"
    rgname         = "rg-uks-poc-u-01"
  },
  subnet4 = {
    subnet_name    = "AzureBastionSubnet"
    subnet_address = ["172.16.54.64/26"]
    vnetname       = "vnet-uks-poc-02"
    rgname         = "rg-uks-poc-01"
  },
  subnet5 = {
    subnet_name    = "snet-uks-pe-poc-02"
    subnet_address = ["172.16.54.176/28"]
    vnetname       = "vnet-uks-poc-u-02"
    rgname         = "rg-uks-poc-01"
  },
  subnet6 = {
    subnet_name    = "snet-uks-vm-poc-02"
    subnet_address = ["172.16.54.192/28"]
    vnetname       = "vnet-uks-poc-u-02"
    rgname         = "rg-uks-poc-01"
  },
  subnet7 = {
    subnet_name    = "GatewaySubnet"
    subnet_address = ["172.16.54.128/27"]
    vnetname       = "vnet-uks-poc-02"
    rgname         = "rg-uks-poc-01"
  }
}

virtual_machine = {
  vm1 = {
    nic_name          = "uks-poc-a-0192"
    nsg               = "uks-poc-a-01-nsg"
    pip               = "uks-poc-a-01-ip"
    vm_name           = "uks-poc-a-01"
    snet              = "snet-uks-vm-poc-02"
    vnet              = "vnet-uks-poc-02"
    rgname            = "rg-uks-poc-01"
    location          = "uk south"
    kvname            = "kv-uks-pc-01"
    kvsuname          = "srvr-usrname"
    kvspname          = "srvr-psword"
    allocation_method = "Static"
    vmsize            = "Standard_B2s"
  }
}

servicebus = {
  svcbus1 = {
    svname   = "sb-uks-poc-01"
    rgname   = "rg-uks-poc-01"
    location = "uk south"
    svrule   = "poc-RootManageSharedAccessKey"

  }
}

azurerm_servicebus_queue = {
  svcque1 = {
    svquename = "sb-uks-poc-ccmp-bulk-upload-queue"
    svname    = "sb-uks-poc-01"
    rgname    = "rg-uks-poc-01"
  },
  svcque2 = {
    svquename = "sb-uks-poc-ccmp-ds-queue"
    svname    = "sb-uks-poc-01"
    rgname    = "rg-uks-poc-01"
  },
  svcque3 = {
    svquename = "sb-uks-poc-ccmp-ems-queue"
    svname    = "sb-uks-poc-01"
    rgname    = "rg-uks-poc-01"
  },
  svcque4 = {
    svquename = "sb-uks-poc-ccmp-xsc-outscope-mail-queue"
    svname    = "sb-uks-poc-01"
    rgname    = "rg-uks-poc-01"
  }
}

azurerm_servicebus_topic = {
  svctopic1 = {
    topicname = "xsc-req-poc-topic"
    svname    = "sb-uks-poc-01"
    rgname    = "rg-uks-poc-01"
  },
  svctopic2 = {
    topicname = "xsc-resp-poc-topic"
    svname    = "sb-uks-poc-01"
    rgname    = "rg-uks-poc-01"
  }
}

azurerm_servicebus_subscription = {
  sub1 = {
    subname   = "xsc-req-poc-subscription"
    topicname = "xsc-req-poc-topic"
    svname    = "sb-uks-poc-01"
    rgname    = "rg-uks-poc-01"
  },
  sub2 = {
    subname   = "xsc-resp-poc-subscription"
    topicname = "xsc-resp-poc-topic"
    svname    = "sb-uks-poc-01"
    rgname    = "rg-uks-poc-01"
  }
}

sqlsrvr = {
  srvr1 = {
    srvrname = "sql-uks-poc-db-01"
    rgname   = "rg-uks-poc-01"
    location = "uk south"
    version  = "12.0"
    kvname   = "kv-uks-pc-01"
    kvsuname = "srvr-usrname"
    kvspname = "srvr-psword"
  }
}

sqldatabase = {
  db1 = {
    dbname   = "poc-db"
    rgname   = "rg-uks-poc-01"
    location = "uk south"
    srvrname = "sql-uks-poc-db-01"
  }
  # db2 = {
  #   dbname   = "poc_Common"
  #   rgname   = "rg-uks-poc-01"
  #   location = "uk south"
  #   srvrname = "sql-uks-poc-db-01"
  # },
  # db3 = {
  #   dbname   = "poc_BH"
  #   rgname   = "rg-uks-poc-01"
  #   location = "uk south"
  #   srvrname = "sql-uks-poc-db-01"
  # }
}

# acr = {
#   acr = {
#     acrname  = "acrukspoc01"
#     rgname   = "rg-uks-poc-01"
#     location = "uk south"

#   }
# }

waf = {
  waf1 = {
    waf_name = "waf-agw-uks-poc-01"
    location = "uk south"
    rgname   = "rg-uks-poc-01"
  },
}

aks = {
  aks = {
    clustername   = "aks-uks-poc-02"
    dnsprefixname = "aks-uks-poc-02-dns"
    location      = "uk south"
    rgname        = "rg-uks-poc-01"
    nodename      = "agentpool"
    vmsize        = "Standard_DS2_v2"
    type          = "SystemAssigned"
    acrname       = "acrukspc02"
    acr_tsk_name  = "acrukspoc02_tsk"
    skuname       = "Standard"
    vnetname      = "vnet-uks-poc-02"
    subnet_name   = "snet-uks-poc-aks-u-02"
    dsk_name      = "mdsk-uks-poc-01"
    appgwname = "agw-uks-poc-01"
  }
}

# aks_acr_pull = {
#   role = {
#     acrname     = "poccrukspocu01"
#     clustername = "poc-aks-uks-poc-u-02"
#     rgname      = "poc-rg-uks-poc-u-01"
#   }
# }

appgw = {
  appgw = {
    agw_name                  = "agw-uks-poc-01"
    pip_name                  = "pip-agw-uks-poc--01"
    location                  = "uk south"
    rgname                    = "rg-uks-poc-01"
    gwipconfigname            = "agw-poc-gw"
    vnetname                  = "vnet-uks-poc-02"
    subnet_name               = "snet-uks-agw-poc-02"
    backend_address_pool_name = "pool-default-nginx-80"
    backend_setting_name      = "bp-default-nginx-ingress"
    probe                     = "pb-poc-ui"
    frontend_port_name1       = "port_80"
    # frontend_port_name2            = "port_443"
    frontend_ip_configuration_name = "appGatewayFrontendIP"
    listener_name                  = "poc-listener"
    request_routing_rule_name      = "poc-rule"
    # affinity_cookie_name           = "ApplicationGatewayAffinity"
    # trusted_root_certificate_names = "CER01"
    # gateway_ip_configuration_name = "my-gateway-ip-configuration"
    # wvm_name                      = "vm-cin-aon-p-01"
    # wvm_name2 = "vm-cin-aon-p-02"
    waf_name = "waf-agw-uks-poc-01"
  }
}










