from pathlib import Path
from shutil import rmtree

from datastacks.config import INGEST_TEMPLATE_FOLDER
from datastacks.config_class import IngestConfig
from datastacks.utils import generate_pipeline, render_template_components

from datastacks_tests.unit.template_structures import EXPECTED_FILE_LIST, EXPECTED_DQ_FILE_LIST

def test_render_template_components():
    config_dict = {
        "dataset_name": "test_dataset",
        "pipeline_description": "Pipeline for testing",
        "data_source_type": "test_data_source",
        "key_vault_linked_service_name": "test_keyvault",
        "data_source_password_key_vault_secret_name": "test_password",
        "data_source_connection_string_variable_name": "test_connection_string",
        "ado_variable_groups_nonprod": ["nonprod_test_group"],
        "ado_variable_groups_prod": ["prod_group"],
        "bronze_container": "test_raw"
    }
    config = IngestConfig.parse_obj(config_dict)

    template_source_path = f"de_templates/ingest/Ingest_SourceType_SourceName/"
    target_dir = f"de_workloads/test_render"

    render_template_components(config, template_source_path, target_dir)

    for p in EXPECTED_FILE_LIST:
        assert Path(f"{target_dir}/{p}").exists()

    rmtree(target_dir)


def test_generate_pipeline_no_dq():
    config_path = "datastacks_tests/unit/test_config.yml"
    template_source_folder = INGEST_TEMPLATE_FOLDER
    
    target_dir = generate_pipeline(config_path, False, template_source_folder, "ingest")

    for p in EXPECTED_FILE_LIST:
        assert Path(f"{target_dir}/{p}").exists()

    rmtree(target_dir)


def test_generate_pipeline_dq():
    config_path = "datastacks_tests/unit/test_config.yml"
    template_source_folder = INGEST_TEMPLATE_FOLDER
    
    target_dir = generate_pipeline(config_path, True, template_source_folder, "ingest")

    EXPECTED_FILE_LIST.extend(EXPECTED_DQ_FILE_LIST)

    for p in EXPECTED_FILE_LIST:
        assert Path(f"{target_dir}/{p}").exists()

    rmtree(target_dir)