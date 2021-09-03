import datetime
from airflow.models.dag import DAG

from airflow.operators.dummy_operator import DummyOperator
from airflow.operators.email_operator import EmailOperator

import logging

""" Test Dag that gets deployed in the actual Prod/Staging env and gets executed as part of CI/CD"""

default_task_args = {
    "owner": "cicd-test",
    "retries": 1,
    "retry_exponential_backoff": True,
    "project_id": "badal-sandbox-309813",
    "start_date": datetime.datetime(2021, 9, 3),
    "email": "zack.amirakulov@badal.io",
}


logging.info("Executing the last step in pipeline: end-to-end-test-ci-cd")

dag = DAG(
    dag_id="send_email",
    description="Test run executed as part of cloud build",
    schedule_interval="@daily",
    catchup=False,
    default_args=default_task_args,
)

done_email = EmailOperator(
    dag=dag,
    default_args=default_task_args,
    task_id="test_email",
    to="zack.amirakulov@badal.io",
    subject="Test Composer Email",
    html_content="""
               <p> Build has been sucessful! </p>
            """,
)

done_all = DummyOperator(dag=dag, task_id="done", default_args=default_task_args)

done_email >> done_all
