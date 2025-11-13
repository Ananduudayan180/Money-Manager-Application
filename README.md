# 💰 Money Manager Application

A simple and modern **Flutter** application to manage your personal income and expenses.  
Built using **Hive** for offline data storage and a clean, responsive UI design.

---

## 📸 Screenshots Preview

| Home Screen | Add Transaction | Category Screen |
|--------------|----------------|-----------------|
| ![Home](assets/screenshots/home.png) | ![Add](assets/screenshots/add_transaction.png) | ![Category](assets/screenshots/category.png) |

---

## 🚀 Features

- 💵 Add and delete transactions  
- 📂 Manage income and expense categories  
- 📊 View recent transactions sorted by date  
- 🗂 Data stored locally using **Hive**  
- 🎨 Gradient-based modern UI  
- ⚡ Fast performance — works fully offline  

---

## 🏗️ Tech Stack

| Technology | Description |
|-------------|-------------|
| **Flutter** | Cross-platform UI framework |
| **Dart** | Programming language |
| **Hive** | Local key–value database (used for storing category and transaction data) |
| **Phosphor Icons** | Modern icon set |
| **ValueListenableBuilder** | Reactive UI updates |
| **Material 3** | Enabled in `main.dart` (not fully implemented across all widgets) |

---

## 📂 Folder Structure

┃lib/
┣ db_functions/
┃ ┣ category_db/
┃ ┃ ┗ category_db.dart
┃ ┗ transactions_db/
┃   ┗ transaction_db.dart
┣ models/
┃ ┣ category_model/
┃ ┃ ┣ category_model.dart
┃ ┃ ┗ category_model.g.dart
┃ ┗ transactions_model/
┃   ┣ transaction_model.dart
┃   ┗ transaction_model.g.dart
┣ screens/
┃ ┣ home/
┃ ┣ transactions/
┃ ┗ categories/
┣ main.dart

---

## 🚀 How to Run the Project

1. **Clone the repository**
   ```bash
   git clone https://github.com/Ananduudayan180/money_manager_app.git
   
2. **Go to project folder**
```bash
cd Flutter Projects/Major Flutter Projects/Money-Manager-Application
```

3. **Get dependencies**
```bash
flutter pub get
```

4. **Run the app**
```bash
flutter run
```

🧠 Developer

👨‍💻 Author: Anandu Udayan
📧 Email: anandhuudayan180@gmail.com
📱 Built with ❤️ using Flutter

🪶 License

This project is licensed under the MIT License — free to use and modify.

⭐ If you like this project, give it a star on GitHub!
