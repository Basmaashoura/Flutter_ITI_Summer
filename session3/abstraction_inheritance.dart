
void main() {
  List<Employee> employees = [
    fullTimeEmployee(1, 'Sama', 5000.0),
    partTimeEmployee(2, 'Basma', 20.0, 80),
    fullTimeEmployee(3, 'layla', 6500.0),
    partTimeEmployee(4, 'Dana', 27.0, 70),
  ];

  for (var employee in employees) {
    printEmployeeSalary(employee);
  }
}

abstract class Employee {
  late int id;
  late String name;
  
  Employee(this.id, this.name);
  
  double calculateSalary();
}

class fullTimeEmployee extends Employee {
  late double monthlySalary;
  
   fullTimeEmployee(int id, String name, this.monthlySalary) : super(id, name);

  @override
  double calculateSalary() {
    print('Calculating salary for FullTimeEmployee: $name');
    return monthlySalary;
  }
 }

class partTimeEmployee extends Employee { 
  late double  hourlyRate;
  late double hoursWorked;
  
  partTimeEmployee(int id, String name, this.hourlyRate, this.hoursWorked)
      : super(id, name);

  @override
  double calculateSalary() {
    print('Calculating salary for PartTimeEmployee: $name');
    return hourlyRate * hoursWorked;
  }
}

void printEmployeeSalary(Employee employee) {
  String employeeType = employee is fullTimeEmployee ? "Full-Time" : "Part-Time";
  double salary = employee.calculateSalary();
  print('Employee Type: $employeeType');
  print('Name: ${employee.name}');
  print('Salary: \$${salary}
');
}
