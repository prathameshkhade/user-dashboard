# userdashboard

User Dashboard Application - Flutter App Assignment

# 📱 Flutter App Assignment - User Dashboard Application

---

### 📝 Overview

This Flutter app aims to demonstrate the creation of a user-friendly dashboard screen that lists users, provides search and sorting functionality, and allows navigation to report and user creation screens.

---

### 🎯 Requirements

### 1. **Dashboard Screen**

The main screen of the application with the following features:

- **User List**
    - Display a scrollable list of user cards or tiles.
    - Each card should contain basic user details (e.g., name, email, etc.).
- **Search Functionality**
    - A search bar at the top to filter users by name.
    - The filtering should be case-insensitive and responsive to input changes.
- **Sort Option**
    - A button/dropdown toggle to sort the user list **alphabetically** (A-Z / Z-A).
- **CTAs (Call to Action)**
    - **Report Button**: Navigates to the *Report Screen*, which displays a list of pre-defined reports.
    - **Create User Button**: Navigates to a *Create User Form* screen (can be simple for now, just for navigation demonstration).

### 2. **Report Screen**

- A separate screen accessible from the Dashboard via the Report CTA.
- Displays a list of reports (hardcoded or dummy data is fine).
- Each report can be displayed as a simple card or tile with title and summary.

### 3. **Create User Screen**

- A simple form screen to simulate user creation.
- Include input fields like:
    - Name
    - Email
    - Add some random fields
- A submit button (actual backend integration not required for this assignment).

---

### 🔧 Technical Constraints

- **No Bottom Navigation Bar** should be used in the app.
- Navigation between screens should be handled using **Navigator** or appropriate Flutter routing.

---

### ✨ Features Implemented

- **User Dashboard:**
    - Displays a list of users fetched from a dummy API.
    - Each user card shows their name, email, and company name.
    - Search functionality to filter users by name (case-insensitive).
    - Sorting functionality to arrange users alphabetically by name (A-Z and Z-A).
    - "View Reports" button navigates to the Report Screen.
    - "Create User" button navigates to the Create User Screen.
- **Report Screen:**
    - Displays a static list of pre-defined reports with titles and summaries.
    - Back navigation to the Dashboard Screen.
- **Create User Screen:**
    - A form with fields for:
        - Name
        - Email
        - Phone
        - Website
    - A "Submit" button (currently shows a snackbar message on tap, no actual data submission).
    - Back navigation to the Dashboard Screen.
- **Navigation:**
    - Implemented using Flutter's `Navigator` for screen transitions.
    - No bottom navigation bar is used, as per the requirement.
- **State Management:**
    - The application utilizes the **Bloc** pattern for robust state management, promoting a clear separation of concerns and testability.
- **Architecture & Data Fetching:**
    - Users are fetched from `jsonplaceholder.typicode.com/users`.
    - Error handling for API calls (displays an error message if fetching fails).
    - Loading indicator while fetching data.

---

### 🚀 Getting Started

The application adheres to **Clean Architecture** principles, ensuring maintainability, scalability, and testability. It follows Flutter's best practices for project structure and coding standards.

To get a local copy up and running follow these simple example steps.

#### Prerequisites

- Flutter SDK: [Install Flutter](https://flutter.dev/docs/get-started/install)
- An IDE like Android Studio or VS Code with Flutter plugins.

#### Installation

1. **Clone the repo**
