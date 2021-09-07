
## GCP Composer CI-CD Pipeline

This project contains GCP cloudbuild confiugration code that run the Airflow 2 CI/CD pipeline.

<ins>Note:</ins> &nbsp; Before working with your local development environment <strong>fork</strong> the repository, so you can have your own branch for development and custom changes.

<br/>

## Prerequisities

1. Declare your `Project ID` variable in the cloudbuild.yaml file:

    `_GCP_PROJECT_ID: <my_project_1>`

2. Grant all necessary permissions to a `Cloud Build service account`

3. To add <ins>environment variables</ins> to Composer Env, update the `variables/composer-env-vars` file with your key-value pairs (comma separated). Example:  `FOO=BAR`

4. To add <ins>Airflow variables</ins> for Compose, update the `variables/composer-airflow-vars.json` with your key-value pairs (comma separated). Example:  `"key":"value"`

5. Malually add secrets as environment variables via the Compose UI --> ENVIRONMENT VARIABLES tab (for example SENDGID API KEY).

6. Add your Py dependencies to the `docker/requirements-composer.txt` file

7. Add your custom configuration lines to the `ci-cd/composer-config` file (comma separated)

<br/>

## Email notifications with SendGrid

1. Under Composer configuration, add the following environment variables:
  - SENDGRID_MAIL_FROM: no_reply_@your-domain.com
  - SENDGRID_API_KEY: <API key generated from SendGrid>

2. Set a recipient email address in the `dags/send_email.py` file, the line: `to="<recepient_email>"`. An email will be sent to this address upon a succesfull pipeline build.

<br/>

## GitOps

The CI/CD pipeline automatically builds a container image from committed code, stores the image in Container Registry, performs unit and integration testing, and deploys and update variables, configuration, packages, dags, plugins to GCP Coomposer environments (dev or prod).

### Cloud Build Triggers

### 1. For each environemnt create a trigger in GCP Cloud Build. Use the following parameters:

  - Event type:

    For any a DEV branch - <strong> Push to a branch </strong>

    For any a PROD branch  - <strong> Push new tag </strong>

  - Source repository: <strong> Git repository </strong>

  - Source branch: <strong> Branch </strong>. <em> For example, if there are two environments : dev and prod, you will need to create two triggers with the same repository, but with different branches to monitor </em>

  - Included file filter:

     - `composer/**`

     - `plugins/**`

     - `dags/**`

     - `docker/**`

     - `cloudbuild.yaml`

     - `tests/**`

     - `ci-cd/**`

     - `variables/**`

  - Ignored file filter:

     - `**README.md`

  - Cloud Build configuration file path:

     - `ci-cd/cloudbuild.yaml`

  - Substitution variables:

    - <strong> _COMPOSER_ENV_NAME  =  <em> name of the environment </em> </strong>

        example: `_COMPOSER_ENV_NAME = dev-env`


    - <strong> _COMPOSER_INPUT_BUCKET =  <em> name of the Composer Bucket </em> </strong>

        example: `_COMPOSER_INPUT_BUCKET = us-central1-test-env-4319fd69-bucket`

    - <strong> _DEV_ENV_NAME =  <em> name of the dev environment </em> </strong> <ins>Note:</ins> &nbsp; This is required for proper "If" condition functionality in the cloud build pipeling.

        example: `_COMPOSER_INPUT_BUCKET = dev-env`

<br/>

## Pipeline Steps:

1. <strong> id: `env name` </strong>
   - Prints an environment name which is defined in the variable `_COMPOSER_ENV_NAME` that is declared in a CLoud Build trigger

2. <strong> id: `pull-airflow2` </strong>
   - Pulls an existing airflow2 docker image (if any). Skips this step if no image is stored in GCR (Google Container registry)

