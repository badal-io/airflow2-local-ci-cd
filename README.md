## Apache Airflow 2 for local development and CI/CD
=======================================================

&nbsp; This project is an easy-to-use development environment for Apache Airflow version 2. It can be run locally on a variety of OS platforms with simple steps for spinning up Airflow. The project can be integrated into an automated continuous integration/continuous delivery (CI/CD) process using GCP Cloud Build to build, test, and deploy workflows into GCP Cloud Composer. The project is meant to address several "infrastructure challenges" that Airflow developers experience and allows them to focus on workflow development rather than platform installation/configuration.

&nbsp; The environment is available for local use using Docker containers and Docker-Compose. For most of the deployment options, these are the only prerequisites required. The code has also been successfully tested within the GCP Cloud Shell/Editor which is an ephemeral cloud Linux instance accessible from a web browser. This may be beneficial for those who have "local PC restrictions" and cannot install docker-engine locally.

Main features of local development using Docker & Docker-Compose:

- Your workspace files are always synchronized with docker containers. With the use of an IDE program, the development process becomes easier and faster.
- Unit and Integration tests run within a container built from the same image as the Airflow deployment.

&nbsp; The project provides an opinionated Cloud Build CI/CD pipeline for the GCP Cloud Composer service. It natively integrates with a "local Airflow" development and allows developers to automatically stage, test and deploy their code into a production environment.

Main features of Cloud Build CI/CD pipeline for Composer environment:

- Container caching - reusing cache of already built images, speeds up the overall build process.
- Unit & Integration test as steps in CI stage.
- DAGs integrity validation (smoke test).
- Code linting check.
- Custom configuration: env variables, configuration, PyPi packages.
- Plugin and DAGs deployment into COmposer environment.
- Automatic email notification upon a successful build.


### Project Structure
```
    .
    ├── ci-cd                     # CI/CD deployment configuration
    ├── dags                      # Airflow DAGs 
    ├── data                      # Airflow DATA 
    ├── docker                    # Docker configuration
    ├── gcp-cloud-shell           # Cloud Shell custom csripts
    ├── helpers                   # Backend scripts
    ├── logs                      # Airflow logs 
    ├── plugins                   # Airflow plugins
    ├── tests                     # Tests
    ├── variables                 # Varibales for environments
    ├── .gitignore                # Git's ignore process
    ├── pre-commit-config.yaml    # Pre-commit hooks
    ├── LICENSE                   # Project license
    ├── README.md                 # Readme guidlines
    └── docker-compose.yaml       # Docker Compose deployemnt code
```
<br/>

## 1. Recommended dev tools to use:

- OS: `MAC OS, Linux Ubuntu, GCP Cloud Shell`   Note: Windows requires Windows Subsystem for Linux (WSL)
- Code editing/Development environment: `Visual Studio Code (VS Code)`
- Terminal client: `Visual Studio Code terminal`

<ins>Note:</ins> &nbsp; Before working with your local development environment <ins><strong>fork</strong></ins> the repository, so you can have your own branch for development and custom changes.

<br/>

## 2. Dependencies & prerequisities for a local PC or cloud VM:

### 2.1 &nbsp; GCP Cloud Shell:

