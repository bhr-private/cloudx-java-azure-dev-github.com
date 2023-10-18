## How to deploy PetStore

### Pre-requisites
1. Azure Subscription was created
2. Azure CLI is installed
3. Bash console is available

### Deployment steps for Azure Web App
1. Open Bash in this folder
2. Login to Azure
```az login```
3. Verify that you have the version 17 of Java installed in your system or install it otherwise
4. Verify that you can successfully build all the Java petstore services on your system:
```
cd petstore/petstoreapp
mvn build package
```
Repeat the above step for petstoreorderservice, petstorepetservice and petstoreproductservice.

5. For every petstore application service configure the Azure WebApp maven plugin with:
```
cd petstore/petstoreapp
mvn com.microsoft.azure:azure-webapp-maven-plugin:2.11.0:config
```
When requested enter the appName = petstoreapp${suffix}, resourceGroup = petstorerg, region = westus, pricingTier = B1
Repeat the above steps for all the petstore services and specify the proper appName with same ${suffix}.

6. Deploy the Web App service to Azure with:
```
cd petstore/petstoreapp
mvn package azure-webapp:deploy
```
Repeat the above step for petstoreorderservice, petstorepetservice and petstoreproductservice.

7. Using the Azure CLI or the Portal configure the following parameters for the petstoreapp:
```
PETSTOREPRODUCTSERVICE_URL=https://${productservice}.azurewebsites.net 
PETSTOREPETSERVICE_URL=https://${petservice}.azurewebsites.net 
PETSTOREORDERSERVICE_URL=https://${orderservice}.azurewebsites.net
```
and the following parameters for the petstoreorderservice:
```
PETSTOREPRODUCTSERVICE_URL=https://${productservice}.azurewebsites.net
```

8. Verify that the application works and remove all the associated resources.

### Deployment steps for Azure Spring Apps
1. Open Bash in this folder
2. Login to Azure
```az login```
3. Verify that you have the version 17 of Java installed in your system or install it otherwise
4. Restore the codebase to the original branch status (in case pom.xml were changed from previous training)
5. Verify that you can successfully build all the Java petstore services on your system:
```
cd petstore/petstoreapp
mvn build package
```
6. Run the following script to deploy the Spring Apps instance and the Spring applications:
```
./deploy-spring-apps.sh <suffix>
```
7. Verify the the application works properly using petstoreapp URL *https://petstore${suffix}-petstoreapp${suffix}.azuremicroservices.io*

### Cleanup
`./cleanup.sh`



