#!/bin/sh
set -e

source ../../module3/deployment/parameters.sh

appSuffix=$1
springAppsIns=petstore$appSuffix
productserviceSubdomain=$springAppsIns-petstoreproductservice$appSuffix
orderserviceSubdomain=$springAppsIns-petstoreorderservice$appSuffix
petserviceSubdomain=$springAppsIns-petstorepetservice$appSuffix

az group create --name $rgName --location $location

az spring create --resource-group $rgName --name $springAppsIns

az spring app create --resource-group $rgName --service $springAppsIns --name petstoreapp$appSuffix \
     --assign-endpoint true --runtime-version Java_17

az spring app create --resource-group $rgName --service $springAppsIns --name petstorepetservice$appSuffix \
     --assign-endpoint true --runtime-version Java_17

az spring app create --resource-group $rgName --service $springAppsIns --name petstoreorderservice$appSuffix \
     --assign-endpoint true --runtime-version Java_17

az spring app create --resource-group $rgName --service $springAppsIns --name petstoreproductservice$appSuffix \
     --assign-endpoint true --runtime-version Java_17

cd ../../../petstore/

cd ./petstoreproductservice/
mvn clean package
az spring app deploy --resource-group $rgName --service $springAppsIns --name petstoreproductservice$appSuffix \
    --artifact-path target/petstoreproductservice-0.0.1-SNAPSHOT.jar

cd ../petstorepetservice/
mvn clean package
az spring app deploy --resource-group $rgName --service $springAppsIns --name petstorepetservice$appSuffix \
    --artifact-path target/petstorepetservice-0.0.1-SNAPSHOT.jar

cd ../petstoreorderservice/
mvn clean package
az spring app deploy --resource-group $rgName --service $springAppsIns --name petstoreorderservice$appSuffix \
    --artifact-path target/petstoreorderservice-0.0.1-SNAPSHOT.jar \
    --env PETSTOREPRODUCTSERVICE_URL=https://${productserviceSubdomain}.azuremicroservices.io

cd ../petstoreapp/
mvn clean package
az spring app deploy --resource-group $rgName --service $springAppsIns --name petstoreapp$appSuffix \
    --artifact-path target/petstoreapp-0.0.1-SNAPSHOT.jar \
    --env PETSTOREPRODUCTSERVICE_URL=https://${productserviceSubdomain}.azuremicroservices.io \
 PETSTOREPETSERVICE_URL=https://${petserviceSubdomain}.azuremicroservices.io \
 PETSTOREORDERSERVICE_URL=https://${orderserviceSubdomain}.azuremicroservices.io

cd $(dirname "$0")

