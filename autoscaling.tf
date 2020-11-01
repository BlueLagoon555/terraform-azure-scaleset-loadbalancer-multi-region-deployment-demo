



resource "azurerm_monitor_autoscale_setting" "demo-autoscaling" {
    name = "${var.prefix}-autoscaling-${var.location[count.index]}"
    resource_group_name = azurerm_resource_group.demo_rg.name
    #location = var.location
    count = var.region_count
    location = var.location[count.index]
    target_resource_id = azurerm_virtual_machine_scale_set.demo_scaleset[count.index].id

    profile {
        name = "default_profile"

        capacity {
            default = 2
            minimum = 2
            maximum = 4
        }

        rule {

            metric_trigger {
                metric_name = "Pertcentage CPU"
                metric_resource_id = azurerm_virtual_machine_scale_set.demo_scaleset[count.index].id
                time_grain = "PT1M"
                statistic = "Average"
                time_window = "PT5M"
                time_aggregation = "Average"
                operator = "GreaterThan"
                threshold = 40
            }

            scale_action {
                direction = "Increase"
                type = "Changecount"
                value = "1"
                cooldown = "PT1M"
            }
        }

        rule {

            metric_trigger {
                metric_name         = "Percentage CPU"
                metric_resource_id  = azurerm_virtual_machine_scale_set.demo_scaleset[count.index].id
                time_grain          = "PT1M"
                statistic           = "Average"
                time_window         = "PT5M"
                time_aggregation    = "Average"
                operator            = "LessThan"
                threshold           = 10
            }

            scale_action {
                direction = "Decrease"
                type = "Changecount"
                value = "1"
                cooldown = "PT1M"
            }
        }
    }
}