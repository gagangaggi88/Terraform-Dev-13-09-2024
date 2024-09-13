data "azurerm_subnet" "subnet" {
  for_each = var.virtual_machine
  name                 = each.value.snet
  virtual_network_name = each.value.vnet
  resource_group_name  = each.value.rgname
}

data "azurerm_key_vault" "keyvault" {
  for_each = var.virtual_machine
  name                = each.value.kvname
  resource_group_name = each.value.rgname
}

data "azurerm_key_vault_secret" "keyvaultsecret" {
  for_each = var.virtual_machine
  name         = each.value.kvsuname
  key_vault_id = data.azurerm_key_vault.keyvault[each.key].id
}
data "azurerm_key_vault_secret" "keyvaultsecret1" {
  for_each = var.virtual_machine
  name         = each.value.kvspname
  key_vault_id = data.azurerm_key_vault.keyvault[each.key].id
}

resource "azurerm_public_ip" "publicip" {
  for_each            = var.virtual_machine
  name                = each.value.pip
  resource_group_name = each.value.rgname
  location            = each.value.location
  allocation_method   = each.value.allocation_method
}

resource "azurerm_network_interface" "nic" {
  for_each            = var.virtual_machine
  name                = each.value.nic_name
  resource_group_name = each.value.rgname
  location            = each.value.location

  ip_configuration {
    name                          = "internal"
    subnet_id                     = data.azurerm_subnet.subnet[each.key].id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.publicip[each.key].id
  }
}

resource "azurerm_network_security_group" "nsg" {
  for_each            = var.virtual_machine
  name                = each.value.nsg
  resource_group_name = each.value.rgname
  location            = each.value.location

  security_rule {
    name                       = "RDP"
    priority                   = 300
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    # source_address_prefixes = ["10.0.0.0/16", "192.168.1.0/24"]
    source_port_range          = "*"
    destination_port_range     = "3389" # RDP port
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }

  # security_rule {
  #   name                       = "HTTPS"
  #   priority                   = 1002
  #   direction                  = "Inbound"
  #   access                     = "Allow"
  #   protocol                   = "Tcp"
  #   source_port_range          = "*"
  #   destination_port_range     = "443" # HTTPS port
  #   source_address_prefix      = "*"
  #   destination_address_prefix = "*"
  # }
}

resource "azurerm_windows_virtual_machine" "wvm" {
  for_each            = var.virtual_machine
  name                = each.value.vm_name
  resource_group_name = each.value.rgname
  location            = each.value.location
  size                = each.value.vmsize
  admin_username      = data.azurerm_key_vault_secret.keyvaultsecret[each.key].value
  admin_password      = data.azurerm_key_vault_secret.keyvaultsecret1[each.key].value
  network_interface_ids = [
    azurerm_network_interface.nic[each.key].id,
  ]

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "StandardSSD_LRS"
  }

  source_image_reference {
    publisher = "MicrosoftWindowsServer"
    offer     = "WindowsServer"
    sku       = "2019-datacenter-gensecond"
    version   = "latest"
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