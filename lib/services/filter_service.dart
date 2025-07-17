import '../tasks_screen.dart';

class FilterService {
  // Filter tasks based on priority and completion status
  static List<Task> filterTasks(List<Task> tasks, int? selectedFilterPriority) {
    if (selectedFilterPriority == -1) {
      // Show completed tasks
      return tasks.where((task) => task.isDone).toList();
    } else if (selectedFilterPriority != null) {
      // Show tasks with specific priority
      return tasks
          .where(
            (task) => task.priority == selectedFilterPriority && !task.isDone,
          )
          .toList();
    } else {
      // Show all incomplete tasks
      return tasks.where((task) => !task.isDone).toList();
    }
  }

  // Get priority text for display
  static String getPriorityText(int priority) {
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

  // Check if filter is active
  static bool isFilterActive(int? selectedFilterPriority) {
    return selectedFilterPriority != null;
  }

  // Get filter description for display
  static String getFilterDescription(int? selectedFilterPriority) {
    if (selectedFilterPriority == null) return 'All tasks';
    if (selectedFilterPriority == -1) return 'Completed tasks';
    return '${getPriorityText(selectedFilterPriority)} priority tasks';
  }
}
