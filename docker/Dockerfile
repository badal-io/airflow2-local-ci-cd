FROM python:3.8

USER root

RUN apt update && pip install -U pip
RUN apt install -y --no-install-recommends \
        freetds-bin \
        krb5-user \
        ldap-utils \
        libffi6 \
        libsasl2-2 \
        libsasl2-modules \
        libssl1.1 \
        locales  \
        lsb-release \
        sasl2-bin \
        sqlite3 \
        unixodbc

ENV AIRFLOW_VERSION=2.1.1
ENV PYTHON_VERSION='$(python --version | cut -d " " -f 2 | cut -d "." -f 1-2)'

ENV CONSTRAINT_URL='https://raw.githubusercontent.com/apache/airflow/constraints-${AIRFLOW_VERSION}/constraints-${PYTHON_VERSION}.txt'

RUN pip install 'apache-airflow[async,postgres,google]==${AIRFLOW_VERSION}" --constraint "${CONSTRAINT_URL}'

COPY requirements-airflow.txt .
RUN pip install -r requirements-airflow.txt

ENV PATH=$PATH:~/.local/bin