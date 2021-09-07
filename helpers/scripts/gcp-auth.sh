#
# Run commands in a temporaty ops container with GCP authentification
#

exec docker-compose run --rm -e CONNECTION_CHECK_MAX_COUNT=0 airflow-ops bash -c 'gcloud auth application-default login --disable-quota-project'
