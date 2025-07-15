// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
part 'tasks_screen.g.dart';

class tasks_screen extends StatefulWidget {
  const tasks_screen({super.key, required this.title});
  final String title;

  @override
  State<tasks_screen> createState() => _tasks_screen();
}

@HiveType(typeId: 0)
class Task extends HiveObject {
  @HiveField(0)
  String name;
  @HiveField(1)
  String description;
  @HiveField(2)
  bool isDone;
  @HiveField(3)
  int priority; // 1 = High, 2 = Medium, 3 = Low
  
  Task({
    required this.name,
    required this.description,
    this.isDone = false,
    this.priority = 2, // Default to Medium priority
  });
}

class _tasks_screen extends State<tasks_screen> {
  late Box<Task> taskBox; // Hive box to store tasks
  List<Task> tasks = []; // Local list for UI

  final TextEditingController task_name = TextEditingController();
  final TextEditingController task_description = TextEditingController();
  
  // Filter variables
  int? selectedFilterPriority; // null means show all priorities

  @override
  void initState() {
    super.initState();
    _initHive();
  }

  // Initialize Hive and load tasks
  Future<void> _initHive() async {
    // Get the already opened box
    taskBox = Hive.box<Task>('tasks');
    
    // Load tasks from Hive
    setState(() {
      tasks = taskBox.values.toList();
    });
  }

  // Save task to Hive
  Future<void> _saveTask(Task task) async {
    await taskBox.add(task);
    setState(() {
      tasks = taskBox.values.toList();
    });
  }

  // Update task in Hive
  Future<void> _updateTask(Task task) async {
    await task.save(); // HiveObject method
    setState(() {
      tasks = taskBox.values.toList();
    });
  }

  // Delete task from Hive
  Future<void> _deleteTask(int index) async {
    final task = tasks[index];
    await task.delete(); // HiveObject method
    setState(() {
      tasks = taskBox.values.toList();
    });
  }
  
  // Helper method to get priority icon and color
  Widget getPriorityIcon(int priority) {
    switch (priority) {
      case 1:
        return Icon(Icons.priority_high_rounded, color: Colors.red);
      case 2:
        return Icon(Icons.priority_high_rounded, color: Colors.orange);
      case 3:
        return Icon(Icons.priority_high_rounded, color: Colors.green);
      default:
        return Icon(Icons.priority_high_rounded, color: Colors.grey);
    }
  }
  
  String getPriorityText(int priority) {
    switch (priority) {
      case 1:
        return 'High';
      case 2:
        return 'Medium';
      case 3:
        return 'Low';
      default:
        return 'Medium';
    }
  }

  // Filter tasks by priority
  List<Task> getFilteredTasks() {
    if (selectedFilterPriority == null) {
      return tasks; // Show all tasks
    }
    return tasks.where((task) => task.priority == selectedFilterPriority).toList();
  }

