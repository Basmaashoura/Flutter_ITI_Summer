# task_manager

# 📱 Task Manager App - Flutter ITI Summer

A modern, feature-rich task management application built with Flutter and Hive database.

## ✨ Features

- **📝 Task Management**: Create, edit, delete, and mark tasks as complete
- **🎯 Priority System**: High, Medium, Low priority with color-coded icons
- **🔍 Smart Filtering**: Filter tasks by priority levels
- **💾 Persistent Storage**: Tasks saved locally using Hive database
- **🎨 Modern UI**: Clean, intuitive interface with smooth animations

## 🛠️ Technologies Used

- **Flutter**: Cross-platform mobile development
- **Hive**: Fast, lightweight local database
- **Material Design**: Modern UI components
- **Dart**: Programming language

## 📱 Screenshots

### Home Screen
- Navigation to Tasks and Notes sections

### Tasks Screen
- Add new tasks with priority selection
- View all tasks with priority indicators
- Filter tasks by priority level
- Edit task details inline
- Delete tasks with confirmation

## 🚀 Getting Started

### Prerequisites
- Flutter SDK installed
- Dart SDK installed
- Android Studio or VS Code with Flutter extension

### Installation

1. Clone the repository:
```bash
git clone https://github.com/Basmaashoura/Flutter_ITI_Summer.git
```

2. Navigate to the project directory:
```bash
cd Flutter_ITI_Summer
```

3. Install dependencies:
```bash
flutter pub get
```

4. Generate Hive type adapters:
```bash
flutter pub run build_runner build
```

5. Run the app:
```bash
flutter run
```

## 📁 Project Structure

```
lib/
├── main.dart              # App entry point & Hive initialization
├── home_screen.dart       # Home screen with navigation
├── tasks_screen.dart      # Task management screen
├── notes_screen.dart      # Notes screen (placeholder)
└── tasks_screen.g.dart    # Generated Hive type adapters
```

## 🎯 Key Features Explained

### Priority System
- 🔴 **High Priority**: Red icon - Urgent tasks
- 🟠 **Medium Priority**: Orange icon - Normal tasks  
- 🟢 **Low Priority**: Green icon - Optional tasks

### Filtering
- Filter by priority level using the filter icon
- Clear filters to show all tasks
- Visual indicator showing current filter

### Data Persistence
- Uses Hive for local storage
- Tasks persist between app sessions
- Fast read/write operations

## 👨‍💻 Development

This project was developed as part of the Flutter ITI Summer program, demonstrating:
- State management with StatefulWidget
- Local database integration with Hive
- UI/UX design with Material Design
- Code organization and best practices

## 🔮 Future Enhancements

- [ ] Task categories
- [ ] Due dates and reminders
- [ ] Search functionality
- [ ] Dark mode support
- [ ] Export/Import tasks
- [ ] Cloud synchronization

## 📞 Contact

**Developer**: Basma Ashoura  
**GitHub**: [Basmaashoura](https://github.com/Basmaashoura)  
**Repository**: [Flutter_ITI_Summer](https://github.com/Basmaashoura/Flutter_ITI_Summer)

---

*Built with ❤️ using Flutter*
