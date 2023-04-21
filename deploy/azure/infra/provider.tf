terraform {
  backend "azurerm" {
  }
}

provider "azurerm" {
  features {}
}

provider "databricks" {
  host                        = module.adb.databricks_hosturl
  azure_workspace_resource_id = module.adb.adb_databricks_id

  # ARM_USE_MSI environment variable is recommended
  azure_use_msi = true

}
