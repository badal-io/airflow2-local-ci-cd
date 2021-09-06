#!/bin/bash

# - List DAGs
gcloud beta composer environments run $1 --location=$2 dags list -- -S /home/airflow/gcs/data/test-dags/$3 &> /tmp/Output

# - Store output string in var
cmd_output=$(</tmp/Output)


# - Error matching string
declare -a error_string=("No data found" "Error" "Broken DAG" "No module" "Cannot execute subcommand")
#error_string2='Error'
#error_string3='Broken DAG'
#error_string4='No module'
#error_string5='Cannot execute subcommand'

# - Condifiton to skip to the next step if no error string mathces
for item in "${error_string[@]}"
do
  if [[ "$cmd_output" == *"$item"* ]] # || [[ "$cmd_output" == *"$error_string2"* ]]  || [[ "$cmd_output" == *"$error_string3"* ]] || [[ "$cmd_output" == *"$error_string4"* ]]
  then
    echo " >>>>>  NO DAGS PARSED - see reason(s) below: <<<<<<" && $cmd_output && exit 1
  else
    echo $cmd_output && exit 0
  fi
done
