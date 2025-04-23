#!/bin/bash

# Ищем последний JAR файл в директории build/libs
JAR_FILE=$(find /app/build/libs -name "*.jar" -print0 | xargs -0 ls -t | head -n 1)

# Проверяем, что JAR файл найден
if [ -z "$JAR_FILE" ]; then
  echo "JAR file not found!"
  exit 1
fi

# Запускаем найденный JAR файл
echo "Running JAR file: $JAR_FILE"
exec java -jar "$JAR_FILE"
