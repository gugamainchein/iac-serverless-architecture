#!/bin/bash

# echo "react_app_identity_pool_id_${state} = \"${app_identity_id}\" #\n
echo "react_app_identity_pool_id_${state} = \"null\" #\n
react_app_user_pool_id_${state} = \"${user_pool_id}\" #\n
react_app_user_pool_web_client_id_${state} = \"${user_client_id}\" #\n
react_app_cognito_domain_${state} = \"${cognito_domain}\" #\n
react_app_aws_api_gateway_url_${state} = \"${api_url}\" #\n
react_app_aws_api_gateway_name_${state} = \"${api_name}\" #\n
react_app_waf_token_${state} = \"${waf_token}\"" | tee ${state}.tfvars

mv ${state}.tfvars ../frontend/

cat ../frontend/${state}.tfvars >> ../frontend/terraform.tfvars
