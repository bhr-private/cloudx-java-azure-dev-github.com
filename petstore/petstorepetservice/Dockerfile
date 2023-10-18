#
# Build stage
#
FROM maven:3.8.4-openjdk-17-slim AS build
WORKDIR /build
#WORKDIR petstore/petstorepetservice
COPY petstore/petstorepetservice/pom.xml .
COPY petstore/petstorepetservice/src ./src
RUN mvn clean package

#
# Package stage
#
FROM openjdk:17-slim
COPY --from=build /build/target/*.jar /app/petstorepetservice.jar
EXPOSE 8080
ENTRYPOINT ["java","-jar","/app/petstorepetservice.jar"]
