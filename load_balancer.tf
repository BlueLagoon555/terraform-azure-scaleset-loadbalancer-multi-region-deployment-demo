

resource "azurerm_lb" "demo-lb" {
    name = "${var.prefix}-lb-${var.location[count.index]}"
    #location = var.location
    count = var.region_count
    location = var.location[count.index]
    resource_group_name = azurerm_resource_group.demo_rg.name
    sku = length(var.zones) == 0 ? "Basic" : "Standard"

    frontend_ip_configuration {
        name = "PublicIPAddress"
        public_ip_address_id = azurerm_public_ip.demo_public_ip[count.index].id
    }
    
}

resource "azurerm_public_ip" "demo_public_ip" {
    name = "${var.prefix}-public-ip-${var.location[count.index]}"
    #location = var.location
    count = var.region_count
    location = var.location[count.index]
    resource_group_name = azurerm_resource_group.demo_rg.name
    allocation_method = "Static"
    #domain_name_label = azurerm_resource_group.demo_rg.name
    sku = length(var.zones) == 0 ? "Basic" : "Standard"
}

resource "azurerm_lb_backend_address_pool" "lb_be_pool" {
    name = "${var.prefix}-lb-be-pool-${var.location[count.index]}"
    count = var.region_count
    resource_group_name = azurerm_resource_group.demo_rg.name
    loadbalancer_id = azurerm_lb.demo-lb[count.index].id
}

resource "azurerm_lb_nat_pool" "lb_nat_pool" {
    name = "${var.prefix}-lb-nat-pool-${var.location[count.index]}"
    count = var.region_count
    resource_group_name = azurerm_resource_group.demo_rg.name
    loadbalancer_id = azurerm_lb.demo-lb[count.index].id
    protocol = "tcp"
    frontend_port_start = 50000
    frontend_port_end = 50119
    backend_port = 22
    frontend_ip_configuration_name = "PublicIPAddress"
}

resource "azurerm_lb_probe" "lb_probe" {
    name = "${var.prefix}-lb-probe-${var.location[count.index]}"
    count = var.region_count
    resource_group_name = azurerm_resource_group.demo_rg.name
    loadbalancer_id = azurerm_lb.demo-lb[count.index].id
    protocol = "http"
    request_path = "/"
    port = 80
}

resource "azurerm_lb_rule" "lb_rule" {
    name = "${var.prefix}-lb-rule-${var.location[count.index]}"
    count = var.region_count
    resource_group_name = azurerm_resource_group.demo_rg.name
    loadbalancer_id = azurerm_lb.demo-lb[count.index].id
    protocol = "tcp"
    frontend_port = 80
    backend_port = 80
    frontend_ip_configuration_name = "PublicIPAddress"
    probe_id = azurerm_lb_probe.lb_probe[count.index].id
    backend_address_pool_id = azurerm_lb_backend_address_pool.lb_be_pool[count.index].id
}