  void _addTaskDialog() {
    int selectedPriority = 2; // Default to Medium
    
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) => StatefulBuilder(
        builder: (context, setState) => Dialog(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              spacing: 20,
              children: [
                Text(
                  'Add New Task',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.blueGrey,
                  ),
                ),
                TextFormField(
                  controller: task_name,
                  decoration: InputDecoration(hintText: 'Enter task name'),
                ),
                TextFormField(
                  controller: task_description,
                  decoration: InputDecoration(hintText: 'Enter task description'),
                ),
                DropdownButtonFormField<int>(
                  decoration: InputDecoration(hintText: 'Select priority'),
                  value: selectedPriority,
                  items: [
                    DropdownMenuItem<int>(
                      value: 1,
                      child: Row(
                        children: [
                          Icon(Icons.priority_high_rounded, color: Colors.red),
                          SizedBox(width: 8),
                          Text('High'),
                        ],
                      ),
                    ),
                    DropdownMenuItem<int>(
                      value: 2,
                      child: Row(
                        children: [
                          Icon(Icons.priority_high_rounded, color: Colors.orange),
                          SizedBox(width: 8),
                          Text('Medium'),
                        ],
                      ),
                    ),
                    DropdownMenuItem<int>(
                      value: 3,
                      child: Row(
                        children: [
                          Icon(Icons.priority_high_rounded, color: Colors.green),
                          SizedBox(width: 8),
                          Text('Low'),
                        ],
                      ),
                    ),
                  ],
                  onChanged: (value) {
                    if (value != null) {
                      setState(() {
                        selectedPriority = value;
                      });
                    }
                  },
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    MaterialButton(
                      onPressed: () {
                        if (task_name.text.isNotEmpty &&
                            task_description.text.isNotEmpty) {
                          final newTask = Task(
                            name: task_name.text,
                            description: task_description.text,
                            priority: selectedPriority,
                            isDone: false,
                          );
                          _saveTask(newTask); // Use Hive save method
                          task_name.clear();
                          task_description.clear();
                          Navigator.pop(context);
                        }
                      },
                      color: Colors.blueGrey,
                      child: Text(
                        'Add Task',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                    MaterialButton(
                      onPressed: () {
                        task_name.clear();
                        task_description.clear();
                        Navigator.pop(context);
                      },
                      color: Colors.blueGrey,
                      child: Text(
                        'Cancel',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _taskDetailsDialog(Task task) {
    final TextEditingController editName = TextEditingController(
      text: task.name,
    );
    final TextEditingController editDesc = TextEditingController(
      text: task.description,
    );
    int selectedPriority = task.priority;

    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) => StatefulBuilder(
        builder: (context, setState) => Dialog(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: editName,
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.blueGrey,
                  ),
                ),
                TextField(controller: editDesc, style: TextStyle(fontSize: 18)),
                DropdownButtonFormField<int>(
                  decoration: InputDecoration(hintText: 'Change priority'),
                  value: selectedPriority,
                  items: [
                    DropdownMenuItem<int>(
                      value: 1,
                      child: Row(
                        children: [
                          Icon(Icons.priority_high_rounded, color: Colors.red),
                          SizedBox(width: 8),
                          Text('High'),
                        ],
                      ),
                    ),
                    DropdownMenuItem<int>(
                      value: 2,
                      child: Row(
                        children: [
                          Icon(Icons.priority_high_rounded, color: Colors.orange),
                          SizedBox(width: 8),
                          Text('Medium'),
                        ],
                      ),
                    ),
                    DropdownMenuItem<int>(
                      value: 3,
                      child: Row(
                        children: [
                          Icon(Icons.priority_high_rounded, color: Colors.green),
                          SizedBox(width: 8),
                          Text('Low'),
                        ],
                      ),
                    ),
                  ],
                  onChanged: (value) {
                    if (value != null) {
                      setState(() {
                        selectedPriority = value;
                      });
                    }
                  },
                ),
                SizedBox(height: 10),
                Text(
                  task.isDone ? "Status: Done" : "Status: Not Done",
                  style: TextStyle(
                    fontSize: 18,
                    color: task.isDone ? Colors.green : Colors.red,
                  ),
                ),
                SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    MaterialButton(
                      onPressed: () {
                        task.name = editName.text;
                        task.description = editDesc.text;
                        task.priority = selectedPriority;
                        _updateTask(task); // Use Hive update method
                        Navigator.pop(context);
                      },
                      color: Colors.blueGrey,
                      child: Text('Save', style: TextStyle(color: Colors.white)),
                    ),
                    MaterialButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      color: Colors.blueGrey,
                      child: Text(
                        'Cancel',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _toggleTask(int index) {
    tasks[index].isDone = !tasks[index].isDone;
    _updateTask(tasks[index]); // Use Hive update method
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Tasks Page",
          style: TextStyle(
            fontSize: 40,
            fontWeight: FontWeight.bold,
            color: Colors.blueGrey,
          ),
        ),
        centerTitle: true,
        actions: [
          PopupMenuButton<int?>(
            icon: Icon(Icons.filter_list),
            onSelected: (value) {
              setState(() {
                selectedFilterPriority = value;
              });
            },
            itemBuilder: (context) => [
              PopupMenuItem<int?>(
                value: null,
                child: Text('All Tasks'),
              ),
              PopupMenuItem<int?>(
                value: 1,
                child: Row(
                  children: [
                    Icon(Icons.priority_high_rounded, color: Colors.red),
                    SizedBox(width: 8),
                    Text('High Priority'),
                  ],
                ),
              ),
              PopupMenuItem<int?>(
                value: 2,
                child: Row(
                  children: [
                    Icon(Icons.priority_high_rounded, color: Colors.orange),
                    SizedBox(width: 8),
                    Text('Medium Priority'),
                  ],
                ),
              ),
              PopupMenuItem<int?>(
                value: 3,
                child: Row(
                  children: [
                    Icon(Icons.priority_high_rounded, color: Colors.green),
                    SizedBox(width: 8),
                    Text('Low Priority'),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
      body: tasks.isEmpty
          ? Center(child: Text("No tasks yet. Tap + to add one."))
          : Column(
              children: [
                // Filter display
                if (selectedFilterPriority != null)
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.all(8),
                    color: Colors.grey[200],
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('Showing: '),
                        getPriorityIcon(selectedFilterPriority!),
                        SizedBox(width: 4),
                        Text(getPriorityText(selectedFilterPriority!)),
                        SizedBox(width: 8),
                        TextButton(
                          onPressed: () {
                            setState(() {
                              selectedFilterPriority = null;
                            });
                          },
                          child: Text('Clear Filter'),
                        ),
                      ],
                    ),
                  ),
                // Tasks list
                Expanded(
                  child: ListView.builder(
                    itemCount: getFilteredTasks().length,
                    itemBuilder: (context, index) {
                      final task = getFilteredTasks()[index];
                      final originalIndex = tasks.indexOf(task); // Get original index for actions
                      return ListTile(
                        title: Row(
                          children: [
                            Expanded(
                              child: Text(
                                task.name,
                                style: TextStyle(
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.blueGrey,
                                  decoration: task.isDone
                                      ? TextDecoration.lineThrough
                                      : null,
                                ),
                              ),
                            ),
                          ],
                        ),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              task.description,
                              style: TextStyle(fontSize: 18),
                            ),
                          ],
                        ),
                        leading: IconButton(
                          icon: Icon(
                            task.isDone
                                ? Icons.check_box
                                : Icons.check_box_outline_blank,
                            color: Colors.blueGrey,
                          ),
                          onPressed: () => _toggleTask(originalIndex),
                        ),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            getPriorityIcon(task.priority),
                            IconButton(
                              icon: Icon(Icons.delete, color: Colors.black),
                              onPressed: () => _deleteTask(originalIndex),
                            ),
                          ],
                        ),
                        onTap: () {
                          _taskDetailsDialog(task);
                        },
                      );
                    },
                  ),
                ),
              ],
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: _addTaskDialog,
        child: Icon(Icons.add),
      ),
    );
  }
}
