resource "random_uuid" "deployment" {
}

resource "azurerm_resource_group_template_deployment" "pipeline_Get_Ingest_Config" {
  name                = "Get_Ingest_Config-${random_uuid.deployment.result}"
  resource_group_name = var.data_factory_resource_group_name
  deployment_mode     = "Incremental"
  parameters_content = jsonencode({
    "factoryName" = {
      value = data.azurerm_data_factory.factory.name
    }
  })
  template_content = file("${path.module}/pipelines/Get_Ingest_Config.json")
  depends_on = [
    azurerm_data_factory_dataset_json.ds_dp_ConfigStore_Json
  ]
}

resource "azurerm_resource_group_template_deployment" "pipeline_Generate_Ingest_Query" {
  name                = "Generate_Ingest_Query-${random_uuid.deployment.result}"
  resource_group_name = var.data_factory_resource_group_name
  deployment_mode     = "Incremental"
  parameters_content = jsonencode({
    "factoryName" = {
      value = data.azurerm_data_factory.factory.name
    }
  })
  template_content = file("${path.module}/pipelines/Generate_Ingest_Query.json")
}