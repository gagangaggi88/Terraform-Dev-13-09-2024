data "azurerm_web_application_firewall_policy" "waf" {
  for_each = var.appgw
  resource_group_name = each.value.rgname
  name                = each.value.waf_name
}

data "azurerm_subnet" "subnet" {
  for_each             = var.appgw
  name                 = each.value.subnet_name
  virtual_network_name = each.value.vnetname
  resource_group_name  = each.value.rgname
}

resource "azurerm_public_ip" "new_pip" {
  for_each                = var.appgw
  name                    = each.value.pip_name
  resource_group_name     = each.value.rgname
  location                = each.value.location
  allocation_method       = "Static"
  idle_timeout_in_minutes = "4"
  # zones = "1"
  sku = "Standard"
}



resource "azurerm_application_gateway" "appgw" {
  for_each = var.appgw
  name                = each.value.agw_name
  resource_group_name     = each.value.rgname
  location                = each.value.location
  firewall_policy_id = data.azurerm_web_application_firewall_policy.waf[each.key].id
  autoscale_configuration {
    min_capacity = 0
    max_capacity = 2
  }

  sku {
    name     = "WAF_v2"
    tier     = "WAF_v2"
    # capacity = 2
  }

  gateway_ip_configuration {
    name      = each.value.gwipconfigname
    subnet_id = data.azurerm_subnet.subnet[each.key].id
  }

  frontend_port {
    name = each.value.frontend_port_name1
    port = 80
  }

  frontend_ip_configuration {
    name                 = each.value.frontend_ip_configuration_name
    public_ip_address_id = azurerm_public_ip.new_pip[each.key].id
  }

  backend_address_pool {
    name = each.value.backend_address_pool_name
  }

  backend_http_settings {
    name                  = each.value.backend_setting_name
    cookie_based_affinity = "Disabled"
    path                  = "/path1/"
    port                  = 80
    protocol              = "Http"
    request_timeout       = 30
    probe_name = each.value.probe
    
  }

    probe {
    name                = each.value.probe
    protocol            = "Http"
    host                = "127.0.0.1" # Replace with your host
    path                = "/"
    interval            = 30
    timeout             = 30
    unhealthy_threshold = 3
    # pick_host_name_from_backend_http_settings = true
  }

  http_listener {
    name                           = each.value.listener_name
    frontend_ip_configuration_name = each.value.frontend_ip_configuration_name
    frontend_port_name             = each.value.frontend_port_name1
    protocol                       = "Http"
  }

  request_routing_rule {
    name                       = each.value.request_routing_rule_name
    priority                   = 9
    rule_type                  = "Basic"
    http_listener_name         = each.value.listener_name
    backend_address_pool_name  = each.value.backend_address_pool_name
    backend_http_settings_name = each.value.backend_setting_name
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





