## How to deploy PetStore to Kubernets and to AKS

### Pre-requisites
1. Azure Subscription was created
2. Azure CLI is installed
3. Docker and Kubernets are installed
3. Bash console is available

### Deployment steps to install petstore on local Kubernets 
1. Open Bash in this folder
2. Run the following commands:
```
kubectl create -f manifests/petstorepetservice.yaml

kubectl create -f manifests/petstoreproductservice.yaml

kubectl create -f manifests/petstoreorderservice.yaml

kubectl create -f manifests/petstoreapp.yaml
```
3. Check k8s deployments, services and pods with the following command:
```
kubectl get deployment,svc,pod --namespace ns-petstore
```
4. Open the Browser and go to: 'http://localhost:80' and verify that the petstore works as expected.

5. Cleanup with:
```
kubectl delete -f manifests/petstoreapp.yaml
```

### Deployment steps to install petstore on AKS
1. Open Bash in this folder
2. Run the following command:
```
./deploy-aks.sh <app-suffix>
```

This will create the ACR, build and deploy the image to ACR, create AKS and deploy the images to the AKS cluster.

3. copy the external IP address associated to the 'petstoreapp-service' service, for example `20.242.220.4` in the following line:
```
service/petstoreapp-service       LoadBalancer   10.0.115.244   20.242.220.4   80:32589/TCP   73s

```
4. Open the Browser and go to: 'http://<external_ip>:80' and verify that the petstore works as expected.
5. Cleanup with:
`../../module3/deployment/cleanup.sh`

