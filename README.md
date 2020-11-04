# terraform-azure-scaleset-loadbalancer-multi-region-deployment-demo
terraform-azure-scaleset&amp;loadbalancer-multi-region-deployment-demo

use below commnds to get authenticate using Azure CLI through terraform.

/*
export ARM_SUBSCRIPTION_ID="$(az keyvault secret show --vault-name "your_key_vault_name"  --name "your_key_name_in_vault_(ex-subscriptionId)" --query "[value]" -o tsv)"
export ARM_TENANT_ID="$(az keyvault secret show --vault-name "your_key_vault_name"  --name "your_key_name_in_vault_(ex-tenantId)" --query "[value]" -o tsv)"
export ARM_CLIENT_SECRET="$(az keyvault secret show --vault-name "your_key_vault_name"  --name "your_key_name_in_vault_(ex-clientSecret)" --query "[value]" -o tsv)"
export ARM_CLIENT_ID="$(az keyvault secret show --vault-name "your_key_vault_name"  --name "your_key_name_in_vault_(ex-clientId)" --query "[value]" -o tsv)"
export ARM_ADMIN_PASSWORD="$(az keyvault secret show --vault-name "your_key_vault_name"  --name "your_key_name_in_vault_(ex-admin-password)" --query "[value]" -o tsv)"
export ARM_ADMIN_USERNAME="$(az keyvault secret show --vault-name "your_key_vault_name"  --name "your_key_name_in_vault_(ex-admin-username)" --query "[value]" -o tsv)"
export ARM_ENVIRONMENT=DevTest

*/

az login

az account list

az account set --subscription="SUBSCRIPTION_ID"

az ad sp create-for-rbac --role="Contributor" --scopes="/subscriptions/SUBSCRIPTION_ID"

az login --service-principal -u CLIENT_ID -p CLIENT_SECRET --tenant TENANT_ID

# in case of any issues with not being able to login through azure cli using terraform - use below commands.

# AZURE_CLI_PATH="/c/Program Files (x86)/Microsoft SDKs/Azure/CLI2"

# export PATH="${PATH}:${AZURE_CLI_PATH}:${AZURE_CLI_PATH}/Scripts"
