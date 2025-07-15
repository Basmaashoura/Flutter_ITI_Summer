import 'school.dart';
void main() {
  School school = School();

  school.addStudent(1, 'Aya', {'Math101': 90, 'Sci301': 85});
  school.addStudent(2, 'Tia', {'Eng201': 80, 'Sci301': 75});
  print("-------------------");

  school.addCourse('Math101', 'Math Basics', []);
  school.addCourse('Sci301', 'Science', []);
  print("-------------------");

  school.assignGrade(1, 'Math101', 95);
  school.assignGrade(2, 'Sci301', 88);
  print("-------------------");

  school.enrollStudentInCourse('Math101');
  school.enrollStudentInCourse('CS201'); // does not exist
  school.enrollStudentInCourse('Sci301');
  print("-------------------");

  school.printStudentReport(1);
  print("-------------------");
  school.printStudentReport(2);
  print("-------------------");

  school.printAllStudents();
  print("-------------------");
  school.printAllCourses();
  print("-------------------");
}