3. <strong> id: `build-airflow2` </strong>
   - Builds a CI docker image for the next steps (unit & integration tests). The docker image is built based on the Dockerfile (docker/Dockerfile-CI). If there is a cached image from the previous step, this speeds up the overall pip[eline process.

4. <strong> id: `unit-test` </strong>
   - Runs the built docker image (from the prevoius step) as a docker container, and performs a unit test inside the container.

5. <strong> id: `int-test` </strong>
   - Runs the built docker image (from the prevoius step) as a docker container, and performs an integration test inside the container.

6. <strong> id: `stage-for-smoke-test` </strong>
  - Copies all dags form local DAGS folder in to temporary folder in Composer (DATA folder).

7. <strong> id: `dag-parse-smoke-test` </strong>
  - Parses and list dags to make sure that validity and integrity of the dags.

8. <strong> id: `clean-up-data` </strong>
  - Cleans up the DATA folder after the successfull smoke test.

9. <strong> id: `lint-code` </strong>
   - Runs automatic check pointing out issues in code such as missing semicolons, trailing whitespace, and debug statements.

10. <strong> id: `stage-airflow-variables` </strong>
   - Transfers the composer-airflow-vars.json file to the Composer's "data/config" folder for further processing.

11. <strong> id: `import-airflow-variables` </strong>
   - Imports variables form the composer-airflow-vars.json file in to Airflow database.

12. <strong> id: `update-vars` </strong>
   - Adds/Updates varibales and their values into the Composer environment. Variables/Values are populated in the `variables/composer-env-vars` file (comma separated KEY=VALUE). If no changes are in varibales/values, this step will be skipped. Please note, this step does not remove a variable, this has to be done manually from the Composer UI.

13. <strong> id: `update-config` </strong>
   - Adds/Updates configuration lines in Composer. Configuration items should be populated in the `composer/composer-config` file. A list of Airflow config override KEY=VALUE pairs to set. If a config override exists, its value is updated; otherwise, a new config override is created. If no changes in configuration, this step will be skipped. Please note, this step does not remove configuration, this has to be done manually from the Composer UI.

14. <strong> id: `update-PyPi` </strong>
   - Adds/Updates/Removes PyPi packages in Composer. Items should be populated in the `docker/requirements-composer.txt` file.

15. <strong> id: `sync-plugins` </strong>
   - Syncs plugins from repo into Composer

16. <strong> id: `sync-dags` </strong>
   - Syncs dags from repo into Composer

17. <strong> id: `send-email` </strong>
   - Sends an email if the build has been successfull

</br>

### Pipeline steps matrix for different environments (_COMPOSER_ENV_NAME):

|      Step      	|               Description              	| Dev ENV 	| Prod ENV 	|
|:--------------:	|:--------------------------------------:	|:-------:	|:--------:	|
| env name       	| Print Env Name                         	|    Do   	|    Do    	|
| pull-airflow2  	| Pull an existing docker image from GCR 	|    Do   	|   Skip   	|
| build-airflow2 	| Build an image using cache             	|    Do   	|   Skip   	|
| unit-test      	| Perform a unit test                    	|    Do   	|   Skip   	|
| int-test       	| Perform an integration test            	|    Do   	|   Skip   	|
| stage-for-smoke-test| Transfer dags into DATA dir         |    Do   	|    Do   	|
| dag-parse-smoke-test| Run "list dags" command          	|    Do   	|    Do   	|
| clean-up-data  	| Clean up DATA dir                    	|    Do   	|    Do   	|
| lint-code      	| Code listing and Styling               	|    Do   	|   Skip   	|
| stage-airflow-variables| Transfer variables json file    	|    Do   	|    Do   	|
| import-airflow-variables| Import variables             	|    Do   	|    Do   	|
| update-vars    	| Update vars in Composer                	|    Do   	|    Do    	|
| update-config  	| Update Config in Composer              	|    Do   	|    Do    	|
| update-PyPi    	| Update PyPi packages in Composer       	|    Do   	|    Do    	|
| sync-plugins   	| Sync plugins with Composer GCS         	|    Do   	|    Do    	|
| sync-dags      	| Sync tags with Composer GCS            	|    Do   	|    Do    	|
| send-email   	| Send an email upon successfull build   	|    Do   	|    Do   	|
