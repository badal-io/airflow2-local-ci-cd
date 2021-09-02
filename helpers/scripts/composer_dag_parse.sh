#!/bin/bash

# - List DAGs

gcloud beta composer environments run $1 --location=$2 dags list -- -S /home/airflow/gcs/plugins 1> /tmp/Output

# - Store the command output string in var
cmd_output=$(</tmp/Output)


# - Error matching string
error_string1='No data found'

# - Condifiton to skip to the next step if no error string mathces
if [[ "$cmd_output" == *"$error_string1"* ]]
then
  echo " >>>>>  NO DAGS PARSED <<<<<<" && exit 1
else
  echo $cmd_output && exit 0
fi
