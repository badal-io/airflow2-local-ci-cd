cp ./gcp-cloud-shell/.customize_environment ../
sudo chmod +x ./helpers/scripts/init_airflow.sh ./gcp-cloud-shell/.customize_environment
sudo ./gcp-cloud-shell/.customize_environment
echo "#### - Cloud Shell has been successfully customized, you can proceed with Airflow deployment!"
