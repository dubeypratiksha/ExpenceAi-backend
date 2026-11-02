FROM eclipse-temurin:17-jdk-alpine as builder
WORKDIR /app
COPY . ./
RUN chmod +x ./mvnw
RUN ./mvnw clean package -DskipTests
RUN ./mvnw clean package -DskipTests

FROM eclipse-temurin:17-jre
WORKDIR /app
COPY --from=builder /app/target/*.jar app.jar
EXPOSE 8080
CMD ["java","-jar","app.jar"]