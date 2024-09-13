terraform {
  required_providers {
    azurerm = {
      source = "hashicorp/azurerm"
      # version = "3.5"
    }
  }
  #   backend "azurerm" {
  #     resource_group_name  = "poc-rg-ae-dtu-u-01"
  #     storage_account_name = "pocstrgdtuu02"
  #     container_name       = "state-storage"
  #     key                  = "UAT/shareresources.tfstate"

  #   }

}

provider "azurerm" {
  subscription_id = "c687f2d5-fcab-4d21-82be-cec73ad7549f"
  # skip_provider_registration = true # This is only required when the User, Service Principal, or Identity running Terraform lacks the permissions to register Azure Resource Providers.
  features {}
}