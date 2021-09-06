#!/bin/bash

n=0
until [[ $n -ge $4 ]]
do
  status=0
  gcloud beta composer environments run $1 --location $2 dags list 2>&1 | grep $3 && break
  status=$?
  n=$(($n+1))
  sleep $5
done
gcloud beta composer environments run $1 --location $2 dags trigger -- $3 --conf '{"env":"'${1}'","commit":"'${6}'","branch":"'${7}'"}'
exit $status
