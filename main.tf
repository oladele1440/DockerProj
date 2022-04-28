# Create a Resource Group
resource "azurerm_resource_group" "appservice-rg" {
  name = "${var.app_name}-${var.environment}-rg"
  location = var.location
 
  tags = {
    owner = var.owner
    environment = var.environment
  }
}

# Create app service plan
resource "azurerm_app_service_plan" "service-plan" {
  name = "${var.app_name}-${var.environment}_SP"
  location = azurerm_resource_group.appservice-rg.location
  resource_group_name = azurerm_resource_group.appservice-rg.name
  kind = "Linux"
  reserved = true
 
  sku {
    tier = "Basic"
    size = "B1"
  }
 
  tags = {
    owner = var.owner
    environment = var.environment
  }
}

# Create app service
resource "azurerm_app_service" "app-service" {
  name = "${var.app_name}-AppService"
  location = azurerm_resource_group.appservice-rg.location
  resource_group_name = azurerm_resource_group.appservice-rg.name
  app_service_plan_id = azurerm_app_service_plan.service-plan.id  
 
  site_config {
    linux_fx_version = "DOCKER|${var.docker_image}:${var.docker_image_tag}"
  }
 
  app_settings = {
    "WEBSITES_PORT" = var.app_port
  }
 
  tags = {
    owner = var.owner
    environment = var.environment
  }
}

resource "azurerm_container_registry" "acr" {
  name                = "${var.app_name}acr01"
  resource_group_name = azurerm_resource_group.appservice-rg.name
  location            = azurerm_resource_group.appservice-rg.location
  sku                 = "Standard"
  admin_enabled       = true
    tags                    = {
        owner = var.owner
        environment = var.environment
    }
    }
    resource "azurerm_storage_account" "app-service-storage" {
      name                = "${var.app_name}storage01"
      resource_group_name = azurerm_resource_group.appservice-rg.name
      location            = azurerm_resource_group.appservice-rg.location
      account_tier        = "Standard"
      account_replication_type = "LRS"
        tags                    = {
            owner = var.owner
            environment = var.environment
        }
    }
resource "azurerm_mssql_server" "app-service-sql" {
  name                         = "${var.app_name}sql01"
  resource_group_name          = azurerm_resource_group.appservice-rg.name
  location                     = azurerm_resource_group.appservice-rg.location
  version                      = "12.0"
  administrator_login          = "azureadmin"
  administrator_login_password = "Azure@123"
  minimum_tls_version          = "1.2"
  tags = {
    owner = var.owner
    environment = var.environment
  }
}
resource "azurerm_mssql_database" "rightgates-db" {
  name           = "${var.app_name}db01"
  server_id      = azurerm_mssql_server.app-service-sql.id
  collation      = "SQL_Latin1_General_CP1_CI_AS"
  license_type   = "LicenseIncluded"
  max_size_gb    = 4
  read_scale     = true
  sku_name       = "BC_Gen5_2"
  zone_redundant = true
  tags = {
    owner = var.owner
    environment = var.environment
  }
}
resource "azurerm_mssql_firewall_rule" "rightgates-firewall" {
  name             = "${var.app_name}firewall01"
  server_id        = azurerm_mssql_server.app-service-sql.id
  start_ip_address = "0.0.0.0"
  end_ip_address   = "0.0.0.0"
    
}
