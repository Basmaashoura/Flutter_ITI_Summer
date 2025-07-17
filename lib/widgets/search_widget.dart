import 'package:flutter/material.dart';

class SearchWidget extends StatelessWidget {
  final TextEditingController searchController;
  final String searchQuery;
  final bool isSearching;
  final Function(String) onSearchChanged;
  final VoidCallback onSearchToggle;

  const SearchWidget({
  Key? key,
    required this.searchController,
    required this.searchQuery,
    required this.isSearching,
    required this.onSearchChanged,
    required this.onSearchToggle,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Search indicator
        if (searchQuery.isNotEmpty)
          Container(
            width: double.infinity,
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            color: Colors.blue.withOpacity(0.1),
            child: Row(
              children: [
                Icon(Icons.search, color: const Color(0xFF2072FA), size: 20),
                SizedBox(width: 8),
                Expanded(
                  child: Text(
                    'Search results for: "$searchQuery"',
                    style: TextStyle(
                      color: const Color(0xFF2072FA),
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                TextButton(
                  onPressed: () {
                    searchController.clear();
                    onSearchChanged('');
                  },
                  child: Text(
                    'Clear',
                    style: TextStyle(color: const Color(0xFF2072FA)),
                  ),
                ),
              ],
            ),
          ),
      ],
    );
  }
}

class SearchAppBar extends StatelessWidget implements PreferredSizeWidget {
  final bool isSearching;
  final TextEditingController searchController;
  final Function(String) onSearchChanged;
  final VoidCallback onSearchToggle;
  final VoidCallback? onFilterPressed;

  const SearchAppBar({
    Key? key,
    required this.isSearching,
    required this.searchController,
    required this.onSearchChanged,
    required this.onSearchToggle,
    this.onFilterPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: isSearching
          ? TextField(
              controller: searchController,
              decoration: InputDecoration(
                hintText: 'Search tasks...',
                hintStyle: TextStyle(color: Colors.white.withOpacity(0.7)),
                border: InputBorder.none,
              ),
              style: TextStyle(
                color: Colors.white,
                fontSize: 18,
              ),
              onChanged: onSearchChanged,
              autofocus: true,
            )
          : Text(
              "My Tasks",
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
      centerTitle: true,
      backgroundColor: const Color(0xFF2072FA),
      foregroundColor: Colors.white,
      elevation: 0,
      actions: [
        IconButton(
          icon: Icon(
            isSearching ? Icons.close : Icons.search,
            color: Colors.white,
          ),
          onPressed: onSearchToggle,
          tooltip: isSearching ? 'Close Search' : 'Search',
        ),
        if (!isSearching && onFilterPressed != null)
          IconButton(
            icon: Icon(Icons.tune, color: Colors.white),
            onPressed: onFilterPressed,
            tooltip: 'Filter & Sort',
          ),
      ],
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}
