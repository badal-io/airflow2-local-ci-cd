ARG AIRFLOW_IMAGE_NAME="2.1.1-python3.8"

FROM "apache/airflow:${AIRFLOW_IMAGE_NAME}"

#Install GCP util
RUN curl -sSL https://sdk.cloud.google.com | bash
ENV PATH $PATH:/home/airflow/google-cloud-sdk/bin

# INSTALL TOOLS & DEPENDENCIES
COPY requirements-airflow.txt requirements.txt
RUN pip3 install --no-cache-dir -r requirements.txt

#COPY airflow.cfg ${AIRFLOW_HOME}/airflow.cfg
