
#############################################################################
# Providers
#############################################################################
terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 2.65"
    }
  }

}
provider "azurerm" {
  features {}
}
#############################################################################
# DATA
#############################################################################
data "azurerm_resource_group" "appservice_rg"{

    name = var.RESOURCE_GROUP
}

#############################################################################
# APP SERVICE PLAN & APP SERVICE & APP SERVICE SLOT
#############################################################################
resource "azurerm_app_service_plan" "app_service_plan" {
  name                = var.APP_SERVICE_PLAN_NAME
  location            = data.azurerm_resource_group.appservice_rg.location
  resource_group_name = data.azurerm_resource_group.appservice_rg.name

  sku {
    tier = var.PLAN_TIER
    size = var.PLAN_SIZE
  }
}


resource "azurerm_app_service" "app_service" {
  name                = var.APP_SERVICE_NAME
  location            = data.azurerm_resource_group.appservice_rg.location
  resource_group_name = data.azurerm_resource_group.appservice_rg.name
  app_service_plan_id = azurerm_app_service_plan.app_service_plan.id

  site_config {
    websockets_enabled       = true
    //dotnet_framework_version = each.value["DOTNET_FRAME_VER"]
    //scm_type                 = each.value["SCM"]
    //min_tls_version          = each.value["MIN_TLS_VER"]
    //dynamic "ip_restriction"{
    //    for_each = each.value["IP_RESTRICTION"]
    //    content{
    //        ip_address = ip_restriction.value
    //    }
    //}
  }

  app_settings = {
    //"APPINSIGHTS_INSTRUMENTATIONKEY"      = "${azurerm_application_insights.this.instrumentation_key}"
    //"APPINSIGHTS_PORTALINFO"              = "ASP.NET"
    //"APPINSIGHTS_PROFILERFEATURE_VERSION" = "1.0.0"
    //"WEBSITE_HTTPLOGGING_RETENTION_DAYS"  = "35"
    "SOME_KEY" = "some-value"
  }
tags = {
    ManagedBy  = "Terraform"
    Team       = var.TEAMNAME

}

}

# resource "azurerm_log_analaytics_workspace" "app_analtics_wkspace"{
#     name  = "${var.APP_SERVICE_NAME}-appanalytics"
#     location            = data.azurerm_resource_group.appservice_rg.location
#     resource_group_name = data.azurerm_resource_group.appservice_rg.name
#     sku       =  "PERGB2018"
    

# }

# resource "azurerm_monitor_diagonstic_setting" "app_diag_settings" {
#     for_each  = var.APP_SERVICES
#     name  = "${var.APP_SERVICE_NAME}_app_diag"
#     target_resource_id = azurerm_app_service.app_service[each.key].id
#     log_analytics_workspace_id = azurerm_log_analaytics_workspace.app_analtics_wkspace.id
#     log {
#         category = "AppServiceAppLogs"
#         enabled  = true
#         retention_policy {
#             enabled = false
#         }
#     }
#     log {
#         category = "AppServiceAuditLogs"
#         enabled  = true
#         retention_policy {
#             enabled = false
#         }
#     }
#     log {
#         category = "AppServiceConsoleLogs"
#         enabled  = true
#         retention_policy {
#             enabled = false
#         }
#     }
#     log {
#         category = "AppServiceFileLogs"
#         enabled  = true
#         retention_policy {
#             enabled = false
#         }
#     }
#     log {
#         category = "AppServiceHttpLogs"
#         enabled  = true
#         retention_policy {
#             enabled = false
#         }
#     }
#     metric {
#         category = "AllMetrics"
#         retention_policy {
#             enabled = false
#         }
#     }
# }

# resource "azurerm_app_service_slot" "app_service_slot" {
#   for_each            = var.APP_SERVICES  
#   name                = each.value["SLOT"]
#   app_service_name    = azurerm_app_service.app_service[each.key].name
#   location            = azurerm_resource_group.appservice_rg.location
#   resource_group_name = azurerm_resource_group.appservice_rg.name
#   app_service_plan_id = azurerm_app_service_plan.appservice_rg.id

#   site_config {
#     dotnet_framework_version = each.value["DOTNET_FRAME_VER"]
#     scm_type                 = each.value["SCM"]
#     min_tls_version          = each.value["MIN_TLS_VER"]
#     dynamic "ip_restriction"{
#         for_each = each.value["IP_RESTRICTION"]
#         content{
#             ip_address = ip_restriction.value
#         }
#     }
#   }

#   app_settings = {
#     "SOME_KEY" = "some-value"
#   }
# tags = {
#     ManagedBy  = "Terraform"
#     Team       = var.TEAMNAME
# }


# }