terraform {
  required_providers {
    azurerm = {
      source = "hashicorp/azurerm"
      # version = "3.5"
    }
  }
    backend "azurerm" {
      resource_group_name  = "Kali_group"
      storage_account_name = "xcterraformmanagement01"
      container_name       = "xc-tf-file"
      key                  = "UAT/shareresources.tfstate"

    }

}

provider "azurerm" {
  subscription_id = "307d9660-0ddb-42c6-a9a2-7a4abf960353"
  # skip_provider_registration = true # This is only required when the User, Service Principal, or Identity running Terraform lacks the permissions to register Azure Resource Providers.
  features {}
}