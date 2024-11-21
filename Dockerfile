FROM adoptopenjdk/openjdk11

WORKDIR /app

COPY target/*.jar ./

EXPOSE 8080
 
CMD ["java", "-jar", "app.jar"]
