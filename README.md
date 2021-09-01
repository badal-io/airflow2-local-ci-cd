
## 1. Recommended dev tools to use:

- OS: : `MAC OS, Linux Ubuntu, GCP Cloud Shell` (Windows requires Windows Subsystem for Linux)
- Development env: `Visual Studio Code (VS Code)`
- Terminal client: `Visual Studio Code terminal`

<br/>

## 2. Dependencies & prerequisities on a local PC:

### 2.1 &nbsp; For GCP Cloud Shell:

  - 2.1.1 &nbsp; Access GCP Cloud Shell from your browser using your crdentials: https://ide.cloud.google.com

  - 2.1.2 &nbsp; Clone the repo and go to the directory:

       `git clone https://github.com/badal-io/airflow2-local.git`

       `cd airflow2-local`

  - 2.1.3 &nbsp; Run the following commands to initialize the environment and install prrequisities:
        `chmod +x ./helpers/scripts/cloud-shell-init.sh && ./helpers/scripts/cloud-shell-init.sh`

  - 2.1.4 &nbsp; Proceed with the installation and initialization steps (<strong> section #3 and #4 </strong>)


### 2.1 &nbsp; For Linux OS:

  - 2.1.1 &nbsp; Install the latest available version of `Docker`: https://docs.docker.com/get-docker/

  - 2.1.2 &nbsp; Install the latest available version of `Docker compose`: https://docs.docker.com/compose/install/

  - 2.1.3 &nbsp; Disable docker compose v2 experimental features via the CLI, run: `docker-compose disable-v2`

  - 2.1.5 &nbsp; Proceed with the installation and initialization steps (<strong> section #3 and #4 </strong>)

### 2.2 &nbsp; For MAC OS:

  - 2.2.1 &nbsp; Install the latest available version of `Docker Desktop`: https://docs.docker.com/get-docker/

  - 2.2.2 &nbsp; Disable docker compose v2 experimental features via the CLI, run: `docker-compose disable-v2`

  - 2.2.3 &nbsp; Clone the repo:

       `git clone https://github.com/badal-io/airflow2-local.git`

  - 2.2.4 &nbsp; Launch Visual Studio Code and open the folder (Open folder) with the Airflow 2 code

  - 2.2.5 &nbsp; Open a terminal window `(Menu Terminal -- New Terminal)`

  - 2.2.6 &nbsp; Proceed with the installation and initialization steps (<strong> section #3 and #4 </strong>)

### 2.3 &nbsp; For Windows 10 OS:

  - 2.3.1 &nbsp; Install WSL (Windows Linux Subsystem): https://docs.microsoft.com/en-us/windows/wsl/install-win10

  - 2.3.2 &nbsp; Install `Linux Ubuntu` distribution from the Microsoft Store: https://aka.ms/wslstore (this step is part of the previous step)

  - 2.3.3 &nbsp; Launch WLS Ubuntu and create a <strong>  username (`airflow`) & password (`airflow`) </strong> when prompted

  - 2.3.4 &nbsp; In the WSL terminal window go to `/home/airflow` and clone the repo:

       `cd /home/airflow`

       `git clone https://github.com/badal-io/airflow2-local.git`

  - 2.3.5 &nbsp; On Windows 10, install the latest available version of `Docker Desktop`: https://docs.docker.com/get-docker/

  - 2.3.6 &nbsp; Once installed, launch `Docker Desktop`, go to <strong> Settings --> Resources --> WSL INTEGRATION and toggle "Ubuntu". Once done, click the "Apply & Restart" button  </strong>

  - 2.3.7 &nbsp; Open a comamnd line in Windows (CMD) and excute the following command to make sure that Ubuntu has been set as a default WSL:

       `wsl --setdefault Ubuntu`

  - 2.3.8 &nbsp; Install (if not already installed ) and launch <strong> Visual Studio Code </strong>

  - 2.3.9 &nbsp; From the VS code extension tab, search and install a new plugin <strong> `Remote WLS` </strong>

  - 2.3.10 &nbsp; On  <strong> Visual Studio Code </strong>, you now see a green WSL indicator in the bottom left corner, click on it and choose <strong> Open Folder in WSL </strong>. Windows will prompt you to select a folder, provide the follwing path to a folder: <strong> ` \\wsl$\ubuntu\home\airflow ` </strong> , and choose the folder with the Airflow code: (<strong> airflo2-local-cicd </strong>)

  - 2.3.11 &nbsp; Open a terminal session in VS code `(Menu Terminal -- New Terminal)` and run the WLS docker installation script:

       `chmod +x ./helpers/scripts/docker-wls.sh && sudo ./helpers/scripts/docker-wls.sh`

  - 2.3.12 &nbsp; Proceed with the installation and initialization steps (<strong> section #3 and #4 </strong>)

<br/>

## 3. Dependencies to solve before you go
   ### 3.1

  - Add your Py dependencies to the `docker/requirements-airflow.txt` file

  - Adapt and install DAGs into the `dags` folder

  - Adapt and install Plugins into the `plugins` folder

  - Add variables to Airflow: `variables\airflow-vars.json` file

  - Add variables to Docker containers ENV: `variables\docker-env-vars` file, the file is added to the gitignore process

  - Add variables that contain secrets and API keys: `variables\docker-env-secrets` file, the file is added to the gitignore process

  - If there is a custom Airflow configuration file ready, uncomment the line in Dockerfile in order to includ it in the image: `COPY airflow.cfg ${AIRFLOW_HOME}/airflow.cfg`

<br/>

### 3.2 GCP Project ID for GCP Connection

  - Set the projet-id varibale in the `variables/docker-env-vars` file:

     `GCP_PROJECT_ID='<project-id here>'`

<br/>

## 4. Initialization and run

  - 4.1 Open a terminal and run the following commands (for the first time only):

      `./helpers/scripts/init_airflow.sh`   (for Windows WSL use `sudo` before the command)

  - 4.2 Start Airflow and all services:

      `docker-compose up`

  - 4.3 Authentificate for GCP services, run the following script and perform the gcp authentification:

      `./helpers/scripts/gcp-auth.sh`

  - 4.4  <strong> Airflow 2 is ready! </strong>

<br/>

## 5. Commands for operations & maintenance:

  - To start Airflow and all services:

      `docker-compose up`

  - To stop all Airflow containers (via a new terminal session):

    `docker-compose down`

  - To rebuild containers (if changes are aplied on dockerfile/docker-compose):

    `docker-compose down`

    `docker-compose up --build`

  - To cleaning up all containers and remove database:

    `docker-compose down --volumes --rmi all`

<br/>

## 6. Commands for working inside a container:

  - To run unit tests navigate to the `tests` directory and run the following command:

     `./airflow "test command"`

    example:

     <strong> `cd tests && ./airflow "pytest tests/unit"` </strong>

  - To run integration tests with GCP navigate to the `tests` directory and run the following command:

     `./airflow "test command"`

    example:

     <strong> `cd tests && ./airflow "pytest --tc-file tests/integration/config.ini -v tests/integration"`  </strong>

  - To spin up an Ops container with Bash session:

     `./tests/airflow bash`

  - To print Airflow info:

     `./tests/airflow info`

  - To lauch a python session in Airflow:

     `./tests/airflow python`

  - To access the Airflow Web UI:

     `localhost:8080`

<br/>

## 7. Code linting and stying - Pre commit ##

  - 7.1 Install pre-commit app:

    - For Linux/Windows `pip3 install pre-commit`

    - For MAC-OS `brew install pre-commit`


  - 7.2 Run a pre commit initialization command (inside the same dir where the code was cloned):

    `pre-commit install`

  - 7.3 Run pre-commit tests:     `pre-commit run --all-files`
