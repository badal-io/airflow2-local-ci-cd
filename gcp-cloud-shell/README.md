## Working with GCP Cloud Shell

For those who have "local PC restrictions", the Airflow 2 environment can be deployed and run in GCP Cloud Shell/Editor - which is an ephemeral cloud virtual machine accessible from a web browser. Consider the following points before working with Cloud Shell/Editor.

- The virtual machine instance that backs your Cloud Shell session is not permanently allocated to a Cloud Shell session and terminates if the session is <strong> inactive for 20 minutes </strong>. Once the session is terminated, any modifications that you made to it outside your $HOME directory are lost.

- GCP Cloud Shell has several limitations. If your cloud shell session is expired or closed, you <strong> have to re-run the Airflow initialization steps given in section #4 (step 4.1)</strong>

- To see hidden files in Cloud Shell go to <strong>View</strong> and tick <strong>Toggle Hidden Files</strong>

- To access Web UI click on `Web Preview` in GCP Cloud Shell (top right corner)

- You can upload or download files from Web UI
