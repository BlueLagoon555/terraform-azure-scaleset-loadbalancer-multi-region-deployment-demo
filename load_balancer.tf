

resource "azurerm_lb" "demo-lb" {
    for_each = var.location
    name = "${var.prefix}-lb-${each.value}"
    location = each.value
    resource_group_name = var.resource_group
    sku = length(var.zones) == 0 ? "Basic" : "Standard"

    frontend_ip_configuration {
        name = "PublicIPAddress"
        public_ip_address_id = azurerm_public_ip.demo_public_ip[each.key].id
    }
    
}

resource "azurerm_public_ip" "demo_public_ip" {
    for_each = var.location
    name = "${var.prefix}-public-ip-${each.value}"
    location = each.value
    resource_group_name = var.resource_group
    allocation_method = "Static"
    sku = length(var.zones) == 0 ? "Basic" : "Standard"
}

resource "azurerm_lb_backend_address_pool" "lb_be_pool" {
    for_each = var.location
    name = "${var.prefix}-lb-be-pool-${each.value}"
    resource_group_name = var.resource_group
    loadbalancer_id = azurerm_lb.demo-lb[each.key].id
}

resource "azurerm_lb_nat_pool" "lb_nat_pool" {
    for_each = var.location
    name = "${var.prefix}-lb-nat-pool-${each.value}"
    resource_group_name = var.resource_group
    loadbalancer_id = azurerm_lb.demo-lb[each.key].id
    protocol = "tcp"
    frontend_port_start = 50000
    frontend_port_end = 50119
    backend_port = 22
    frontend_ip_configuration_name = "PublicIPAddress"
}

resource "azurerm_lb_probe" "lb_probe" {
    for_each = var.location
    name = "${var.prefix}-lb-probe-${each.value}"
    resource_group_name = var.resource_group
    loadbalancer_id = azurerm_lb.demo-lb[each.key].id
    protocol = "http"
    request_path = "/"
    port = 80
}

resource "azurerm_lb_rule" "lb_rule" {
    for_each = var.location
    name = "${var.prefix}-lb-rule-${each.value}"
    resource_group_name = var.resource_group
    loadbalancer_id = azurerm_lb.demo-lb[each.value].id
    protocol = "tcp"
    frontend_port = 80
    backend_port = 80
    frontend_ip_configuration_name = "PublicIPAddress"
    probe_id = azurerm_lb_probe.lb_probe[each.value].id
    backend_address_pool_id = azurerm_lb_backend_address_pool.lb_be_pool[each.value].id
}

