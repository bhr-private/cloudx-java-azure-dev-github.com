#!/bin/bash

set -e

appSuffix=$1
petserviceTag=petstorepetservice
petserviceSubdomain="${petserviceTag}${appSuffix}"
productserviceTag=petstoreproductservice
productserviceSubdomain="${productserviceTag}${appSuffix}"
orderserviceTag=petstoreorderservice
orderserviceSubdomain="${orderserviceTag}${appSuffix}"
webAppTag=petstoreapp
webAppSubdomain="${webAppTag}${appSuffix}"

#creating RG and ACR first to let container ACR time to initialize, while dockers are being built
./deploy-rg-acr.sh $appSuffix

# back to working dir
./deploy-app-service.sh ../../../petstore/petstorepetservice $petserviceSubdomain $petserviceTag $appSuffix
./deploy-app-service.sh ../../../petstore/petstoreproductservice $productserviceSubdomain $productserviceTag $appSuffix 
./deploy-app-service.sh ../../../petstore/petstoreorderservice $orderserviceSubdomain $orderserviceTag $appSuffix "PETSTOREPRODUCTSERVICE_URL=https://${productserviceSubdomain}.azurewebsites.net/"
./deploy-app-service.sh ../../../petstore/petstoreapp $webAppSubdomain $webAppTag $appSuffix "PETSTOREPRODUCTSERVICE_URL=https://${productserviceSubdomain}.azurewebsites.net PETSTOREPETSERVICE_URL=https://${petserviceSubdomain}.azurewebsites.net PETSTOREORDERSERVICE_URL=https://${orderserviceSubdomain}.azurewebsites.net"
