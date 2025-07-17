import '../tasks_screen.dart';

enum SortType { priority, name, status }

class SortService {
  // Sort tasks based on selected criteria
  static List<Task> sortTasks(List<Task> tasks, String sortType, bool isAscending) {
    List<Task> sortedTasks = List.from(tasks);

    switch (sortType) {
      case 'priority':
        sortedTasks.sort(
          (a, b) => isAscending
              ? a.priority.compareTo(b.priority)
              : b.priority.compareTo(a.priority),
        );
        break;
      case 'name':
        sortedTasks.sort(
          (a, b) => isAscending
              ? a.name.toLowerCase().compareTo(b.name.toLowerCase())
              : b.name.toLowerCase().compareTo(a.name.toLowerCase()),
        );
        break;
      case 'status':
        sortedTasks.sort(
          (a, b) => isAscending
              ? a.isDone.toString().compareTo(b.isDone.toString())
              : b.isDone.toString().compareTo(a.isDone.toString()),
        );
        break;
    }

    return sortedTasks;
  }

  // Get display name for sort type
  static String getSortDisplayName(String sortType) {
    switch (sortType) {
      case 'priority':
        return 'Priority';
      case 'name':
        return 'Title';
      case 'status':
        return 'Status';
      default:
        return 'Priority';
    }
  }

  // Get all available sort types
  static List<String> getSortTypes() {
    return ['priority', 'name', 'status'];
  }

  // Get sort description for display
  static String getSortDescription(String sortType, bool isAscending) {
    String direction = isAscending ? 'ascending' : 'descending';
    String type = getSortDisplayName(sortType);
    return '$type ($direction)';
  }
}
