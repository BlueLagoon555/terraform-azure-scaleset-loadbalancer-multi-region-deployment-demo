

resource "azurerm_virtual_network" "demo_vnet" {
    for_each = var.location
    name = "${var.prefix}-vnet-${each.value}"
    location = each.value
    resource_group_name = var.resource_group
    address_space = ["10.0.0.0/16"]
}

resource "azurerm_subnet" "demo_subnet" {
    for_each = var.location
    name = "${var.prefix}-subnet-${each.value}"
    virtual_network_name = azurerm_virtual_network.demo_vnet[each.key].name
    resource_group_name = var.resource_group
    address_prefixes = ["10.0.0.0/24"]
}

resource "azurerm_network_security_group" "demo_nsg" {
    for_each = var.location
    name = "${var.prefix}-nsg-${each.value}"
    location = each.value
    resource_group_name = var.resource_group

    security_rule {
        name = "HTTP"
        priority = 100
        direction = "Inbound"
        access = "Allow"
        protocol = "Tcp"
        source_port_range = "*"
        destination_port_range = "80"
        source_address_prefix = "*"
        destination_address_prefix = "*"

    }

    security_rule {
        name = "SSH"
        priority = 101
        direction = "Inbound"
        access = "Allow"
        protocol = "Tcp"
        source_port_range = "*"
        destination_port_range = "22"
        source_address_prefix = var.ssh-source-address
        destination_address_prefix = "*"
    }
}