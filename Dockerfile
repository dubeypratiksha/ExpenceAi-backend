
# Stage 1: Build the Spring Boot application
FROM eclipse-temurin:17-jdk-alpine AS builder

WORKDIR /app

COPY . ./

# Give Maven Wrapper execution permission
RUN chmod +x ./mvnw

# Build the application
RUN ./mvnw clean package -DskipTests

# Stage 2: Run the application
FROM eclipse-temurin:17-jre

WORKDIR /app

# Copy the generated JAR from the build stage
COPY --from=builder /app/target/*.jar app.jar

EXPOSE 8080

CMD ["java", "-jar", "app.jar"]
