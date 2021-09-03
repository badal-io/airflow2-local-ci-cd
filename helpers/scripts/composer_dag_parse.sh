#!/bin/bash

# - List DAGs

gcloud beta composer environments run $1 --location=$2 dags list -- -S /home/airflow/gcs/data/test-dags/$3 1> /tmp/Output

# - Store output string in var
cmd_output=$(</tmp/Output)


# - Error matching string
error_string1='No data found'
error_string2='Error'
error_string3='Broken DAG'
error_string4='No module'

# - Condifiton to skip to the next step if no error string mathces
if [[ "$cmd_output" == *"$error_string1"* ]] || [[ "$cmd_output" == *"$error_string2"* ]]  || [[ "$cmd_output" == *"$error_string3"* ]] || [[ "$cmd_output" == *"$error_string4"* ]]
then
  echo " >>>>>  NO DAGS PARSED - see reason(s) below: <<<<<<" && $cmd_output && exit 1
else
  echo $cmd_output && exit 0
fi
