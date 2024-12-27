# ビルドステージ
FROM gradle:8.7-jdk17 AS builder
WORKDIR /app

# キャッシュを活用するため、依存関係だけ先にコピーしてインストール
COPY build.gradle settings.gradle /app/
COPY src /app/src

RUN gradle clean build --no-daemon

# 実行ステージ
FROM eclipse-temurin:17-jdk
WORKDIR /app

# ビルドしたJARファイルをコピー
COPY --from=builder /app/build/libs/spring-0.0.1-SNAPSHOT.jar app.jar

# 実行コマンド
ENTRYPOINT ["java", "-jar", "app.jar"]