<strong> <ins>Note:</ins> &nbsp; GCP Cloud Shell has several limitations. Everytime when a shell session is expired or closed, you have to re-run the Airflow initializaiton steps given in the section #4 (step 4.1) </strong>

  - 2.1.1 &nbsp; Access GCP Cloud Shell from your browser using your credentials: https://ide.cloud.google.com

  - 2.1.2 &nbsp; Open a terminal session `(Menu Terminal -- New Terminal)` and clone the repo, go to the directory:

        git clone <'Airflow 2 repository'> && cd airflow2-local

  - 2.1.3 &nbsp; In the cloud shell UI, click on <strong>open folder</strong> and select the <strong>airflow2-local</strong> folder

  - 2.1.4 &nbsp; Run the following commands to initialize the environment and install prerequisites:

        chmod +x ./helpers/scripts/cloud-shell-init.sh && ./helpers/scripts/cloud-shell-init.sh

  - 2.1.5 &nbsp; Proceed with the installation and initialization steps (<strong> section #3 and #4 </strong>).


### 2.2 &nbsp; Linux OS:

  - 2.2.1 &nbsp; Install the latest available version of `Docker`: https://docs.docker.com/get-docker/

  - 2.2.2 &nbsp; Install the latest available version of `Docker compose`: https://docs.docker.com/compose/install/

  - 2.2.3 &nbsp; Disable docker compose v2 experimental features via the CLI, run: `docker-compose disable-v2`

  - 2.2.5 &nbsp; Proceed with the installation and initialization steps (<strong> section #3 and #4 </strong>)

### 2.3 &nbsp; MAC OS:

  - 2.3.1 &nbsp; Install the latest available version of `Docker Desktop`: https://docs.docker.com/get-docker/

  - 2.3.2 &nbsp; Disable docker compose v2 experimental features via the CLI, run:

        docker-compose disable-v2

  - 2.3.3 &nbsp; Clone the repo:

        git clone <'Airflow 2 repository'>

  - 2.3.4 &nbsp; Launch Visual Studio Code and open the folder (Open folder) with the Airflow 2 code

  - 2.3.5 &nbsp; Open a terminal window `(Menu Terminal -- New Terminal)`

  - 2.3.6 &nbsp; Proceed with the installation and initialization steps (<strong> section #3 and #4 </strong>)

### 2.4 &nbsp; Windows 10 OS:

  - 2.4.1 &nbsp; Install WSL (Windows Linux Subsystem): https://docs.microsoft.com/en-us/windows/wsl/install-win10

  - 2.4.2 &nbsp; Install `Linux Ubuntu` distribution from the Microsoft Store: https://aka.ms/wslstore (this step is part of the previous step)

  - 2.4.3 &nbsp; Launch WLS Ubuntu and create a <strong>  username (`airflow`) & password (`airflow`) </strong> when prompted

  - 2.4.4 &nbsp; In the WSL terminal window go to `/home/airflow` and clone the repo:

        cd /home/airflow && git clone <'Airflow 2 repository'>

  - 2.4.5 &nbsp; On Windows 10, install the latest available version of `Docker Desktop`: https://docs.docker.com/get-docker/

  - 2.4.6 &nbsp; Once installed, launch `Docker Desktop`, go to <strong> Settings --> Resources --> WSL INTEGRATION and toggle "Ubuntu". Once done, click the "Apply & Restart" button  </strong>

  - 2.4.7 &nbsp; Open a command line in Windows (CMD) and execute the following command to make sure that Ubuntu has been set as a default WSL:

        wsl --setdefault Ubuntu

  - 2.4.8 &nbsp; Install (if not already installed ) and launch <strong> Visual Studio Code </strong>

  - 2.4.9 &nbsp; From the VS code extension tab, search and install a new plugin <strong> `Remote WLS` </strong>

  - 2.4.10 &nbsp; On  <strong> Visual Studio Code </strong>, you now see a green WSL indicator in the bottom left corner, click on it and choose <strong> Open Folder in WSL </strong>. Windows will prompt you to select a folder, provide the follwing path to a folder: <strong> ` \\wsl$\ubuntu\home\airflow ` </strong> , and choose the folder with the Airflow code: (<strong> airflo2-local-cicd </strong>)

  - 2.4.11 &nbsp; Open a terminal session in VS code `(Menu Terminal -- New Terminal)` and run the WLS docker installation script:

        chmod +x ./helpers/scripts/docker-wls.sh && sudo ./helpers/scripts/docker-wls.sh

  - 2.4.12 &nbsp; Proceed with the installation and initialization steps (<strong> section #3 and #4 </strong>)

<br/>

## 3. Customizing Airflow Settings
   ### 3.1

  - Add your Py dependencies to the `docker/requirements-airflow.txt` file.

  - Adapt and install DAGs into the `dags` folder.

  - Adapt and install Plugins into the `plugins` folder.

  - Add variables to Airflow: `variables\docker-airflow-vars.json` file.

  - Add variables to Docker containers' ENV: `variables\docker-env-vars` file.

  - Add variables that contain secrets and API keys: `variables\docker-env-secrets` file, the file is added to the gitignore process.

  - If there is a custom Airflow configuration file ready, uncomment the line in Dockerfile in order to include it in the image: `COPY airflow.cfg ${AIRFLOW_HOME}/airflow.cfg`.

  - Optionally add the <ins>send_email.py</ins> dag to the `.airflowignore` file as this dag is only for the CI/CD part (to avoid warnings and errors during unit tests).

<br/>

### 3.2 GCP Project ID for GCP Connection

  - Set the projet-id variable in the `variables/docker-env-vars` or `variables/docker-env-secrets` file:

     `GCP_PROJECT_ID='<project-id here>'`

<br/>

## 4. First-time initialization and service start:

  - 4.1 Open a terminal and run the following commands (you may need to use <ins>`sudo`</ins> before the command in some cases, such as: <ins>GCP Cloud Shell</ins>,  <ins>Windows WSL</ins>, <ins>Cloud Linux VMs</ins>):

        ./helpers/scripts/init_airflow.sh

    <ins>Note:</ins> &nbsp; for <strong>GCP Cloud Shell</strong> you must <strong> re-run </strong> this command every time when a shell session is expired or ended.

  - 4.2 Open a new terminal window and run the following command to make sure that all 3 containers (webserver, scheduler, postgres_db) are running and healthy:

        docker ps

  - 4.3 Authentificate for GCP services, run the following script and perform the gcp authentification:

        ./helpers/scripts/gcp-auth.sh

      <ins>Note:</ins> &nbsp; NOT required if you are working via GCP Cloud Shell option, you can skip this step.

  - <strong> Airflow 2 is UP and Running! </strong>

<br/>

## 5. Commands for operations & maintenance:

  - To check if all 3 containers (webserver, scheduler, postgres_db) are running and healthy:

        docker ps

  - To stop all Airflow containers (via a new terminal session):

        docker-compose down

  - To start Airflow and all services:

        docker-compose up

  - To rebuild containers (if changes are applied on Dockerfile or Docker-Compose):

        docker-compose down

        docker-compose up --build

  - To cleaning up all containers and remove the database:

        docker-compose down --volumes --rmi all

<br/>

## 6. Running commands inside a container:

  - To run unit tests navigate to the `tests` directory and run the following command:

       `./airflow "test command"`

    example:

        cd tests && ./airflow "pytest tests/unit"

  - To run integration tests with GCP navigate to the `tests` directory and run the following command:

     `./airflow "test command"`

    example:

        ./airflow "pytest --tc-file tests/integration/config.ini -v tests/integration"

  - To spin up an Ops container with Bash session:

        ./tests/airflow bash

  - To run an Airflow command within the environment, spin up an Ops container with a bash sessioin, then execute a command:
    
    example:
    
        airflow dags list

  - To launch a python session in Airflow:

        ./tests/airflow python

  - To access the Airflow Web UI:

     `localhost:8080` or  `Web Preview` (GCP Cloud Shell)

<br/>

## 7. Code linting and stying - Pre-commit ##

  - 7.1 Install pre-commit app:

    - For Linux/Windows

        pip3 install pre-commit

    - For MAC-OS

        brew install pre-commit

  - 7.2 Run a pre-commit initialization command (inside the same dir where the code was cloned):

        pre-commit install

  - 7.3 Run pre-commit tests:

        pre-commit run --all-files
