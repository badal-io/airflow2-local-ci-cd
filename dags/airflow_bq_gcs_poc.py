import csv
import datetime
import io
import logging

import airflow
from airflow import models

try:
    from airflow.providers.google.cloud.transfers.gcs_to_bigquery import (
        GCSToBigQueryOperator,
    )
except ImportError:
    pass

if GCSToBigQueryOperator is not None:
    yesterday = datetime.datetime.now() - datetime.timedelta(days=1)

    default_args = {
        "owner": "Airflow-Badal",
        "start_date": airflow.utils.dates.days_ago(1),
        "depends_on_past": False,
        "email": [""],
        "email_on_failure": True,
        "email_on_retry": False,
        "retries": 1,
        "retry_delay": datetime.timedelta(minutes=5),
    }

    dag = models.DAG(
        dag_id="example_gcs_to_bq_operator",
        default_args=default_args,
        schedule_interval=None,
    )

    load_csv = GCSToBigQueryOperator(
        task_id="gcs_to_bq_example",
        bucket="airflow-datasets-poc",
        source_objects=["bigquery/raw_measurements.csv"],
        destination_project_dataset_table="airflow_test.gcs_to_bq_table",
        schema_fields=[
            {"name": "timestamp", "type": "STRING", "mode": "NULLABLE"},
            {"name": "device_id", "type": "STRING", "mode": "NULLABLE"},
            {"name": "property_measured", "type": "STRING", "mode": "NULLABLE"},
            {"name": "value", "type": "STRING", "mode": "NULLABLE"},
            {"name": "units_of_measurement", "type": "STRING", "mode": "NULLABLE"},
            {"name": "device_version", "type": "STRING", "mode": "NULLABLE"},
        ],
        write_disposition="WRITE_TRUNCATE",
        create_disposition="CREATE_IF_NEEDED",
        skip_leading_rows=1,
        dag=dag,
    )

    load_csv
