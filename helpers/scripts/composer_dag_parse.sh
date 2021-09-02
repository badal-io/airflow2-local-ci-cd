#!/bin/bash

# - List DAGs

gcloud beta composer environments run $1 --location=$2 dags list -- -S /home/airflow/gcs/data/test-dags/$3 2> /tmp/Output

# - Store the rror string in var
cmd_output=$(</tmp/Output)


# - Error matching string to skip to the next step
error_string1='No data found'

# - Condifiton to skip to the next step if the error string mathces
if [[ "$cmd_output" == *"$error_string1"* ]]
then
  echo " >>>>>  NO DAGS PARSED <<<<<<" && exit 1
else
  echo $cmd_output && exit 0
fi
