resource "azurerm_data_factory_pipeline" "pipeline_Get_Ingest_Config" {
  name                = "Get_Ingest_Config"
  resource_group_name = var.resource_group_name
  data_factory_name   = var.adf_account_name
  activities_json     = file("${path.module}/pipelines/Get_Ingest_Config.json")
  description         = "Retrieve ingest config from the config store for the specified data source."
  folder              = "Utilities"
  parameters = {
    config_container = "config",
    config_path      = "ingest_sources",
    config_file      = ""
  }
  depends_on = [
    azurerm_data_factory_dataset_json.ds_dp_ConfigStore_Json
  ]
}

resource "azurerm_data_factory_pipeline" "pipeline_Generate_Ingest_Query" {
  name                = "Generate_Ingest_Query"
  resource_group_name = var.resource_group_name
  data_factory_name   = var.adf_account_name
  activities_json     = file("${path.module}/pipelines/Generate_Ingest_Query.json")
  description         = "Generate an ingest query from the provided ingest entity configuration."
  folder              = "Utilities"
  parameters = {
    ingest_entity_config = "", # this param was previously Object type, may need converting in ADF
    window_start         = "",
    window_end           = ""
  }
  variables = {
    query = ""
  }
}