# build application
FROM eclipse-temurin:17-jdk-jammy as builder

WORKDIR /app

RUN echo 'copy local source to builder'
COPY . /app

RUN echo 'build application with gradle'
#RUN ./gradlew --version

RUN ./gradlew build --no-daemon -x test


# run java application
FROM eclipse-temurin:17-jre
RUN echo 'deploy and start application'
#RUN ./gradlew --version
COPY --from=builder /app/build/libs/web-api-system-0.0.1-SNAPSHOT.jar ./

EXPOSE 8080
ENTRYPOINT [ "java", \
    "-jar", \
    "-Djava.security.egd=file:/dev/./urandom", \
    "-Dsun.net.inetaddr.ttl=0", \
    "web-api-system-0.0.1-SNAPSHOT.jar" \
]