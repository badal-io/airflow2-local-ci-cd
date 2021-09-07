#!/bin/bash

# - Wait until the DAG is initialized
n=0
until [[ $n -ge $4 ]]
do
  status=0
  gcloud beta composer environments run $1 --location $2 dags list -- -S /home/airflow/gcs/data/test-dags/ 2>&1 | grep $3 && break
  status=$?
  n=$(($n+1))
  sleep $5
done

# - Unpause the DAG if paused
gcloud beta composer environments run $1 --location $2 dags unpause -S /home/airflow/gcs/data/test-dags/ -- $3

# - Run the DAG "semd_email". The email contains commit ID.
gcloud beta composer environments run $1 --location $2 dags trigger -S /home/airflow/gcs/data/test-dags/ -- $3 --conf '{"key":"'${6}'"}'

exit $status
