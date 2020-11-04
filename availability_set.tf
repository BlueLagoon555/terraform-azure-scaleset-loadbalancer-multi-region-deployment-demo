
resource "azurerm_availability_set" "avset" {
  for_each = var.location
  name                = "demo-avset-${each.value}"
  location = each.value
  resource_group_name = var.resource_group

  platform_fault_domain_count = 2
  
  platform_update_domain_count = 2

  managed = true

  tags = {
    environment = var.env_name
  }
}