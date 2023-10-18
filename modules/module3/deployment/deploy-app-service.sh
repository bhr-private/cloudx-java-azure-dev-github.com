#!/bin/bash

set -e

appPath=$1
appServiceName=$2
dockerImageTag=$3
appSuffix=$4
settings=$5
appServicePlanName="${appServiceName}plan"
source $(dirname "$0")/parameters.sh

dockerAcrUri="${containerRegistryName}${appSuffix}.azurecr.io/${dockerImageTag}"

echo "Building and Pushing image tag ${dockerImageTag} to registry: ${dockerAcrUri}"
#az acr login -n "${containerRegistryName}${appSuffix}"

az acr build -t ${dockerImageTag} -r "${containerRegistryName}${appSuffix}" ${appPath}

echo "Creating App Service Plan: $appServicePlanName"
az appservice plan create --name "$appServicePlanName" --resource-group "$rgName" --is-linux

echo "Creating App Service Web App.: $appServiceName"
az webapp create -g "$rgName" -p "$appServicePlanName" -n "$appServiceName" -i "$dockerAcrUri"
# Enable continuous deployment
az webapp deployment container config --enable-cd true -g "$rgName" -n "$appServiceName"
if [ -n "$settings" ]
then
  echo "Configure Settings"
  az webapp config appsettings set -g "$rgName" -n "$appServiceName" --settings $settings
fi
