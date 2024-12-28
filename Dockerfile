# ビルドステージ
FROM gradle:8.7-jdk17 AS builder
WORKDIR /app

COPY build.gradle settings.gradle /app/
COPY src /app/src

RUN gradle clean build --no-daemon

# 実行ステージ
FROM eclipse-temurin:17-jdk
WORKDIR /app

COPY --from=builder /app/build/libs/spring-0.0.1-SNAPSHOT.jar app.jar

ENTRYPOINT ["java", "-jar", "app.jar"]