import 'package:flutter/material.dart';
import '../services/sort_service.dart';

class FilterSortDialog extends StatefulWidget {
  final int? selectedFilterPriority;
  final String selectedSort;
  final bool isAscending;
  final Function(int?) onFilterChanged;
  final Function(String) onSortChanged;
  final Function(bool) onSortOrderChanged;

  const FilterSortDialog({
    Key? key,
    required this.selectedFilterPriority,
    required this.selectedSort,
    required this.isAscending,
    required this.onFilterChanged,
    required this.onSortChanged,
    required this.onSortOrderChanged,
  }) : super(key: key);

  @override
  _FilterSortDialogState createState() => _FilterSortDialogState();
}

class _FilterSortDialogState extends State<FilterSortDialog> {
  late int? selectedFilterPriority;
  late String selectedSort;
  late bool isAscending;

  @override
  void initState() {
    super.initState();
    selectedFilterPriority = widget.selectedFilterPriority;
    selectedSort = widget.selectedSort;
    isAscending = widget.isAscending;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
          Row(
            children: [
              IconButton(
                icon: Icon(Icons.close),
                onPressed: () => Navigator.pop(context),
              ),
              Expanded(
                child: Text(
                  'Filter & Sort',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: const Color(0xFF2072FA),
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              SizedBox(width: 48),
            ],
          ),
          SizedBox(height: 20),

          // Filters Section
          Container(
            padding: EdgeInsets.all(15),
            decoration: BoxDecoration(
              color: Colors.grey[100],
              borderRadius: BorderRadius.circular(12),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Filters',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Colors.grey[700],
                  ),
                ),
                SizedBox(height: 12),
                Wrap(
                  spacing: 8,
                  children: [
                    _buildFilterChip('All', null),
                    _buildFilterChip('Completed', -1, Icons.done_all, Colors.green),
                    _buildFilterChip('High', 1, Icons.priority_high_rounded, Colors.red),
                    _buildFilterChip('Medium', 2, Icons.priority_high_rounded, Colors.orange),
                    _buildFilterChip('Low', 3, Icons.priority_high_rounded, Colors.green),
                  ],
                ),
              ],
            ),
          ),

          SizedBox(height: 16),

          // Sort Section
          Text(
            'Sort By',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: Colors.grey[700],
            ),
          ),
          SizedBox(height: 12),

          // Sort options
          ...SortService.getSortTypes().map((sortType) {
            return RadioListTile<String>(
              title: Text(SortService.getSortDisplayName(sortType)),
              value: sortType,
              groupValue: selectedSort,
              activeColor: const Color(0xFF2072FA),
              onChanged: (value) {
                setState(() {
                  selectedSort = value!;
                });
              },
            );
          }).toList(),

          // Sort order toggle
          SwitchListTile(
            title: Text('Ascending Order'),
            value: isAscending,
            activeColor: const Color(0xFF2072FA),
            onChanged: (value) {
              setState(() {
                isAscending = value;
              });
            },
          ),

          SizedBox(height: 20),

          // Apply button
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {
                widget.onFilterChanged(selectedFilterPriority);
                widget.onSortChanged(selectedSort);
                widget.onSortOrderChanged(isAscending);
                Navigator.pop(context);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF2072FA),
                foregroundColor: Colors.white,
                padding: EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: Text(
                'Apply',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFilterChip(String label, int? value, [IconData? icon, Color? color]) {
    return FilterChip(
      label: icon != null
          ? Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(icon, color: color, size: 16),
                SizedBox(width: 4),
                Text(label),
              ],
            )
          : Text(label),
      selected: selectedFilterPriority == value,
      onSelected: (selected) {
        setState(() {
          selectedFilterPriority = selected ? value : null;
        });
      },
      selectedColor: (color ?? const Color(0xFF2072FA)).withOpacity(0.2),
      checkmarkColor: color ?? const Color(0xFF2072FA),
    );
  }
}
