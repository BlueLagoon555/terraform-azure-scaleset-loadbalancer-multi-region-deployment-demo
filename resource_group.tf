resource "azurerm_resource_group" "demo_rg" {
   #count = var.region_count
   # name = "${var.prefix}-ASandLB-${var.location[count.index]}"
    name = "${var.prefix}-ASandLB"

    location = "westeurope"
    #location = var.location[count.index]
    
    tags = {
        env = "scale set and load balancer demo"
    }

}