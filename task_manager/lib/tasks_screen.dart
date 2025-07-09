// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:task_manager/task_details_screen.dart';

class tasks_screen extends StatefulWidget {
  const tasks_screen({super.key, required this.title});
  final String title;

  @override
  State<tasks_screen> createState() => _tasks_screen();
}

class Task {
  String name;
  String description;
  bool isDone;

  Task({required this.name, required this.description, this.isDone = false});
}

class _tasks_screen extends State<tasks_screen> {
  final List<Task> tasks = [];

  final TextEditingController task_name = TextEditingController();
  final TextEditingController task_description = TextEditingController();

  void _addTaskDialog() {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) => Dialog(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
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
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  MaterialButton(
                    onPressed: () {
                      if (task_name.text.isNotEmpty &&
                          task_description.text.isNotEmpty) {
                        setState(() {
                          tasks.add(
                            Task(
                              name: task_name.text,
                              description: task_description.text,
                            ),
                          );
                          task_name.clear();
                          task_description.clear();
                        });
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
    );
  }

  void _taskDetailsDialog(Task task) {
    final TextEditingController editName = TextEditingController(text: task.name);
    final TextEditingController editDesc = TextEditingController(text: task.description);

    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) => Dialog(
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
                      setState(() {
                        task.name = editName.text;
                        task.description = editDesc.text;
                      });
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
    );
  }

  void _toggleTask(int index) {
    setState(() {
      tasks[index].isDone = !tasks[index].isDone;
    });
  }

  void _deleteTask(int index) {
    setState(() {
      tasks.removeAt(index);
    });
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
      ),
      body: tasks.isEmpty
          ? Center(child: Text("No tasks yet. Tap + to add one."))
          : ListView.builder(
              itemCount: tasks.length,
              itemBuilder: (context, index) {
                final task = tasks[index];
                return ListTile(
                  title: Text(
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
                  subtitle: Text(
                    task.description,
                    style: TextStyle(fontSize: 18),
                  ),
                  leading: IconButton(
                    icon: Icon(
                      task.isDone
                          ? Icons.check_box
                          : Icons.check_box_outline_blank,
                      color: Colors.blueGrey,
                    ),
                    onPressed: () => _toggleTask(index),
                  ),
                  trailing: IconButton(
                    icon: Icon(Icons.delete, color: Colors.black),
                    onPressed: () => _deleteTask(index),
                  ),
                  onTap: () {
                    _taskDetailsDialog(task);
                  },
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: _addTaskDialog,
        child: Icon(Icons.add),
      ),
    );
  }
}
