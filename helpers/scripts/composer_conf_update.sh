#!/bin/bash

# - Update Airflow configurtion
#gcloud composer environments update $1 --location=$2 $3=$(tr -d "\n\r" < $4) || exit 0

gcloud composer environments update $1 --location=$2 $3=$(tr -d "\n\r" < $4) 2> /tmp/Output

# - Store the rror string in var
cmd_output=$(</tmp/Output)


# - Error matching string to skip to the next step
error_string1='INVALID_ARGUMENT: No change in configuration.'
error_string2='Cannot update Environment with no update type specified'
no_error='..done.'

# - Condifiton to sip to the next step if the error string mathces
if [[ "$cmd_output" == *"$error_string1"* ]] || [[ "$cmd_output" == *"$error_string2"* ]]
then
  echo " >>>>>  NO CHANGE IN THE CONFIGURATION, SKIPPING TO THE NEXT STEP <<<<<<" && exit 0
elif [[ "$cmd_output" == *"$no_error"* ]]
then
  echo $cmd_output
else
  echo $cmd_output && exit 1
fi