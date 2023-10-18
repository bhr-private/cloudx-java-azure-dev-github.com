# Cloudx Java Azure Dev

Azure Cloud Introductory course for Java Developers. \
Based on the similar course for .Net Devs: [CloudX Associate: MS Azure Developer](https://learn.epam.com/detailsPage?id=03203120-312d-4253-917b-57017b5693d5&source=PROGRAM)

## Repository Structure
1. `./petstore` - home dir for PetStore code-base
2. `./modules` - home dir for course modules
3. `./modules/moduleN` - home dir for module-related materials
4. `./modules/moduleN/README.md` - module contents that Student will see
5. `./modules/moduleN/TODO.md` - set of remaining tasks for a specific module
6. `./modules/moduleN/deployment` - set of deployment automation scripts (either for Mentor convenience, or can be shared with Student)

# Deployments

## Modules 1-3
1. created local Docker files ( build > issue with curl command ), Github actions, petstoreapp doesn't start
2. deployment with cloudx-java-azure-dev scripts; fails multiple due to 2 subscriptions until successful
3. Traffic Manager Profile & app management service created ( dependencies not clear ), api management doesn't start

## Modules 4

### create ssh connection to Azure Docker container
az webapp create-remote-connection --subscription 61ffb489-ccb3-4366-b0a7-c69e0405a8eb --resource-group petstorerg -n petstoreappbhr &

OR USE SSH IN APP SERVICE

### create log analytics workspace


### add agent & json files

The Log Analytics agents won’t be supported as of August 31, 2024. Plan to migrate to Azure Monitor Agent 

#### adding agent to local Docker
docker cp applicationinsights.json mystifying_cerf:/app/applicationinsights.json

#### installing agent

ONCE APP INSUGHT IS ENABLED AGENT AND CONNECTION SETTING ARE ENABLED AUTOMATICALLY

https://learn.microsoft.com/en-us/azure/azure-monitor/app/azure-web-apps-java#manually-deploy-the-latest-application-insights-java-version

az webapp deploy --src-path applicationinsights-agent-{VERSION_NUMBER}.jar --target-path java/applicationinsights-agent-{VERSION_NUMBER}.jar --type static --resource-group {YOUR_RESOURCE_GROUP} --name {YOUR_APP_SVC_NAME}

IS THAT CORRECT ( FILE SIZES DO NOT MATCH )?
root@dcf412567859:/agents/java# ls -alp
total 36296
drwxr-xr-x 2 root root     4096 Oct 17 08:39 ./
drwxr-xr-x 5 root root     4096 Oct 18 08:38 ../
-rw-rw-rw- 1 root root 37157270 Jul 17 17:37 applicationinsights-agent-codeless.jar
-rw-rw-rw- 1 root root        0 Jul 17 17:37 appsvc.codeless

HERE IT IS :

Index of /wwwroot/java/
Name	Size	Last Modified
applicationinsights-agent-3.4.17.jar	40,703,707	10/18/2023 08:37:52 +00:00


root@eec447fc7e5a:/var/log/applicationinsights# cat applicationinsights.log
2023-10-18 08:39:02.873Z INFO  c.m.applicationinsights.agent - Application Insights Java Agent 3.4.14 started successfully (PID 1, JVM running for 17.92 s)

root@eec447fc7e5a:/var/log/applicationinsights# cat status_lw0sdlwk00060I_1.json
{
 "AgentInitializedSuccessfully": true,
 "SDKPresent": true,
 "AppType": "java",
 "MachineName": "lw0sdlwk00060I",
 "PID": "1",
 "SdkVersion": "3.4.14",
 "SiteName": "petstoreappbhr",
 "Ikey": "2ebbc91b-05d0-4bf4-9385-e756d4f54f71",
 "ExtensionVersion": "disabled"

#### connection string
https://learn.microsoft.com/en-us/azure/azure-monitor/app/opentelemetry-enable?tabs=java

desired configuration settings (excluding the connection string, which will be populated automatically) 

WHAT IS OMS ?
wget https://raw.githubusercontent.com/Microsoft/OMS-Agent-for-Linux/master/installer/scripts/onboard_agent.sh && sh onboard_agent.sh -w 3f355e06-ec27-4b49-9dad-0abc0ecf8dcd -s bKa1KoOXWyCZubqBPb3TBG4dBQRWQsqCwStGeKC30igmeIvlCtwl43wWqAUxRL9ooKmBTas5JwfNKBr94ixOkQ== -d opinsights.azure.com

### kudu

The Kudu Console is a tool that gives you both command line and file browser access to your sites, all from the comfort of a web browser.

ALSO 