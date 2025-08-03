# Rusty Book Manager

A modern book management system built with Rust, featuring user authentication, role-based access control, and REST APIs.

## Features

- 📚 **Book Management**: Create, list, and view books
- 👥 **User Management**: User registration, authentication, and role management
- 🔐 **Authentication**: JWT-based authentication with secure password hashing
- 🛡️ **Authorization**: Role-based access control (Admin/User roles)
- 📖 **API Documentation**: Interactive OpenAPI/Swagger documentation
- 🔍 **Health Monitoring**: Health check endpoints with database connectivity status
- 📊 **Observability**: Distributed tracing with OpenTelemetry and Jaeger

## Architecture

The application follows a **clean architecture** pattern with clear separation of concerns:

- **api/**: HTTP handlers, routing, and request/response models (web layer)
- **kernel/**: Business logic, domain models, and repository traits (domain layer)
- **adapter/**: Database and Redis implementations (infrastructure layer)
- **shared/**: Common configuration, error handling, and utilities
- **registry/**: Dependency injection container

## Tech Stack

- **Language**: Rust 2024 Edition
- **Web Framework**: Axum (async)
- **Database**: PostgreSQL with SQLx
- **Cache**: Redis
- **Authentication**: JWT with bcrypt
- **Documentation**: utoipa (OpenAPI)
- **Testing**: cargo-nextest, rstest, mockall
- **Containerization**: Docker & Docker Compose
- **Tracing**: OpenTelemetry with Jaeger

## Prerequisites

- [Rust](https://rustup.rs/) (1.88+)
- [Docker](https://docs.docker.com/get-docker/) and [Docker Compose](https://docs.docker.com/compose/install/)
- [cargo-make](https://github.com/sagiegurari/cargo-make) - Install with: `cargo install cargo-make`

## Quick Start

### 1. Clone the Repository

```bash
git clone <repository-url>
cd rusty-book-manaager
```

### 2. Start the Application

```bash
# Run the application (automatically sets up database and dependencies)
cargo make run
```

This command will:
- Start PostgreSQL and Redis containers
- Run database migrations
- Start the web server on `http://localhost:8080`

### 3. Access the Application

- **API Base URL**: `http://localhost:8080`
- **Health Check**: `http://localhost:8080/health`
- **API Documentation**: `http://localhost:8080/redoc` (once implemented)

## Development

### Available Commands

```bash
# Development
cargo make run              # Run locally with auto-setup
cargo make watch           # Watch mode (fmt + clippy + test on changes)
cargo make build           # Build the application

# Code Quality
cargo make fmt             # Format code
cargo make clippy          # Run linter
cargo make test            # Run tests

# Database
cargo make migrate         # Run database migrations
cargo make psql           # Connect to database
cargo make initial-setup   # Set up initial data (admin user)

# Docker
cargo make run-in-docker   # Run full stack in Docker
cargo make compose-up-db   # Start only PostgreSQL
cargo make compose-up-redis # Start only Redis
cargo make compose-down    # Stop all containers
```

### Initial Setup

After starting the application for the first time, you can set up initial data:

```bash
cargo make initial-setup
```

This creates:
- Admin and User roles
- Default admin user: `eleazar.fig@example.com` (password: `password123`)

### Running Tests

```bash
# Run all tests
cargo make test

# Run tests for a specific package
cargo test -p api
cargo test -p kernel
cargo test -p adapter
```

### Database Management

```bash
# Create a new migration
cargo make sqlx migrate add <migration_name>

# Run migrations
cargo make migrate

# Check migration status
cargo make sqlx migrate info
```

## API Endpoints

### Authentication
- `POST /auth/login` - User login
- `POST /auth/logout` - User logout

### Users
- `POST /v1/users` - Create user (Admin only)
- `GET /v1/users` - List users (Admin only)
- `GET /v1/users/me` - Get current user info
- `PUT /v1/users/{id}/password` - Change user password
- `PUT /v1/users/{id}/role` - Change user role (Admin only)
- `DELETE /v1/users/{id}` - Delete user (Admin only)

### Books
- `POST /v1/books` - Create book
- `GET /v1/books` - List books
- `GET /v1/books/{id}` - Get book details

### Health
- `GET /health` - Basic health check
- `GET /health/db` - Database connectivity check

## Configuration

The application uses environment variables for configuration. Default values are set in `Makefile.toml`:

```bash
HOST=0.0.0.0
PORT=8080
DATABASE_URL=postgresql://localhost:5432/app?user=app&password=passwd
REDIS_HOST=localhost
REDIS_PORT=6379
AUTH_TOKEN_TTL=86400  # 24 hours in seconds
```

## Docker Deployment

### Using Docker Compose

```bash
# Build and run the complete stack
cargo make run-in-docker

# View logs
cargo make logs

# Stop the stack
cargo make compose-down
```

### Manual Docker Build

```bash
# Build the application image
docker build -t rusty-book-manager .

# Run with existing PostgreSQL and Redis
docker run -p 8080:8080 \
  -e DATABASE_URL=postgresql://user:pass@host:5432/db \
  -e REDIS_HOST=redis-host \
  rusty-book-manager
```

## Development Guidelines

### Code Style
- Follow standard Rust conventions
- Use `cargo make fmt` for consistent formatting
- Run `cargo make clippy` and fix all warnings
- Write tests for new functionality

### Before Committing
```bash
cargo make fmt
cargo make clippy
cargo make test
```

### Architecture Patterns
- Use repository traits in `kernel/`, implementations in `adapter/`
- Handle errors with `shared::error::AppError`
- Use `AppRegistry` for dependency injection
- Follow clean architecture principles

## Monitoring and Observability

The application includes distributed tracing support:

- **Jaeger**: Distributed tracing (configured in `compose.yaml`)
- **Structured Logging**: JSON logs with tracing spans
- **Health Checks**: Database connectivity monitoring

## Contributing

1. Fork the repository
2. Create a feature branch: `git checkout -b feature-name`
3. Make your changes and add tests
4. Run the test suite: `cargo make test`
5. Ensure code quality: `cargo make fmt && cargo make clippy`
6. Commit your changes: `git commit -am 'Add feature'`
7. Push to the branch: `git push origin feature-name`
8. Submit a pull request
