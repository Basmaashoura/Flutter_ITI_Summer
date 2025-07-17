// ignore_for_file: non_constant_identifier_names
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'services/search_service.dart';
import 'services/filter_service.dart';
import 'services/sort_service.dart';
import 'widgets/filter_sort_dialog.dart';
import 'widgets/search_widget.dart';

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
  final TextEditingController searchController = TextEditingController();

  // variables
  // Filter variables
  int? selectedFilterPriority; // null means show all priorities

  // Sort variables
  late String selectedSort;
  bool isAscending = true; // Sort order

  // Search variables
  String searchQuery = '';
  bool isSearching = false;

  @override
  void initState() {
    super.initState();
    selectedSort = 'priority'; // Initialize with default value
    _initHive();
  }

  @override
  void dispose() {
    searchController.dispose();
    task_name.dispose();
    task_description.dispose();
    super.dispose();
  }

  // Initialize Hive
  Future<void> _initHive() async {
    // already opened box
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
    return FilterService.getPriorityText(priority);
  }

  // Get filtered, searched, and sorted tasks using individual services
  List<Task> getFilteredTasks() {
    List<Task> filteredTasks = FilterService.filterTasks(
      tasks,
      selectedFilterPriority,
    );
    List<Task> searchedTasks = SearchService.searchTasks(
      filteredTasks,
      searchQuery,
    );
    List<Task> sortedTasks = SortService.sortTasks(
      searchedTasks,
      selectedSort,
      isAscending,
    );

    return sortedTasks;
  }

  // Show Filter & Sort dialog using FilterSortDialog widget
  void _showFilterSortDialog() {
    showModalBottomSheet(
      clipBehavior: Clip.antiAlias,
      isDismissible: false,
      isScrollControlled: true,
      context: context,
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => FilterSortDialog(
        selectedFilterPriority: selectedFilterPriority,
        selectedSort: selectedSort,
        isAscending: isAscending,
        onFilterChanged: (value) {
          setState(() {
            selectedFilterPriority = value;
          });
        },
        onSortChanged: (value) {
          setState(() {
            selectedSort = value;
          });
        },
        onSortOrderChanged: (value) {
          setState(() {
            isAscending = value;
          });
        },
      ),
    );
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
                    color: const Color(0xFF2072FA),
                  ),
                ),
                TextFormField(
                  controller: task_name,
                  decoration: InputDecoration(
                    hintText: 'Enter task name',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide(color: const Color(0xFF2072FA)),
                    ),
                  ),
                ),
                TextFormField(
                  controller: task_description,
                  decoration: InputDecoration(
                    hintText: 'Enter task description',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide(color: const Color(0xFF2072FA)),
                    ),
                  ),
                ),
                DropdownButtonFormField<int>(
                  decoration: InputDecoration(
                    hintText: 'Select priority',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide(color: const Color(0xFF2072FA)),
                    ),
                  ),
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
                          Icon(
                            Icons.priority_high_rounded,
                            color: Colors.orange,
                          ),
                          SizedBox(width: 8),
                          Text('Medium'),
                        ],
                      ),
                    ),
                    DropdownMenuItem<int>(
                      value: 3,
                      child: Row(
                        children: [
                          Icon(
                            Icons.priority_high_rounded,
                            color: Colors.green,
                          ),
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
                    ElevatedButton(
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
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF2072FA),
                        foregroundColor: Colors.white,
                        padding: EdgeInsets.symmetric(
                          horizontal: 24,
                          vertical: 12,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: Text(
                        'Add Task',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        task_name.clear();
                        task_description.clear();
                        Navigator.pop(context);
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.grey,
                        foregroundColor: Colors.white,
                        padding: EdgeInsets.symmetric(
                          horizontal: 24,
                          vertical: 12,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: Text(
                        'Cancel',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
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
                    color: const Color(0xFF2072FA),
                  ),
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide(color: const Color(0xFF2072FA)),
                    ),
                  ),
                ),
                TextField(
                  controller: editDesc,
                  style: TextStyle(fontSize: 18),
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide(color: const Color(0xFF2072FA)),
                    ),
                  ),
                ),
                DropdownButtonFormField<int>(
                  decoration: InputDecoration(
                    hintText: 'Change priority',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide(color: const Color(0xFF2072FA)),
                    ),
                  ),
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
                          Icon(
                            Icons.priority_high_rounded,
                            color: Colors.orange,
                          ),
                          SizedBox(width: 8),
                          Text('Medium'),
                        ],
                      ),
                    ),
                    DropdownMenuItem<int>(
                      value: 3,
                      child: Row(
                        children: [
                          Icon(
                            Icons.priority_high_rounded,
                            color: Colors.green,
                          ),
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
                    ElevatedButton(
                      onPressed: () {
                        task.name = editName.text;
                        task.description = editDesc.text;
                        task.priority = selectedPriority;
                        _updateTask(task); // Use Hive update method
                        Navigator.pop(context);
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF2072FA),
                        foregroundColor: Colors.white,
                        padding: EdgeInsets.symmetric(
                          horizontal: 24,
                          vertical: 12,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: Text(
                        'Save',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.grey,
                        foregroundColor: Colors.white,
                        padding: EdgeInsets.symmetric(
                          horizontal: 24,
                          vertical: 12,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: Text(
                        'Cancel',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
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
      appBar: SearchAppBar(
        isSearching: isSearching,
        searchController: searchController,
        onSearchChanged: (query) {
          setState(() {
            searchQuery = query;
          });
        },
        onSearchToggle: () {
          setState(() {
            if (isSearching) {
              // Close search
              isSearching = false;
              searchQuery = '';
              searchController.clear();
            } else {
              // Open search
              isSearching = true;
            }
          });
        },
        onFilterPressed: _showFilterSortDialog,
      ),
      body: Column(
        children: [
          // Search widget
          SearchWidget(
            searchController: searchController,
            searchQuery: searchQuery,
            isSearching: isSearching,
            onSearchChanged: (query) {
              setState(() {
                searchQuery = query;
              });
            },
            onSearchToggle: () {
              setState(() {
                if (isSearching) {
                  isSearching = false;
                  searchQuery = '';
                  searchController.clear();
                } else {
                  isSearching = true;
                }
              });
            },
          ),

          // Filter pills section (hidden during search)
          if (!isSearching)
            Container(
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Row(
                children: [
                  // All/Completed toggle
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.grey[200],
                        borderRadius: BorderRadius.circular(25),
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            child: GestureDetector(
                              onTap: () {
                                setState(() {
                                  selectedFilterPriority = null;
                                });
                              },
                              child: Container(
                                padding: EdgeInsets.symmetric(vertical: 8),
                                decoration: BoxDecoration(
                                  color: selectedFilterPriority == null
                                      ? Colors.white
                                      : Colors.transparent,
                                  borderRadius: BorderRadius.circular(25),
                                  boxShadow: selectedFilterPriority == null
                                      ? [
                                          BoxShadow(
                                            color: Colors.black.withOpacity(
                                              0.1,
                                            ),
                                            blurRadius: 4,
                                            offset: Offset(0, 2),
                                          ),
                                        ]
                                      : [],
                                ),
                                child: Center(
                                  child: Text(
                                    'All',
                                    style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      color: selectedFilterPriority == null
                                          ? const Color(0xFF2072FA)
                                          : Colors.grey[600],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Expanded(
                            child: GestureDetector(
                              onTap: () {
                                setState(() {
                                  // Show completed tasks filter
                                  selectedFilterPriority =
                                      -1; // Use -1 for completed
                                });
                              },
                              child: Container(
                                padding: EdgeInsets.symmetric(vertical: 8),
                                decoration: BoxDecoration(
                                  color: selectedFilterPriority == -1
                                      ? Colors.white
                                      : Colors.transparent,
                                  borderRadius: BorderRadius.circular(25),
                                  boxShadow: selectedFilterPriority == -1
                                      ? [
                                          BoxShadow(
                                            color: Colors.black.withOpacity(
                                              0.1,
                                            ),
                                            blurRadius: 4,
                                            offset: Offset(0, 2),
                                          ),
                                        ]
                                      : [],
                                ),
                                child: Center(
                                  child: Text(
                                    'Completed',
                                    style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      color: selectedFilterPriority == -1
                                          ? const Color(0xFF2072FA)
                                          : Colors.grey[600],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),

          // Tasks list
          Expanded(
            child: getFilteredTasks().isEmpty
                ? Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          searchQuery.isNotEmpty
                              ? Icons.search_off
                              : Icons.task_alt,
                          size: 80,
                          color: Colors.grey[400],
                        ),
                        SizedBox(height: 16),
                        Text(
                          searchQuery.isNotEmpty
                              ? "No tasks found for '$searchQuery'"
                              : tasks.isEmpty
                              ? "No tasks yet. Tap + to add one."
                              : "No tasks match your current filter.",
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.grey[600],
                          ),
                          textAlign: TextAlign.center,
                        ),
                        if (searchQuery.isNotEmpty)
                          Padding(
                            padding: EdgeInsets.only(top: 8),
                            child: TextButton(
                              onPressed: () {
                                setState(() {
                                  searchQuery = '';
                                  searchController.clear();
                                });
                              },
                              child: Text('Clear Search'),
                            ),
                          ),
                      ],
                    ),
                  )
                : ListView.builder(
                    padding: EdgeInsets.all(16),
                    itemCount: getFilteredTasks().length,
                    itemBuilder: (context, index) {
                      final task = getFilteredTasks()[index];
                      final originalIndex = tasks.indexOf(task);

                      return Container(
                        margin: EdgeInsets.only(bottom: 12),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(16),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.05),
                              blurRadius: 8,
                              offset: Offset(0, 2),
                            ),
                          ],
                        ),
                        child: ListTile(
                          contentPadding: EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 8,
                          ),
                          leading: GestureDetector(
                            onTap: () => _toggleTask(originalIndex),
                            child: Container(
                              width: 24,
                              height: 24,
                              decoration: BoxDecoration(
                                color: task.isDone
                                    ? const Color(0xFF2072FA)
                                    : Colors.transparent,
                                border: Border.all(
                                  color: task.isDone
                                      ? const Color(0xFF2072FA)
                                      : Colors.grey[400]!,
                                  width: 2,
                                ),
                                borderRadius: BorderRadius.circular(6),
                              ),
                              child: task.isDone
                                  ? Icon(
                                      Icons.check,
                                      color: Colors.white,
                                      size: 16,
                                    )
                                  : null,
                            ),
                          ),
                          title: SearchService.buildHighlightedText(
                            task.name,
                            searchQuery,
                            TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: task.isDone
                                  ? Colors.grey[500]
                                  : Colors.black,
                              decoration: task.isDone
                                  ? TextDecoration.lineThrough
                                  : null,
                            ),
                          ),
                          subtitle: task.description.isNotEmpty
                              ? SearchService.buildHighlightedText(
                                  task.description,
                                  searchQuery,
                                  TextStyle(
                                    fontSize: 14,
                                    color: Colors.grey[600],
                                  ),
                                )
                              : null,
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              // Priority badge
                              Container(
                                padding: EdgeInsets.symmetric(
                                  horizontal: 8,
                                  vertical: 4,
                                ),
                                decoration: BoxDecoration(
                                  color: task.priority == 1
                                      ? Colors.red.withOpacity(0.1)
                                      : task.priority == 2
                                      ? Colors.orange.withOpacity(0.1)
                                      : Colors.green.withOpacity(0.1),
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: Text(
                                  getPriorityText(task.priority),
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w600,
                                    color: task.priority == 1
                                        ? Colors.red
                                        : task.priority == 2
                                        ? Colors.orange
                                        : Colors.green,
                                  ),
                                ),
                              ),
                              SizedBox(width: 8),
                              // More options
                              PopupMenuButton<String>(
                                icon: Icon(
                                  Icons.more_vert,
                                  color: Colors.grey[600],
                                ),
                                onSelected: (value) {
                                  if (value == 'edit') {
                                    _taskDetailsDialog(task);
                                  } else if (value == 'delete') {
                                    _deleteTask(originalIndex);
                                  }
                                },
                                itemBuilder: (context) => [
                                  PopupMenuItem<String>(
                                    value: 'edit',
                                    child: Row(
                                      children: [
                                        Icon(Icons.edit, size: 16),
                                        SizedBox(width: 8),
                                        Text('Edit'),
                                      ],
                                    ),
                                  ),
                                  PopupMenuItem<String>(
                                    value: 'delete',
                                    child: Row(
                                      children: [
                                        Icon(
                                          Icons.delete,
                                          size: 16,
                                          color: Colors.red,
                                        ),
                                        SizedBox(width: 8),
                                        Text(
                                          'Delete',
                                          style: TextStyle(color: Colors.red),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          onTap: () => _taskDetailsDialog(task),
                        ),
                      );
                    },
                  ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _addTaskDialog,
        backgroundColor: const Color(0xFF2072FA),
        foregroundColor: Colors.white,
        child: Icon(Icons.add),
      ),
    );
  }
}
