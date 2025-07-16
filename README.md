# 🚀 Doitly - Flutter Task Manager

A modern, feature-rich task management application built with Flutter and Hive database.

## 📱 About Doitly

Doitly is your personal task management companion that helps you stay organized and productive. Built with Flutter for cross-platform compatibility and Hive for fast local storage.

### ✨ Key Features

- **📝 Task Management**: Create, edit, delete, and mark tasks as complete
- **🎯 Priority System**: High, Medium, Low priority with color-coded icons
- **🔍 Smart Filtering**: Filter tasks by priority levels  
- **💾 Persistent Storage**: Tasks saved locally using Hive database
- **🎨 Modern UI**: Clean, intuitive interface with smooth animations
- **📱 Cross-platform**: Works on Android, iOS, and Web

### 🛠️ Technologies Used

- **Flutter**: Cross-platform mobile development
- **Hive**: Fast, lightweight local database
- **Material Design 3**: Modern UI components
- **Dart**: Programming language

## 🚀 Getting Started

### Prerequisites
- Flutter SDK (latest stable version)
- Dart SDK  
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
dart run build_runner build
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
├── notes_screen.dart      # Notes screen
└── tasks_screen.g.dart    # Generated Hive type adapters
```

## 🎯 Features in Detail

### Priority Management
- 🔴 **High Priority**: Red icon - Urgent tasks that need immediate attention
- 🟠 **Medium Priority**: Orange icon - Important tasks with moderate urgency
- 🟢 **Low Priority**: Green icon - Optional tasks that can be done later

### Task Operations
- **Create**: Add new tasks with title, description, and priority
- **Edit**: Modify existing tasks inline
- **Complete**: Mark tasks as done with visual feedback
- **Delete**: Remove tasks with confirmation
- **Filter**: View tasks by priority level

### Data Persistence
- **Local Storage**: Uses Hive for fast, reliable local database
- **Offline First**: All data stored locally, no internet required
- **Performance**: Optimized for quick read/write operations

## 🎨 UI/UX Design

- **Material Design 3**: Modern, consistent design language
- **Responsive Layout**: Adapts to different screen sizes
- **Smooth Animations**: Enhances user experience
- **Intuitive Navigation**: Easy-to-use interface

## 👨‍💻 Development

This project was developed as part of the Flutter ITI Summer program, demonstrating:
- Advanced Flutter development techniques
- State management with StatefulWidget
- Local database integration
- Modern UI/UX principles
- Code organization and best practices

## 🔮 Future Enhancements

- [ ] Task categories and labels
- [ ] Due dates and reminders
- [ ] Search functionality
- [ ] Dark mode support
- [ ] Export/Import tasks
- [ ] Cloud synchronization
- [ ] Task sharing
- [ ] Analytics and insights

## 📸 Screenshots

*Screenshots will be added here to showcase the app's interface*

## 🤝 Contributing

This is a learning project, but suggestions and improvements are welcome!

## 📞 Contact

**Developer**: Basma Ashoura  
**GitHub**: [Basmaashoura](https://github.com/Basmaashoura)  
**Repository**: [Flutter_ITI_Summer](https://github.com/Basmaashoura/Flutter_ITI_Summer)

---

*Built with ❤️ using Flutter during ITI Summer Training*
