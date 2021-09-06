from airflow.operators.email import EmailOperator
from datetime import datetime, timedelta
from airflow import DAG

default_args = {
    "owner": "badal.io",
    "depends_on_past": False,
    "email_on_failure": False,
    "email_on_retry": False,
    "retries": 1,
    "retry_delay": timedelta(minutes=5),
}
with DAG(
    "send_email",
    default_args=default_args,
    description="Email notification DAG",
    schedule_interval=timedelta(days=1),
    start_date=datetime(2021, 9, 3),
    catchup=False,
) as dag:
    send_email_notification = EmailOperator(
        task_id="send_email",
        to="zack.amirakulov@badal.io",
        subject="Build status notification",
        html_content=" <h2> The pipeline build for environment '{{ dag_run.conf['env'] }}' with commit ID: '{{ dag_run.conf['commit'] }}' on '{{ dag_run.conf['branch'] }}' has been successful! </h2>",
    )
