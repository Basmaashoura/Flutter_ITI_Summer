import 'package:flutter/material.dart';
import '../tasks_screen.dart';

class SearchService {
  // Search through tasks by name and description
  static List<Task> searchTasks(List<Task> tasks, String query) {
    if (query.isEmpty) {
      return tasks;
    }
    
    return tasks.where((task) {
      return task.name.toLowerCase().contains(query.toLowerCase()) ||
             task.description.toLowerCase().contains(query.toLowerCase());
    }).toList();
  }

  // Build highlighted text widget for search results
  static Widget buildHighlightedText(String text, String query, TextStyle style) {
    if (query.isEmpty) {
      return Text(
        text,
        style: style,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      );
    }

    final lowerText = text.toLowerCase();
    final lowerQuery = query.toLowerCase();
    
    if (!lowerText.contains(lowerQuery)) {
      return Text(
        text,
        style: style,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      );
    }

    final List<TextSpan> spans = [];
    int start = 0;
    
    while (start < text.length) {
      final index = lowerText.indexOf(lowerQuery, start);
      if (index == -1) {
        // No more matches, add the rest of the text
        spans.add(TextSpan(text: text.substring(start), style: style));
        break;
      }
      
      // Add text before the match
      if (index > start) {
        spans.add(TextSpan(text: text.substring(start, index), style: style));
      }
      
      // Add highlighted match
      spans.add(TextSpan(
        text: text.substring(index, index + query.length),
        style: style.copyWith(
          backgroundColor: Colors.yellow.withOpacity(0.3),
          fontWeight: FontWeight.bold,
        ),
      ));
      
      start = index + query.length;
    }

    return RichText(
      text: TextSpan(children: spans),
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
    );
  }
}
