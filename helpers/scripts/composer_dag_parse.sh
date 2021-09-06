#!/bin/bash

# - List DAGs
#gcloud beta composer environments run $1 --location=$2 dags list -- -S /home/airflow/gcs/plugins/test-dags/$3 1> /tmp/Output
gcloud beta composer environments run $1 --location=$2 dags list -- -S /home/airflow/gcs/plugins/test-dags/$3 >> /tmp/Output 2>&1

# - Store output string in var
cmd_output=$(</tmp/Output)


# - Error matching string
error_string1='No data found'
error_string2='Error'
error_string3='Broken DAG'
error_string4='No module'
error_string5='Cannot execute subcommand'

# - Condifiton to skip to the next step if no error string mathces
if [[ "$cmd_output" == *"$item"* ]] || \
   [[ "$cmd_output" == *"$error_string2"* ]] || \
   [[ "$cmd_output" == *"$error_string3"* ]] || \
   [[ "$cmd_output" == *"$error_string4"* ]] || \
   [[ "$cmd_output" == *"$error_string5"* ]]
then
  echo " >>>>>  NO DAGS PARSED - see reason(s) below: <<<<<<" && $cmd_output && exit 1
else
  echo $cmd_output && exit 0
fi
done
