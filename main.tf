provider "azurerm" {
}

terraform {
    backend "azurerm" {
        resource_group_name  = "backend_rg"
        storage_account_name = "backend_sa"
        container_name       = "backend_cn"
        key                  = "terraform.tfstate"
    }
}

resource "azurerm_resource_group" Harrods-rg-1 {
  name = "Harrods-rg"
  location = var.location
}


resource "azurerm_container_group" "Harrod-cn-1" {
  name                      = "Harrod-cn-1"
  location                  = azurerm_resource_group.Harrods-rg-1.location
  resource_group_name       = azurerm_resource_group.Harrods-rg-1.name

  ip_address_type     = "public"
  dns_name_label      = "harrodswebapp"
  os_type             = "Linux"

  container {
      name            = "Harrods"
      image           = "docker-repo/image:${var.buildno}"
        cpu             = "1"
        memory          = "1"

        ports {
            port        = 80
            protocol    = "TCP"
        }
  }
}