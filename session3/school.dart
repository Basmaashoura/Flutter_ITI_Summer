import 'student.dart';
import 'course.dart';

class School {
  List<Student> students = [];
  List<Course> courses = [];
  Map<String?, int> courseStudentsNumber = {};

  void addStudent(int? studentId, String? name, Map<String, double>? grades) {
    Student newStudent = Student();
    newStudent.studentId = studentId;
    newStudent.name = name;
    newStudent.grades = grades ?? {};
    students.add(newStudent);
    print('Student added: ${newStudent.name} with ID: ${newStudent.studentId}');

    // Update course student count
    grades?.forEach((courseCode, grade) {
      if (courseStudentsNumber.containsKey(courseCode)) {
        courseStudentsNumber[courseCode] = courseStudentsNumber[courseCode]! + 1;
      } else {
        courseStudentsNumber[courseCode] = 1;
      }
    });
  }

  void addCourse(String? courseCode, String? title, List<Student>? enrolledStudents) {
    Course newCourse = Course();
    newCourse.courseCode = courseCode;
    newCourse.title = title;
    newCourse.enrolledStudents = enrolledStudents ?? [];
    courses.add(newCourse);
    print('Course added: ${newCourse.title} with code: ${newCourse.courseCode}');
}

  void assignGrade(int? studentId, String? courseCode, double? grade) {
    Student? newStudent = students.firstWhere((student) => student.studentId == studentId);
    Course? newCourse = courses.firstWhere((course) => course.courseCode == courseCode);

    if (newStudent == null) {
      print('Student with ID: $studentId not found.');
      return;
    }
  }

  void enrollStudentInCourse(String? courseCode) {
    if(courseStudentsNumber.containsKey(courseCode)) {
      print('Course with code: $courseCode already has ${courseStudentsNumber[courseCode]} students enrolled.');
      return;
    }
  }

  void printAllStudents() {
    if (students.isEmpty) {
      print('No students found.');
      return;
    }
    for (var student in students) {
      print('Student ID: ${student.studentId}, Name: ${student.name}');
    }
  }

  void printAllCourses() {
    if (courses.isEmpty) {
      print('No students found.');
      return;
    }
    for (var course in courses) {
      print('Course Code: ${course.courseCode}, Title: ${course.title}');
    }
  }

  void printStudentReport(int? studentId) {
    Student student = students.firstWhere((student) => student.studentId == studentId);
    if (student == false) {
      print('Student with ID: $studentId not found.');
      return;
    }
    print('Student Report for: ${student.name}');
    student.grades.forEach((courseCode, grade) {
      print('Course: $courseCode, Grade: $grade');
    });

  }
}