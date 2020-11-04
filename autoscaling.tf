resource "azurerm_monitor_autoscale_setting" "demo-autoscaling" {
    for_each = var.location
    name = "${var.prefix}-autoscaling-${each.value}"
    resource_group_name = var.resource_group
    location = each.value
    target_resource_id = azurerm_virtual_machine_scale_set.demo_scaleset[each.value].id

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
                metric_resource_id = azurerm_virtual_machine_scale_set.demo_scaleset[each.value].id
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
                metric_resource_id  = azurerm_virtual_machine_scale_set.demo_scaleset[each.value].id
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