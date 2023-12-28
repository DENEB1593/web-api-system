# build application
# gradlew의 경우 gradlew를 사용하면 docker에서 gradle은 다운로드하여 빌드 시간이 더 소요 됨
FROM gradle:jdk17 as builder


WORKDIR /app

COPY . /app

#RUN ./gradlew --version

RUN gradle build --no-daemon -x test


# run java application
FROM eclipse-temurin:17-jre

#RUN ./gradlew --version
COPY --from=builder /app/build/libs/web-api-system-0.0.1-SNAPSHOT.jar ./

EXPOSE 8080
ENTRYPOINT [ "java", \
    "-jar", \
    "-Djava.security.egd=file:/dev/./urandom", \
    "-Dsun.net.inetaddr.ttl=0", \
    "web-api-system-0.0.1-SNAPSHOT.jar" \
]