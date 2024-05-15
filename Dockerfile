# Use an official OpenJDK runtime as a parent image
FROM openjdk:11-jre-slim

# Set the working directory in the container
WORKDIR /app

# Copy the application's jar to the container
COPY target/spring-petclinic-3.2.0-SNAPSHOT.jar /app/spring-petclinic-3.2.0-SNAPSHOT.jar

# Run the jar file
ENTRYPOINT ["java", "-jar", "spring-petclinic-3.2.0-SNAPSHOT.jar"]