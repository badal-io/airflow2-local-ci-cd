#!/bin/bash
mkdir -p ./logs ./plugins ./data ./dags ./tests/integration ./tests/unit && touch ./variables/docker-env-secrets
chmod -R 0777 ./logs ./plugins ./data ./dags ./tests ./helpers/scripts
docker-compose up airflow-init
