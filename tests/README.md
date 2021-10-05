### Pytst Operations

When no tests are placed in the "unit" or "integration" folders, a CI/CD pipeline workflow may break at the testign stages. This is because Pytest returns an ```exit code 5```, if no tests are in the folders. In GCP Cloud Build, any exit code other than ```exit code 0```, stops the build process. To avoid this scenario there are two oprtions to follow, apply any of them:

  -  Add the folwign code to the conftest.py file:

         def pytest_sessionfinish(session, exitstatus):
          if exitstatus == 5:
            session.exitstatus = 0

  - Add a dummy test files to the folders.
