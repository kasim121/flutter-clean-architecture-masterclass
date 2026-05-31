# Flutter Clean Architecture Masterclass

A comprehensive Flutter project demonstrating **Clean Architecture** using the three most popular state management solutions:

* Provider
* Riverpod
* Bloc

This repository is designed for developers who want to learn how to build scalable, maintainable, and testable Flutter applications using industry-standard architecture patterns.

---

## 🚀 What Makes This Repository Different?

Most Clean Architecture repositories demonstrate only one state management solution and always rely on Dependency Injection.

This repository demonstrates:

✅ Provider + Clean Architecture

✅ Riverpod + Clean Architecture

✅ Bloc + Clean Architecture

✅ With Dependency Injection (GetIt)

✅ Without Dependency Injection

This allows you to compare approaches and understand the trade-offs of each implementation.

---

## 📚 Learning Objectives

By studying this repository, you will learn:

* Clean Architecture
* SOLID Principles
* Repository Pattern
* Dependency Injection
* Service Locator Pattern
* Provider State Management
* Riverpod State Management
* Bloc State Management
* Feature-First Architecture
* API Integration
* Scalable Flutter Project Structure
* Separation of Concerns
* Testable Code Design

---

## 🏛️ Architecture Overview

```text
Presentation Layer
       │
       ▼
Domain Layer
       │
       ▼
Data Layer
```

### Presentation Layer

Responsible for:

* UI
* State Management
* User Interaction

Implemented using:

* Provider
* Riverpod
* Bloc

### Domain Layer

Contains:

* Entities
* Repository Contracts
* Use Cases

This layer contains business rules and has no dependency on Flutter.

### Data Layer

Contains:

* Models
* Data Sources
* Repository Implementations
* API Communication

---

## 📂 Project Structure

```text
lib/
│
├── core/
│
├── di/
│   ├── di_provider.dart
│   ├── di_riverpod.dart
│   └── di_bloc.dart
│
├── features/
│   └── post/
│
│       ├── data/
│       │   ├── datasource/
│       │   ├── models/
│       │   └── repository/
│       │
│       ├── domain/
│       │   ├── entities/
│       │   ├── repository/
│       │   └── usecases/
│       │
│       └── presentation/
│           ├── provider/
│           ├── riverpod/
│           ├── bloc/
│           └── pages/
│
└── main.dart
```

---

## 🔄 Data Flow

```text
UI
 │
 ▼
State Management
 │
 ▼
Use Case
 │
 ▼
Repository
 │
 ▼
Data Source
 │
 ▼
API
```

---

# State Management Implementations

## 1. Provider

Implemented using:

```dart
ChangeNotifierProvider<PostProvider>()
```

Features:

* Clean Architecture
* With GetIt Dependency Injection
* Without Dependency Injection
* ChangeNotifier Pattern

---

## 2. Riverpod

Implemented using:

```dart
StateNotifierProvider<PostNotifier, PostState>()
```

Features:

* Clean Architecture
* With GetIt Dependency Injection
* Without Dependency Injection
* StateNotifier Pattern

---

## 3. Bloc

Implemented using:

```dart
BlocProvider<PostBloc>()
```

Features:

* Clean Architecture
* With GetIt Dependency Injection
* Without Dependency Injection
* Event → State Architecture

---

# Dependency Injection Approaches

This repository demonstrates two approaches.

## Approach 1: With Dependency Injection (GetIt)

Production-ready implementation.

### Benefits

* Loose Coupling
* Easy Testing
* Better Maintainability
* Scalability
* Centralized Dependency Management

Example:

```dart
final sl = GetIt.instance;

BlocProvider<PostBloc>(
  create: (_) => sl.get<PostBloc>(),
)
```

Dependency Registration:

```dart
sl.registerLazySingleton<PostRepository>(
  () => PostRepositoryImpl(sl()),
);

sl.registerFactory(
  () => PostBloc(sl(), sl()),
);
```

---

## Approach 2: Without Dependency Injection

Dependencies are created manually.

### Benefits

* Beginner Friendly
* Easy to Understand
* No External Packages
* Helps Understand DI Internals

Example:

```dart
final postRemote = PostRemoteDataSourceImpl();

final postRepo = PostRepositoryImpl(postRemote);

final getPosts = GetPosts(postRepo);

final getPostDetail = GetPostDetail(postRepo);

BlocProvider<PostBloc>(
  create: (_) => PostBloc(
    getPosts,
    getPostDetail,
  ),
)
```

---

# Comparison

| Feature            | Provider | Riverpod  | Bloc        |
| ------------------ | -------- | --------- | ----------- |
| Learning Curve     | Easy     | Medium    | Medium-High |
| Boilerplate        | Low      | Medium    | High        |
| Scalability        | Medium   | High      | High        |
| Testability        | Good     | Excellent | Excellent   |
| Team Collaboration | Good     | Excellent | Excellent   |

---

# Running Different Implementations

You can run and study:

### Provider

* With DI
* Without DI

### Riverpod

* With DI
* Without DI

### Bloc

* With DI
* Without DI

Each implementation follows the same Clean Architecture principles, making comparison easier.

---

# Example Feature

This project includes a complete Post feature demonstrating:

* API Calls
* Remote Data Source
* Repository Pattern
* Use Cases
* State Management
* UI Rendering
* Error Handling
* Loading States

---

# Future Enhancements

* Unit Testing
* Widget Testing
* Integration Testing
* Local Database (Hive / Isar)
* Offline Support
* Pagination
* Authentication
* Caching
* CI/CD
* Feature Modules

---

# Getting Started

Clone the repository:

```bash
git clone https://github.com/kasim121/flutter-clean-architecture-masterclass.git
```

Navigate to project:

```bash
cd flutter-clean-architecture-masterclass
```

Install dependencies:

```bash
flutter pub get
```

Run the project:

```bash
flutter run
```

---

# Who Is This Repository For?

* Flutter Beginners
* Intermediate Developers
* Senior Developers
* Interview Preparation
* Software Engineers Learning Architecture
* Developers Migrating to Clean Architecture

---

# Author

**Mohd Kasim**

Flutter Developer

Focused on building scalable Flutter applications using Clean Architecture, SOLID Principles, and modern state management solutions.

---

## ⭐ Support

If you found this repository helpful, consider giving it a star and sharing it with other Flutter developers.
