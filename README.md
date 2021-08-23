
## Dependencies & prerequisities on a local machine ##
- install docker

- install docker compose


## Installation and initialization ##
1. Clone the repo and navigate in to the working directory

2. Run the following commands:

  - For Linux/Mac run:  `chmod +x ./helpers/scripts/init_linux-macos.sh && ./helpers/scripts/init_linux-macos.sh`

  - For Windows:  right click on the `init_windows.bat` file  ---> run as administrator


## Commands for operations & maintenance: ##
- To start Airflow and all services:
`docker-compose up`

- To stop all Airflow containers (via a new terminal session):
`docker-compose down`

- To rebuild containers (if changes are aplied on dockerfile/docker-compose):

`docker-compose down`

`docker-compose up --build`

- To cleaning up all containers and remove database:
`docker-compose down --volumes --rmi all`


## Commands for working inside a container: ###
- To spin up an Ops container (shell, bash, testing, etc):
`./airflow bash`

- To print Airflow info:
`./airflow info`

- To lauch a python session in Airflow:
`./airflow python`

- To access the Airflow Web UI:
`localhost:8080`


## Gcloud auhtentification inside a container ###
1. Authentificate inside a container when "gcp authentification" is required:
`gcloud auth applicaiton-default`

2. Set projet id varibale in the `variables/docker-env-vars` file:
`GCP_PROJECT_ID='<project-id here>'`


## Dependencies to solve ##
  - Add your Py dependencies to `requirements-airflow.txt`
  - Adapt and install DAGs into the `dags` folder
  - Adapt and install Plugins into the `plugins` folder
  - Add variables to Airflow `variables\airflow-vars.json` file
  - Add variables to Docker containers `variables\docker-env-vars` file, the file is added to the gitignore process
  - Add variables that contain secrets and API keys to the `variables\docker-env-secrets` file, the file is added to the gitignore process
  - If there is a custom Airflow configuration file ready, uncomment the line in Dockerfile in order to include it in the image: `COPY airflow.cfg ${AIRFLOW_HOME}/airflow.cfg`

## Code linting and Stying ##
1. Install pre-commit app:

  For Linux/Windows `pip3 install pre-commit`

  For MAC-OS `brew install pre-commit`

2. Run a pre commit initialization command (n the same dir where the code was cloned): `pre-commit install`

3. Run pre commit tests: `pre-commit run --all-files`