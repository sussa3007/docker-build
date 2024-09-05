# Base image
FROM openjdk:17-jdk-slim

# Set the working directory
WORKDIR /app

# Copy the build file
COPY *.jar /app/web-server.jar

# Expose the port the application runs on
EXPOSE 8082

# Define entrypoint
ENTRYPOINT ["java", "-jar", "/app/web-server.jar", "--spring.profiles.active=dev"]