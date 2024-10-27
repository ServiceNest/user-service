# User Service API

This is a microservice for managing users in a clean, modular architecture. It includes basic CRUD functionality for users, along with testing that achieves a 98% coverage.

## Table of Contents

- [Requirements](#requirements)
- [Installation](#installation)
- [Usage](#usage)
- [API Endpoints](#api-endpoints)
- [Running Tests](#running-tests)
- [Project Structure](#project-structure)

## Requirements

- Docker
- Docker Compose

## Installation

To get started, first clone the repository and install the necessary dependencies.

```bash
git clone https://github.com/your-repo/user-service.git
cd user-service
```

Start the application using Docker Compose:

```bash
docker-compose up --build
```

This will build and start the services defined in docker-compose.yml. The service will be available at http://localhost:3000.

## Usage
Once the service is running, you can interact with the API via curl, Postman, or any other HTTP client.

Example of creating a user:
    
```bash
curl -X POST http://localhost:3000/api/v1/users \
-H "Content-Type: application/json" \
-d '{
  "user": {
    "email": "test@example.com",
    "password": "password123",
    "role": "client",
    "name": "John",
    "lastname": "Doe",
    "phone": "1234567890"
  }
}'
```

## API Endpoints
### POST /api/v1/users

Request:
```bash
{
  "user": {
    "email": "test@example.com",
    "password": "password123",
    "role": "client",
    "name": "John",
    "lastname": "Doe",
    "phone": "1234567890"
  }
}
```

Response:
- 201 Created: Returns the newly created user.
- 422 Unprocessable Entity: Returns validation errors if the request is invalid.

### GET /api/v1/users
Retrieves the details of a user by ID.

Response: 
- 200 OK: Returns the user details.
- 404 Not Found: If the user does not exist.

### PATCH /api/v1/users/:id
Updates an existing user.

Request:
```bash
{
  "user": {
    "name": "Jane"
  }
}
```

Response:
- 200 OK: Returns the updated user.
- 404 Not Found: If the user does not exist.
- 422 Unprocessable Entity: Returns validation errors if the request is invalid.

### DELETE /api/v1/users/:id

Deletes a user by ID.

Response:
- 204 No Content: If the user was successfully deleted.
- 404 Not Found: If the user does not exist.

### GET /api/v1/users/:id
Retrieves the details of a user by ID.

Response:
- 200 OK: Returns the users.

## Running Tests
The project includes unit tests for services, repositories, and controllers. The test coverage is currently at 98%.

To run the tests, use the following command:

```bash
docker-compose run app bundle exec rspec
```

## Project Structure
The project follows a clean architecture, with separate layers for controllers, services, repositories, and models.

```
app/
├── controllers/
│   └── api/
│       └── v1/
│           └── users_controller.rb
├── models/
│   └── user.rb
├── repositories/
│   └── users/
│       └── user_repository.rb
├── services/
│   └── users/
│       ├── create_user.rb
│       ├── update_user.rb
│       ├── show_user.rb
│       ├── destroy_user.rb
│       └── list_users.rb
└── serializers/
    └── user_serializer.rb
```

Each component is responsible for a specific part of the application logic, ensuring that the project remains scalable and easy to maintain.

## License
```
This project is open-source and available under the [MIT License](LICENSE).
```
