# 🎬 BenVista

BenVista is a simple personal movie tracking app built with Flutter and SQLite.  
It helps you store movies you have watched, are watching, plan to watch or dropped(I have so many) — completely offline.

---

## ✨ Features

- Add movies with title, score, and status  
- Edit movie details  
- Delete movies (swipe to delete)  
- Search movies locally (offline)  
- Data stored using SQLite  
- Simple clean structure using Repository pattern  

---

## 🧠 Tech Stack

- Flutter  
- Dart  
- SQLite (sqflite package)  
- Material Design  

---

## 🏗️ Architecture

```
UI → Repository → SQLite Database
```

---

## 📂 Project Structure

```
lib/
├── core/
│   └── database/
├── features/
│   └── movies/
│       ├── data/
│       ├── screens/
│       └── widgets/
├── models/
└── main.dart
```

---

## 🚀 Getting Started

### Clone the repository
```bash
git clone https://github.com/your-username/BenVista.git
```

### Install dependencies
```bash
flutter pub get
```

### Run the app
```bash
flutter run
```

---

## 📝 Notes

- Works fully offline
- No backend required
- Uses local SQLite database only

---
