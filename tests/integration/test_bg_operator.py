import pytest

from airflow.providers.google.cloud.operators.bigquery import (
    BigQueryDeleteTableOperator,
    BigQueryCreateEmptyTableOperator,
)

from pytest_testconfig import config

from tests.integration.conftest import run_task


def test_create_table(test_dag):
    new_table = BigQueryCreateEmptyTableOperator(
        task_id="create_mock_table",
        project_id=config["gcp"]["project_id"],
        dataset_id=config["bq"]["dataset"],
        table_id=config["bq"]["data_table_name"],
        dag=test_dag,
    )
    run_task(new_table)


def test_delete_table(test_dag):
    delete_table = BigQueryDeleteTableOperator(
        task_id="delete_mock_table",
        deletion_dataset_table=f"{config['gcp']['project_id']}.{config['bq']['dataset']}.{config['bq']['data_table_name']}",
        ignore_if_missing=False,
        dag=test_dag,
    )
    run_task(delete_table)
