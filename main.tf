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
data "azurerm_resource_group" "rg"{

    name = var.resource_group_name
}

resource "azurerm_mysql_server" "mysql" {
  name                = var.mysql_server_name
  location            = data.azurerm_resource_group.rg.location
  resource_group_name = data.azurerm_resource_group.rg.name

  administrator_login          = var.admin_name
  administrator_login_password = var.admin_password

  sku_name   = var.sku_name
  storage_mb = var.storage_mb
  version    = var.mysql_version

  auto_grow_enabled                 = true
  backup_retention_days             = 7
  geo_redundant_backup_enabled      = false
  infrastructure_encryption_enabled = false
  public_network_access_enabled     = true
  ssl_enforcement_enabled           = true
  ssl_minimal_tls_version_enforced  = "TLS1_2"
}

resource "azurerm_mysql_database" "mysqldb" {
  name                = var.mysql_db_name
  resource_group_name = data.azurerm_resource_group.rg.name
  server_name         = var.mysql_server_name
  charset             = var.charset
  collation           = var.collation
}