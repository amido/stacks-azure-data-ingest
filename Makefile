setup_dev_environment:
	echo "PYTHONPATH=." > .env
	poetry install
	poetry self add poetry-dotenv-plugin
	poetry run pre-commit install

test:
	poetry run python -m pytest de_workloads/ingest/ingest_azure_sql_example/tests/unit
	poetry run python -m pytest de_workloads/processing/silver_movies_example/tests/unit
	poetry run python -m pytest de_workloads/processing/silver_movies_example_with_data_quality/tests/unit
	poetry run python -m pytest de_workloads/processing/gold_movies_example/tests/unit
	poetry run python -m pytest datastacks/tests/unit

test_e2e:
	poetry run behave de_workloads/ingest/ingest_azure_sql_example/tests/end_to_end/features/azure_data_ingest.feature
	poetry run behave de_workloads/shared_resources/tests/end_to_end/features/shared_resources.feature

pre_commit:
	poetry run pre-commit run --all-files
