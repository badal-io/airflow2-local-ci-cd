
## GCP Composer CI-CD Pipeline

This project contains GCP cloudbuild confiugration code that run the Airflow 2 CI/CD pipeline.


## GitOps

The CI/CD pipeline automatically builds a container image from committed code, stores the image in Container Registry, performs unit and integration testing, and deploys and update variables, configuration, packages, dags, plugins to GCP Coomposer environments (dev or prod).

### Git Triggers

1. For each environemnt create a trigger in GCP Cloud Build. Use the following parameters:

  - Event type: <strong> Push to a branch </strong>

  - Source: <strong> Git repository </strong>

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

  - CLoudbuild configuration:

     - `ci-cd/cloudbuild.yaml`

  - Substitution variables:

    - <strong> _COMPOSER_ENV_NAME  =  <em> name of the environment </em> </strong>

        example: `_COMPOSER_ENV_NAME = dev-env`


    - <strong> _COMPOSER_INPUT_BUCKET =  <em> name of the Composer Bucket </em> </strong>

        example: `_COMPOSER_INPUT_BUCKET = us-central1-test-env-4319fd69-bucket`




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

6. <strong> id: `lint-code` </strong>
   - Runs automatic check pointing out issues in code such as missing semicolons, trailing whitespace, and debug statements.

7. <strong> id: `update-vars` </strong>
   - Adds/Updates varibales and their values in Composer. Variables/Values are populated in the `variables/composer-vars` file (comma separated KEY=VALUE). If no changes are in varibales/values, this step will be skipped. Please note, this step does not remove a variable, this has to be done manually from the Composer UI.

6. <strong> id: `update-config` </strong>
   - Adds/Updates configuration lines in Composer. Configuration items should be populated in the `composer/composer-config` file. A list of Airflow config override KEY=VALUE pairs to set. If a config override exists, its value is updated; otherwise, a new config override is created. If no changes in configuration, this step will be skipped. Please note, this step does not remove configuration, this has to be done manually from the Composer UI.

7. <strong> id: `update-PyPi` </strong>
   - Adds/Updates/Removes PyPi packages in Composer. Items should be populated in the `docker/requirements-airflow.txt` file.

8. <strong> id: `sync-plugins` </strong>
   - Sync plugins from repo into Composer

9. <strong> id: `sync-dags` </strong>
   - Sync dags from repo into Composer

</br>
