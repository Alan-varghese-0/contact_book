# 📱 Flutter Contact Book App (Company Test)

This is a Flutter Contact Management application developed as part of a technical evaluation test.  
The project demonstrates real-world Flutter development practices including state management, local storage, UI/UX design, search, sorting, filtering, and lazy loading.

---

## ✅ Features Implemented

### 🔐 Authentication
- Login Screen implemented
- OTP verification flow implemented
- **Mock OTP used:** `1234`

> **Note on MSG91 Requirement**
>
> The test mentions using MSG91 (https://msg91.com/in) for mobile OTP authentication.  
> MSG91 requires an API key, approved SMS template, SMS credits, and most importantly a backend to securely manage credentials.  
> Since direct integration from a mobile app would expose private keys and the service is paid, this project uses a secure **mock OTP system** to demonstrate the complete authentication flow.  
>
> The application architecture is structured in a way that MSG91 can be easily integrated later through a backend service with minimal changes.

---

## 👤 User Management
- Add User (Name, Phone, Age, Profile Image)
- Add User displayed as popup dialog (Figma-style design)
- Local offline storage using Hive database
- User profile image selected from device gallery and stored

---

## 🔎 Data Operations
- Search users by name or phone number
- Sorting Options:
  - Older Users (Age ≥ 60)
  - Younger Users (Age < 60)
  - Reset Filters
- Filter selection popup dialog implemented
- Lazy loading implemented:
  - Loads user list in batches
  - Loads more users when user scrolls to the bottom

---

## 🎨 UI / UX
- Clean and modern UI based on Figma inspiration
- Center popup dialogs for Add User and Filters
- Rounded components and polished layout
- Smooth transitions and user-friendly interaction experience

---

## 🗂 Architecture & Tech Stack
- Flutter
- Hive Local Database
- BLoC State Management
- Repository Pattern
- Feature-based Clean Architecture

lib/
└── src/
└── features/
└── user/
├── data/
├── domain/
└── presentation/


This architecture is designed to be scalable, maintainable, and production-ready.

---

## 🚀 Run the Project

### 1️⃣ Install Dependencies

flutter pub get

### 2 Mock otp

"1234" 

