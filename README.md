# FoodMatchBackend

## Обзор
**FoodMatchBackend** — это RESTful веб-сервис, разработанный на Java с использованием Spring Boot, предназначенный для управления пользователями, продуктами и рецептами. Сервис предоставляет API для выполнения CRUD-операций (создание, чтение, обновление, удаление) над сущностями, а также поддерживает связи между продуктами и рецептами, позволяя находить рецепты по продуктам и наоборот. Проект использует Swagger для документирования API и Docker для контейнеризации, обеспечивая простую развертку и масштабируемость.

Проект подходит для разработчиков, желающих изучить создание REST API, интеграцию с базой данных и настройку микросервисов с использованием современных Java-технологий.

## Особенности
- **CRUD-операции**: Полная поддержка операций создания, чтения, обновления и удаления для пользователей, продуктов и рецептов.
- **Связи между сущностями**:
  - Получение продуктов по ID рецепта или списка рецептов.
  - Получение рецептов по ID продукта или списка продуктов.
- **Документация API**: Интерактивная документация через Swagger UI для удобного тестирования endpoint'ов.
- **Контейнеризация**: Поддержка Docker для упрощения развертывания.
- **Обработка ошибок**: Кастомные исключения (`ProductNotFoundException`, `RecipeNotFoundException`, `UserNotFoundException`) для обработки случаев отсутствия данных.
- **Модульная структура**: Разделение на контроллеры, сервисы и DTO для чистоты кода.

## Требования
- **Java**: 17 или выше.
- **Gradle**: 8.x или выше.
- **Docker**: Для контейнеризации (опционально).
- **База данных**: PostgreSQL (или другая, поддерживаемая Spring Data JPA).
- **Gradle**: Для управления зависимостями.
- **Swagger**: Для доступа к документации API.

## Установка и запуск

### Клонирование репозитория
```bash
git clone https://github.com/alex-pyslar/FoodMatchBackend.git
cd FoodMatchBackend
```

### Настройка базы данных
1. Убедитесь, что PostgreSQL (или другая поддерживаемая БД) запущена.
2. Настройте параметры подключения в `src/main/resources/application.properties`:
   ```properties
   spring.datasource.url=jdbc:postgresql://localhost:5432/foodmatch
   spring.datasource.username=your_username
   spring.datasource.password=your_password
   spring.jpa.hibernate.ddl-auto=update
   ```

### Сборка и запуск без Docker
1. Соберите проект:
   ```bash
   ./gradlew build
   ```
2. Запустите приложение:
   ```bash
   ./gradlew bootRun
   ```
3. Приложение будет доступно по адресу: `http://localhost:8080`.

### Запуск с Docker
1. Убедитесь, что Docker установлен.
2. Соберите Docker-образ:
   ```bash
   docker build -t foodmatch-backend .
   ```
3. Запустите контейнер:
   ```bash
   docker run -p 8080:8080 --name foodmatch-backend -e SPRING_DATASOURCE_URL=jdbc:postgresql://host.docker.internal:5432/foodmatch -e SPRING_DATASOURCE_USERNAME=your_username -e SPRING_DATASOURCE_PASSWORD=your_password foodmatch-backend
   ```
4. Приложение будет доступно по адресу: `http://localhost:8080`.

### Доступ к Swagger UI
После запуска приложения откройте документацию API:
```
http://localhost:8080/swagger-ui.html
```

## API
API предоставляет endpoint'ы для работы с пользователями, продуктами и рецептами. Полное описание доступно в Swagger UI. Основные endpoint'ы:

### Пользователи (`/users`)
- **POST /users**: Создать нового пользователя (`UserDTO`).
- **GET /users**: Получить список всех пользователей.
- **GET /users/{id}**: Получить пользователя по ID.
- **GET /users/batch?ids=1,2,3**: Получить пользователей по списку ID.
- **PUT /users**: Обновить данные пользователя.
- **DELETE /users/{id}**: Удалить пользователя.

### Продукты (`/products`)
- **POST /products**: Создать новый продукт (`ProductDTO`).
- **GET /products**: Получить список всех продуктов.
- **GET /products/{id}**: Получить продукт по ID.
- **GET /products/batch?ids=1,2,3**: Получить продукты по списку ID.
- **GET /products/recipe/{id}**: Получить продукты по ID рецепта.
- **GET /products/recipe/batch?ids=1,2,3**: Получить продукты по списку ID рецептов.
- **PUT /products**: Обновить данные продукта.
- **DELETE /products/{id}**: Удалить продукт.

### Рецепты (`/recipes`)
- **POST /recipes**: Создать новый рецепт (`RecipeDTO`).
- **GET /recipes**: Получить список всех рецептов.
- **GET /recipes/{id}**: Получить рецепт по ID.
- **GET /recipes/batch?ids=1,2,3**: Получить рецепты по списку ID.
- **GET /recipes/product/{id}**: Получить рецепты по ID продукта.
- **GET /recipes/product/batch?ids=1,2,3**: Получить рецепты по списку ID продуктов.
- **PUT /recipes**: Обновить данные рецепта.
- **DELETE /recipes/{id}**: Удалить рецепт.

## Тестирование
Для запуска тестов выполните:
```bash
./gradlew test
```
Тесты включают проверки контроллеров, сервисов и репозиториев.

## Структура проекта
- **`src/main/java/com/alexpyslar03/productselectorbackend/controller`**: Контроллеры для обработки HTTP-запросов (`ProductController.java`, `RecipeController.java`, `UserController.java`).
- **`src/main/java/com/alexpyslar03/productselectorbackend/service`**: Сервисы для бизнес-логики.
- **`src/main/java/com/alexpyslar03/productselectorbackend/entity`**: Сущности JPA (`Product`, `Recipe`, `User`).
- **`src/main/java/com/alexpyslar03/productselectorbackend/dto`**: DTO для передачи данных.
- **`src/main/resources/application.properties`**: Конфигурация приложения.
- **`Dockerfile`**: Инструкции для контейнеризации.
- **`start.sh`**: Скрипт для запуска приложения в контейнере.

## Известные проблемы
- **База данных**: Если параметры подключения в `application.properties` неверны, приложение не запустится.
- **Swagger UI**: На некоторых конфигурациях может потребоваться дополнительная настройка CORS.
- **Docker**: Убедитесь, что PostgreSQL доступен для контейнера (например, через `host.docker.internal`).

## Планы на будущее
- Добавить авторизацию и аутентификацию (JWT).
- Реализовать пагинацию и фильтрацию для списков.
- Добавить интеграционные тесты для проверки связей между сущностями.
- Внедрить кэширование для оптимизации запросов.
- Разработать клиентский интерфейс (например, на React) для взаимодействия с API.

## Лицензия
Проект распространяется под лицензией Apache License 2.0. Подробности см. в файле `LICENSE`.

## Контакты
- **Автор**: Alex Pyslar
- **GitHub**: [alex-pyslar](https://github.com/alex-pyslar)
- **Email**: Свяжитесь через GitHub Issues.

## Как внести вклад
1. Сделайте форк репозитория.
2. Создайте новую ветку (`git checkout -b feature/your-feature`).
3. Внесите изменения и закоммитьте их (`git commit -m "Добавлена новая функция"`).
4. Отправьте ветку в репозиторий (`git push origin feature/your-feature`).
5. Откройте pull request.

---
*Создано с ❤️ для разработчиков REST API и любителей кулинарии*