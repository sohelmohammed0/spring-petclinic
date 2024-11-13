# Stage 1: Build the application with Maven
FROM maven:3.8.5-openjdk-17 AS build
WORKDIR /app

# Copy the Maven project files
COPY pom.xml ./
COPY src ./src

# Build the application and skip tests to speed up the process
RUN mvn clean package -DskipTests

# Stage 2: Run the application in a lightweight JDK environment
FROM openjdk:17-jdk-slim
WORKDIR /app

# Copy only the built JAR file from the previous stage
COPY --from=build /app/target/*.jar app.jar

# Expose the application's port (update this if your app uses a different port)
EXPOSE 8080

# Define the entry point to run the application
ENTRYPOINT ["java", "-jar", "app.jar"]
