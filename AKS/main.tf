data "azurerm_subnet" "subnet" {
  for_each             = var.aks
  name                 = each.value.subnet_name
  virtual_network_name = each.value.vnetname
  resource_group_name  = each.value.rgname
}

resource "azurerm_container_registry" "acr" {
  for_each = var.aks
  name                = each.value.acrname
  resource_group_name = each.value.rgname
  location            = each.value.location
  sku                 = each.value.skuname
  admin_enabled       = false
  
  tags                                = {
        "Deployment Name"  = "IaC POC"
        "Deployment Owner" = "Rajiv Tanwar"
        "Backup"            = "No"
        "Creation Date"     = "09-Aug-2024"
        "Environment"       = "Uat"
        "SLA"               = "INS_SCR_001"
    }
}

data "azurerm_application_gateway" "appgw" {
  for_each = var.aks
  name                = each.value.appgwname
  resource_group_name = each.value.rgname
}
# resource "azurerm_container_registry_task" "acr_tsk" {
#   for_each = var.aks
#   name                  = each.value.acr_tsk_name
#   container_registry_id = resource.azurerm_container_registry.acr[each.key].id
#   is_system_task = false
#   platform {
#     os = "Linux"
#     }
#   agent_setting {
#     cpu = 2
#   }
#     # }
#         tags                                = {
#         "Deployment Name"  = "IaC POC"
#         "Deployment Owner" = "Rajiv Tanwar"
#         "Backup"            = "No"
#         "Creation Date"     = "09-Aug-2024"
#         "Environment"       = "Uat"
#         "SLA"               = "INS_SCR_001"
#     }
#   # docker_step {
#   #   dockerfile_path      = "Dockerfile"
#   #   context_path         = "https://github.com/<username>/<repository>#<branch>:<folder>"
#   #   context_access_token = "<github personal access token>"
#   #   image_names          = ["helloworld:{{.Run.ID}}"]
#   # }
# }

resource "azurerm_kubernetes_cluster" "aks" {
  for_each = var.aks
  name                = each.value.clustername
  location            = each.value.location
  resource_group_name = each.value.rgname
  dns_prefix          = each.value.dnsprefixname

  default_node_pool {
    name            = each.value.nodename
    node_count      = 1
    vm_size         = each.value.vmsize
    os_disk_size_gb = 30
    # enable_auto_scaling = false
    min_count = 1
    max_count = 3
    vnet_subnet_id  = data.azurerm_subnet.subnet[each.key].id  # Use the subnet ID from the data source
    auto_scaling_enabled = true
  }

  identity {
    type = "SystemAssigned"
  }
  network_profile {
    network_plugin    = "azure"
    service_cidr      = "10.0.0.0/16"
    dns_service_ip    = "10.0.0.10"
    # docker_bridge_cidr = "172.17.0.1/16"
  }

  ingress_application_gateway {
    gateway_id = data.azurerm_application_gateway.appgw[each.key].id
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

resource "azurerm_managed_disk" "aks_dsk" {
  for_each = var.aks
  name                 = each.value.dsk_name
  location            = each.value.location
  resource_group_name = each.value.rgname
  storage_account_type = "StandardSSD_LRS"
  disk_size_gb         = 512
  create_option        = "Empty"
  os_type = "Linux"
  
  
  tags                                = {
        "Deployment Name"  = "IaC POC"
        "Deployment Owner" = "Rajiv Tanwar"
        "Backup"            = "No"
        "Creation Date"     = "09-Aug-2024"
        "Environment"       = "Uat"
        "SLA"               = "INS_SCR_001"
    }
  }

resource "azurerm_role_assignment" "aks_acr_pull" {
  for_each = var.aks
  principal_id                     = resource.azurerm_kubernetes_cluster.aks[each.key].kubelet_identity[0].object_id
  role_definition_name             = "AcrPull"
  scope                            = resource.azurerm_container_registry.acr[each.key].id
  skip_service_principal_aad_check = true
}