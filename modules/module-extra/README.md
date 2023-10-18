# Module Extra: Azure App Service and Azure Spring Apps Java deployment
## Self-study materials
Please, study the following materials:

### Recommended:
- [Deploy a Java application on Azure App Service](https://learn.microsoft.com/en-us/azure/app-service/quickstart-java?tabs=javase&pivots=platform-linux-development-environment-maven) 
- [Azure Spring Apps documentation](https://learn.microsoft.com/en-us/azure/spring-apps/)
- [Deploy a Java application on Azure Spring Apps](https://learn.microsoft.com/en-us/azure/spring-apps/quickstart?tabs=Azure-CLI&pivots=sc-consumption-plan)

*When you finish, please change the assignment status from "Planned" to "Done"*

## Home task
Please, complete the following task:

- PetStore is a web application that contains:
  * Web: *petstoreapp*
  * API services: *petstorepetservice*, *petstoreproductservice*, *petstoreorderservice*
- These services need to be deployed to respective Azure App Services using Java deployment.
- App Service configuration needs to be updated to point Web Site to API services URLs.
- Remove all the resource and re-deploys the services to an Azure Spring App instance.

[PetStore source code](https://git.epam.com/Andrea_Bondavalli/cloudx-java-azure-dev/-/tree/main).

### Definition of done:

- Verify that for both the cases the Web application works

## Clean up:
Resources left running can cost you money. You can delete resources individually or delete the resource group to delete the entire set of resources.
### Definition of done:
- Resources are deleted

