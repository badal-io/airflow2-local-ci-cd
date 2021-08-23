
## Dependencies & prerequisities on a local machine ##
- install docker

- install docker compose

## Clone the repo & navigate to the directory

`git clone https://github.com/badal-io/airflow2-local.git`

`cd airflow2-local`

## Code linting and stying - Pre commit ##
1. Install pre-commit app:

  For Linux/Windows `pip3 install pre-commit`

  For MAC-OS `brew install pre-commit`

2. Run a pre commit initialization command (n the same dir where the code was cloned): `pre-commit install`

3. Run pre commit tests: `pre-commit run --all-files`


## Installation and initialization ##
1. Clone the repo and navigate in to the working directory

2. Run the following commands:

  - For Linux/Mac run:  `./helpers/scripts/init_linux-macos.sh`

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
- To run unit tests under the tests/unit directory:
`./airflow "test command"`, example:`./airflow "pytest tests/unit"`

- To run integration tests under the tests/integration directory with a test config file:
`./airflow "test command"`, example:`./airflow "pytest --tc-file tests/integration/config.ini -v tests/integration"`

- To spin up an Ops container with Bash session:
`./airflow bash`

- To print Airflow info:
`./airflow info`

- To lauch a python session in Airflow:
`./airflow python`

- To access the Airflow Web UI:
`localhost:8080`


## GCP Project ID for GCP Connection ###
- Set the projet-id varibale in the `variables/docker-env-vars` file:
`GCP_PROJECT_ID='<project-id here>'`


## Dependencies to solve ##
  - Add your Py dependencies to `requirements-airflow.txt`
  - Adapt and install DAGs into the `dags` folder
  - Adapt and install Plugins into the `plugins` folder
  - Add variables to Airflow:  `variables\airflow-vars.json` file
  - Add variables to Docker containers ENV: `variables\docker-env-vars` file, the file is added to the gitignore process
  - Add variables that contain secrets and API keys: `variables\docker-env-secrets` file, the file is added to the gitignore process
  - If there is a custom Airflow configuration file ready, uncomment the line in Dockerfile in order to include it in the image: `COPY airflow.cfg ${AIRFLOW_HOME}/airflow.cfg`
