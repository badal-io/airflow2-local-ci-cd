import os
import pytest

from airflow import DAG
from airflow.utils.dates import days_ago
from airflow.models import DagBag

from airflow.models import Variable

from pytest_testconfig import config

import logging

DAGS_FOLDER = "/opt/airflow/dags"


def get_test_dag_bag():
    return DagBag(dag_folder=DAGS_FOLDER, include_examples=False)


@pytest.fixture(scope="session")
def test_dag_bag():
    return get_test_dag_bag()


@pytest.fixture
def dag():
    default_args = {"owner": "airflow", "start_date": days_ago(1)}
    return DAG("test_dag", default_args=default_args, schedule_interval="@daily")

def pytest_sessionfinish(session, exitstatus):
  if exitstatus == 5:
    session.exitstatus = 0
