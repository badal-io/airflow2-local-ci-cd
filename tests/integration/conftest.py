import os
import pytest

from datetime import datetime

from airflow.models import TaskInstance
from airflow import DAG
from airflow.utils.dates import days_ago
from airflow.utils import db
from airflow.models import DagBag

from pytest_testconfig import config

from airflow.contrib.hooks.gcp_api_base_hook import GoogleCloudBaseHook
from airflow.utils.state import State


@pytest.fixture(scope="session")
def test_dag():
    return DAG(dag_id="testdag", start_date=datetime.now())


def run_task(task):
    ti = TaskInstance(task=task, execution_date=datetime.now())
    task.execute(ti.get_template_context())
