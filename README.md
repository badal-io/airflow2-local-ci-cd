
## Dependencies & prerequisities on a local machine
- For Windows 10 OS:
  1. Install WSL first (complete all steps): https://docs.microsoft.com/en-us/windows/wsl/install-win10
  2. Install Linux distribution of choice from Microsoft Store

- Install the latest available version of `Docker`: https://docs.docker.com/get-docker/

- Install the latest available version of `Docker compose`: https://docs.docker.com/compose/install/

- Disable Docker Compose V2 using the CLI, run: `docker-compose disable-v2`


## Recommended dev environment to use:
  - OS:            : `MAC OS, Linux Ubuntu/Debian`

  - Development env: `Visual Studio Code (VS Code)`

  - Terminal client: `Visual Studio Code terminal`


## Clone the repo & navigate to the directory

`git clone https://github.com/badal-io/airflow2-local.git`

`cd airflow2-local`


## Dependencies to solve before you go ##
  - Add your Py dependencies to the `docker/requirements-airflow.txt` file
  - Adapt and install DAGs into the `dags` folder
  - Adapt and install Plugins into the `plugins` folder
  - Add variables to Airflow:  `variables\airflow-vars.json` file
  - Add variables to Docker containers ENV: `variables\docker-env-vars` file, the file is added to the gitignore process
  - Add variables that contain secrets and API keys: `variables\docker-env-secrets` file, the file is added to the gitignore process
  - If there is a custom Airflow configuration file ready, uncomment the line in Dockerfile in order to includ it in the image: `COPY airflow.cfg ${AIRFLOW_HOME}/airflow.cfg`


## Installation and initialization ##
1. Clone the repo and navigate in to the working directory

2. Run the following commands:

  - For Linux/Mac run:  `./helpers/scripts/init_linux-macos.sh`


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
- To run unit tests navigate to the `tests` directory and run the following command:
`./airflow "test command"`

    example:`cd tests && ./airflow "pytest tests/unit"`

- To run integration tests with GCP navigate to the `tests` directory and run the following command:
`./airflow-gcp "test command"`

    example:`cd tests && ./airflow-gcp "pytest --tc-file tests/integration/config.ini -v tests/integration"`

  Note! You will be prompted for GCP authentification

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


## Code linting and stying - Pre commit ##
1. Install pre-commit app:

  For Linux/Windows `pip3 install pre-commit`

  For MAC-OS `brew install pre-commit`

2. Run a pre commit initialization command (inside the same dir where the code was cloned): `pre-commit install`

3. Run pre-commit tests: `pre-commit run --all-files`
