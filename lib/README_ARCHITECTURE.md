# Task Manager - Separated Architecture

## File Structure

### Services (Business Logic)
- `lib/services/search_service.dart` - Handles search functionality
- `lib/services/filter_service.dart` - Handles filtering functionality  
- `lib/services/sort_service.dart` - Handles sorting functionality
- `lib/services/task_service.dart` - Main service that combines all operations

### Widgets (UI Components)
- `lib/widgets/search_widget.dart` - Search UI components
- `lib/widgets/filter_sort_dialog.dart` - Filter & Sort dialog UI

### Main File
- `lib/tasks_screen.dart` - Main screen using the separated services

## Services Overview

### SearchService
- `searchTasks()` - Filters tasks by search query
- `buildHighlightedText()` - Creates highlighted text for search results

### FilterService  
- `filterTasks()` - Filters tasks by priority and completion status
- `getPriorityText()` - Gets display text for priority levels
- `isFilterActive()` - Checks if any filter is active
- `getFilterDescription()` - Gets description of current filter

### SortService
- `sortTasks()` - Sorts tasks by different criteria
- `getSortDisplayName()` - Gets display name for sort types
- `getSortTypes()` - Gets all available sort types
- `getSortDescription()` - Gets description of current sort

### TaskService
- `getProcessedTasks()` - Main method combining filter, search, and sort
- `getTaskStats()` - Gets statistics about tasks
- `isValidTask()` - Validates task input

## Widgets Overview

### SearchWidget
- Displays search indicator banner
- Shows search results count
- Provides clear search functionality

### SearchAppBar
- Toggles between normal title and search field
- Handles search state management
- Shows/hides filter button during search

### FilterSortDialog
- Complete filter and sort UI
- Handles filter chips for priorities
- Radio buttons for sort options
- Toggle for sort direction

## Benefits

1. **Separation of Concerns** - Each service handles one specific responsibility
2. **Reusability** - Services can be used in other parts of the app
3. **Testability** - Easy to unit test individual services
4. **Maintainability** - Changes to one feature don't affect others
5. **Scalability** - Easy to add new filtering/sorting options

## Usage Example

```dart
// Get processed tasks
List<Task> processedTasks = TaskService.getProcessedTasks(
  tasks: allTasks,
  selectedFilterPriority: 1, // High priority
  searchQuery: 'meeting',
  sortType: 'priority',
  isAscending: true,
);

// Get task statistics
Map<String, int> stats = TaskService.getTaskStats(allTasks);
```

This architecture makes the code more organized, maintainable, and follows Flutter best practices for separation of concerns.
