
#!/bin/bash
mkdir -p ./logs ./plugins ./data ./dags ./tests/integration ./tests/unit && touch ./variables/docker-env-secrets
chmod -R 0775 ./logs ./plugins ./data ./dags ./tests
chmod +x ./airflow ./airflow-gcp-auth
docker-compose up airflow-init
