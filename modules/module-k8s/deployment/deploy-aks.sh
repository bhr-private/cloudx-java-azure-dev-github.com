#!/bin/sh
set -e

source ../../module3/deployment/parameters.sh

appSuffix=$1
productserviceSubdomain=$springAppsIns-petstoreproductservice$appSuffix
orderserviceSubdomain=$springAppsIns-petstoreorderservice$appSuffix
petserviceSubdomain=$springAppsIns-petstorepetservice$appSuffix

#creating RG and ACR first
../../module3/deployment/deploy-rg-acr.sh $appSuffix

petserviceTag=petstorepetservice
petserviceSubdomain="${petserviceTag}${appSuffix}"
productserviceTag=petstoreproductservice
productserviceSubdomain="${productserviceTag}${appSuffix}"
orderserviceTag=petstoreorderservice
orderserviceSubdomain="${orderserviceTag}${appSuffix}"
webAppTag=petstoreapp
webAppSubdomain="${webAppTag}${appSuffix}"

#build petstore images with ACR
az acr build -t ${petserviceTag} -r "${containerRegistryName}${appSuffix}" ../../../petstore/petstorepetservice
az acr build -t ${productserviceTag} -r "${containerRegistryName}${appSuffix}" ../../../petstore/petstoreproductservice
az acr build -t ${orderserviceTag} -r "${containerRegistryName}${appSuffix}" ../../../petstore/petstoreorderservice
az acr build -t ${webAppTag} -r "${containerRegistryName}${appSuffix}" ../../../petstore/petstoreapp


aksClusterName=petstoreakscluster${appSuffix}
#create AKS instance
az aks create --resource-group ${rgName} --name ${aksClusterName} --node-count 2 --generate-ssh-keys --attach-acr ${containerRegistryName}

#install kubectl in case it's not installed
#az aks install-cli

#configure kubectl to connect to your Kubernetes cluster
az aks get-credentials --resource-group ${rgName} --name ${aksClusterName}

#fetch current k8s config context
kubectl config get-contexts
#list nodes
kubectl get nodes

#get ACR name to be used in manifest files
az acr list --resource-group petstorerg  --query "[].{acrLoginServer:loginServer}" --output table

#deploy Docker images to AKS

kubectl create -f manifests-aks/petstorepetservice.yaml

kubectl create -f manifests-aks/petstoreproductservice.yaml

kubectl create -f manifests-aks/petstoreorderservice.yaml

kubectl create -f manifests-aks/petstoreapp.yaml

#check deployment status
kubectl get deployment,svc,pod --namespace ns-petstore

