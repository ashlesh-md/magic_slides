# Magic Slides – Architecture Overview

Magic Slides is built using a clean, scalable, and modular architecture suitable for long-term maintenance and rapid feature expansion. The project follows a **feature-first structure**, **clean layered architecture**, and a **custom event-based State Machine** for predictable UI behaviour.

---

## 🔧 Tech Stack & Dependencies

Key packages used in the project:

| Purpose                 | Packages |
|-------------------------|----------|
| Routing                 | `go_router` |
| Dependency Injection    | `get_it` |
| State Management        | Custom `statemachine` (event-driven) |
| Backend                 | `supabase_flutter` |
| Storage                 | `shared_preferences` |
| Networking              | `http` |
| File Viewing            | `flutter_pdfview` |
| UI/Animations           | `lottie` |
| Sharing                 | `share_plus` |

---

## ▶️ How to Run the Project

Follow the steps below to run the **Magic Slides** Flutter project locally.
[Demo Video](https://drive.google.com/file/d/1K0oji0wtNdQ9UMR9Ks-EGw5oK0zrzZVO/view?usp=sharing)
[Android APK](https://drive.google.com/file/d/1tqOC-ta-kyWQ-C2NEwUaoYIKGcMhOv4Z/view?usp=sharing)

### 1. Clone the Repository
```bash
git clone <repository-url>
cd magic_slides
```
### 2. Resolve dependencies
```bash
flutter pub get
```
### 3. Add accessId
```bash
Update accessId on `PresentationRepository` implementation
```
### 3. Select device, simulator or emulator & run 
```bash
flutter run app
```
---
# 🧱 Architecture

Magic Slides uses **Clean, Layered Architecture** inside a **Modular Folder Structure**.

## 📁 Folder Structure
```bash
lib/
├── core
│   ├── constants
│   │   ├── supabase_constants.dart
│   │   └── template_constants.dart
│   ├── data
│   │   └── services
│   │       └── file_service.dart
│   ├── exceptions
│   │   ├── api_exception.dart
│   │   ├── auth_failed_exception.dart
│   │   ├── custom_exception.dart
│   │   ├── file_exception.dart
│   │   └── network_exception.dart
│   ├── injection
│   │   └── injection.dart
│   ├── navigation
│   │   └── app_router.dart
│   ├── preferences
│   │   └── app_preferences.dart
│   └── theme
│       ├── app_theme.dart
│       ├── colors.dart
│       └── text_styles.dart
├── feature
│   ├── authentication
│   │   ├── authentication_injection.dart
│   │   ├── data
│   │   │   └── repository
│   │   │       └── authentication_repository_impl.dart
│   │   ├── domain
│   │   │   ├── model
│   │   │   └── repository
│   │   │       └── authentication_repository.dart
│   │   └── view
│   │       └── statemachine
│   │           ├── analytics
│   │           │   └── authentication_analytics_handler.dart
│   │           ├── authentication_state.dart
│   │           ├── authentication_view.dart
│   │           ├── event
│   │           │   ├── authentication_event.dart
│   │           │   └── authentication_event_handler.dart
│   │           └── side_effect
│   │               ├── authentication_async_side_effect_handler.dart
│   │               └── authentication_side_effect.dart
│   └── home
│       ├── data
│       │   └── repository
│       │       └── presentation_repository_impl.dart
│       ├── domain
│       │   ├── model
│       │   │   ├── generated_presentation_model.dart
│       │   │   ├── presentation_setting_model.dart
│       │   │   ├── presentation_target.dart
│       │   │   ├── template_type.dart
│       │   │   └── water_mark_position.dart
│       │   ├── repository
│       │   │   └── presentation_repository.dart
│       │   └── usecase
│       │       ├── generate_presentation_usecase.dart
│       │       └── logout_usecase.dart
│       ├── home_injection.dart
│       └── view
│           ├── home_view.dart
│           ├── statemachine
│           │   ├── analytics
│           │   │   └── home_analytics_handler.dart
│           │   ├── event
│           │   │   ├── home_event.dart
│           │   │   └── home_event_handler.dart
│           │   ├── home_state.dart
│           │   └── side_effect
│           │       ├── home_async_side_effect_handler.dart
│           │       └── home_side_effect.dart
│           └── widgets
│               ├── presentations_settings_bottom_sheet.dart
│               └── settings_summary_view.dart
├── main.dart
├── network
│   ├── api_service.dart
│   ├── mapper.dart
│   ├── outcome.dart
│   ├── requests
│   │   └── presentation_request.dart
│   └── response
│       └── presentation_response.dart
└── utils
    ├── app_utils.dart
    └── widgets
        ├── app_text_field.dart
        └── custom_alert_view.dart
```
## ✔️ Why This Structure?

- **Feature-first organization** – each module is fully self-contained  
- **Clear separation of concerns** – UI, domain, and data layers are independent  
- **Improved testability** – each layer has single responsibility  
- **Easy scalability** – add new modules without affecting existing ones  
- **Backend-agnostic** – replace HTTP/Supabase without UI changes  
---
## 🔁 Event-Based State Machine (Custom `statemachine`)

Magic Slides uses a **custom event-driven State Machine** instead of traditional state management tools which give more stability over architecture and makes more scalable.

## ✔️ Advantages

- Predictable and deterministic UI flow  
- Avoids invalid/incorrect states  
- Easy to track transitions and analytics  
- Perfect for screens with complex flows  
- Minimal boilerplate  
- Highly scalable as features grow  

---
# 🚀 Future Scalability

The architecture is designed for long-term flexibility.

### Add New Events Easily
Just define:
- event
- handlers
- new state

The State Machine handles the rest.

### Easy Logging & Analytics
State transitions make behaviour transparent.

### Replace Any Layer Easily
Examples:
- Swap HTTP with another networking library  
- Replace Supabase with Firebase  
- Change how templates load  

No major rewrite required.

## 📦 Summary  
✔️ **Scalable**  
✔️ **Modular**  
✔️ **Testable**  
✔️ **Clean layered architecture**  
✔️ **Event-driven State Machine**  
✔️ **Predictable UI**  
✔️ **Ready for future expansion**

Magic Slides is structured for long-term growth and professional production environments.


## 🧩 Future Work

- Store the history of generated presentations  
- Improve overall UI and UX  
- Handle background and app-killed states more gracefully  
- Separate the network layer from the domain layer to keep it fully independent  