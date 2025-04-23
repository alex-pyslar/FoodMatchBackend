# Используем официальное Java 22 базовое изображение
FROM openjdk:22-jdk-slim

# Устанавливаем рабочую директорию в контейнере
WORKDIR /app

# Копируем файлы сборки и зависимости Gradle
COPY build.gradle settings.gradle gradlew ./
COPY gradle ./gradle

# Делаем скрипт gradlew исполняемым
RUN chmod +x gradlew

# Копируем оставшуюся часть проекта в контейнер
COPY . .

# Делаем скрипт gradlew исполняемым снова (на всякий случай)
RUN chmod +x gradlew

# Загружаем зависимости для Gradle
RUN ./gradlew dependencies --no-daemon

# Собираем приложение (создаем JAR файл)
RUN ./gradlew bootJar --no-daemon

# Указываем порт, который будет использоваться
EXPOSE 8080

# Добавляем скрипт для запуска приложения
COPY start.sh /app/start.sh
RUN chmod +x /app/start.sh

# Команда для запуска Spring Boot приложения через скрипт
CMD ["/app/start.sh"]
