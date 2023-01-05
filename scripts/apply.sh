#!/bin/bash
echo "========================================================"
echo "Planning changes and applying to backend infrastructure"
# sleep 5

cd backend/ 

# terraform init -upgrade && terraform fmt && terraform plan
# terraform apply -auto-approve

cd - 

echo "========================================================"
echo "Planning changes and applying to frontend infrastructure"
echo "Please write owner stage project and global_model \nExample: dosystems as yourCompany productionEnvironments (MAX 3) "
# read -p "Enter owner of changes: " ownerf 
# read -p "Enter stage of project: " stagef 
# read -p "Enter your company name: " projectf 
read -p "Enter your production environments: " global_modelf 

# sleep 5
if [ "${global_modelf}" == "dev" ]; then
  echo oi
else 
  echo ola 
fi


# sed -i "s/$environments/word2/g" modules.tf
# cd frontend/ 
# echo "owner = \"${ownerf}\" #\nstage = \"${stagef}\" #\nproject = \"${projectf}\" #\n" >> terraform.tfvars

# terraform init -upgrade && terraform fmt && terraform plan
# terraform apply -auto-approve

cd -
