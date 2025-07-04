import 'dart:io';

// List<int> ids = [];

Map<int, Map<String, dynamic>> studentDatabase = {};

void students(int id, String? name, age,  String? city, double grade) {
    studentDatabase.addAll({
      studentDatabase.length + 1 : {
      'name': name,
      'age': age,
      'city': city,
      'grade': grade}
    });
}

void addStudent() {
    print("Enter student info:");
    print("Name:");
    String? name = stdin.readLineSync();
    if (name == null || name.isEmpty) {
      print('Invalid name!');
      return;
    }
    
    print("Age:");
    int? age = int.tryParse(stdin.readLineSync() ?? '');
    if (age == null) {
      print('Invalid age!');
      return;
    }
    
    print("Grade:");
    double? grade = double.tryParse(stdin.readLineSync() ?? '');
    if (grade == null) {
      print('Invalid grade!');
      return;
    }
    
    print("City:");
    String? city = stdin.readLineSync();
    if (city == null || city.isEmpty) {
      print('Invalid city!');
      return;
    }
    
    int id = studentDatabase.length + 1;
    students(id, name, age, city, grade);
    print('Student added successfully!');
}

void listAllStudents() {
  if (studentDatabase.isEmpty) {
    print('No students in the database.');
    return;
  }
  
  print('\nAll Students:');
  studentDatabase.forEach((key, value) => 
    print('ID: $key - Name: ${value['name']}, Age: ${value['age']}, City: ${value['city']}, Grade: ${value['grade']}')
  );
}

void findByCity() {
  print("Enter city name:");
  String? city = stdin.readLineSync();
  if (city == null || city.isEmpty) {
    print('Invalid city name!');
    return;
  }
  
  var studentsInCity = studentDatabase.entries.where((entry) => 
    entry.value['city'] == city
  ).toList();
  
  if (studentsInCity.isEmpty) {
    print('No students found in $city');
  } else {
    print('Students in $city:');
    studentsInCity.forEach((entry) {
      var student = entry.value;
      print('• ID: ${entry.key}, Name: ${student['name']}, Age: ${student['age']}, Grade: ${student['grade']}');
    });
  }
}

void calcAverageGrade() {
  if (studentDatabase.isEmpty) {
    print('No students in the database.');
    return;
  }
  
  double sum = 0;
  studentDatabase.values.forEach((student) => sum += student['grade']);
  double average = sum / studentDatabase.length;
  print("Average grade: ${average.toStringAsFixed(2)}");
}


void filterByGrade() {
  print("Enter minimum grade:");
  double? x = double.tryParse(stdin.readLineSync() ?? '');
  if (x == null) {
    print('Invalid grade!');
    return;
  }
  
  var qualifiedStudents = studentDatabase.entries.where((entry) => 
    entry.value['grade'] >= x).toList();

  if (qualifiedStudents.isEmpty) {
    print('No students found with grade ≥ $x');
  } else {
    print('${qualifiedStudents.length} student(s) with grade ≥ $x:');
    qualifiedStudents.forEach((entry) {
      var student = entry.value;
      print('• ID: ${entry.key}, Name: ${student['name']} from ${student['city']} - Grade: ${student['grade']}');
    });
  }
}

void removeStudent() {
  if (studentDatabase.isEmpty) {
    print('No students to remove.');
    return;
  }
  
  listAllStudents();
  print("Enter student ID to remove:");
  int? stdId = int.tryParse(stdin.readLineSync() ?? '');
  if (stdId == null) {
    print('Invalid student ID!');
    return;
  }
  
  if (studentDatabase.containsKey(stdId)) {
    var removedStudent = studentDatabase.remove(stdId);
    print('Student ${removedStudent!['name']} removed successfully!');
  } else {
    print('Student with ID $stdId not found!');
  }
}

void programExit() {
  print('Goodbye!');
  exit(0);
}

  void executeUserOption (int serviceNum) {
    Map<int, Function> menuOptions = {
      1: () => addStudent(),
      2: () => listAllStudents(),
      3: () => findByCity(),
      4: () => calcAverageGrade(),
      5: () => filterByGrade(),
      6: () => removeStudent(),
      7: () => programExit()
    };
    
    menuOptions[serviceNum]?.call();
}
void main() {
  print("=== Student Management System ===\n");
  
  Map<int, String> services = {
    1: "Add Student", 
    2: "List All Students",
    3: "Find Students by City", 
    4: "Calculate Average Grade",
    5: "Display Students With Grade > X",
    6: "Remove Student",
    7: "Exit"
  };
  
  while (true) {
    print("\n--- Menu ---");
    services.forEach((key, value) => print('$key: $value'));
    print("Choose Service Number:");
    
    int? serviceNum = int.parse(stdin.readLineSync() ?? '');
    if (serviceNum == null || serviceNum < 1 || serviceNum > services.length) {
      print('Invalid service number! Please choose a valid option (1-7).');
      continue;
    }
    
    executeUserOption(serviceNum);
  }
}