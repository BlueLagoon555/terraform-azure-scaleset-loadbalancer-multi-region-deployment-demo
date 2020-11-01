


resource "azurerm_virtual_network" "demo_vnet" {
    name = "${var.prefix}-vnet-${var.location[count.index]}"
    count = var.region_count
    #location = var.location
    location = var.location[count.index]
    resource_group_name = azurerm_resource_group.demo_rg.name
    address_space = ["10.0.0.0/16"]
}

resource "azurerm_subnet" "demo_subnet" {
    name = "${var.prefix}-subnet-${var.location[count.index]}"
    #location = var.location
    count = var.region_count
    virtual_network_name = azurerm_virtual_network.demo_vnet[count.index].name
    resource_group_name = azurerm_resource_group.demo_rg.name
    address_prefixes = ["10.0.0.0/24"]
}

resource "azurerm_network_security_group" "demo_nsg" {
    name = "${var.prefix}-nsg-${var.location[count.index]}"
    #location = var.location
    count = var.region_count
    location = var.location[count.index]
    resource_group_name = azurerm_resource_group.demo_rg.name

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