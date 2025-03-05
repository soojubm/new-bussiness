import 'package:flutter/material.dart';

// dissmisable, selectable

class CustomInputChipGroup extends StatelessWidget {
  final List<String> filters;
  final ValueChanged<String> onDeleted;
  // final List<String> selectedFilters;
  // final ValueChanged<List<String>> onSelectionChanged;

  CustomInputChipGroup({
    required this.filters,
    required this.onDeleted,
    // required this.selectedFilters,
    // required this.onSelectionChanged,
  });

  // bool isSelected(String filter) {
  //   return selectedFilters.contains(filter);
  // }

  // void toggleSelection(String filter) {
  //   if (isSelected(filter)) {
  //     onSelectionChanged(selectedFilters..remove(filter));
  //   } else {
  //     onSelectionChanged(selectedFilters..add(filter));
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 10.0,
      children: filters.map((filter) {
        return InputChip(
            label: Text(filter),
            // selected: isSelected(filter),
            // onSelected: (isSelected) {
            //   toggleSelection(filter);
            // },
            selectedColor: Colors.blueAccent,
            backgroundColor: Colors.grey[300],
            shape: StadiumBorder(),
            onDeleted: () {
              onDeleted(filter);
            }
            // labelStyle: TextStyle(
            //   color: isSelected(filter) ? Colors.white : Colors.black,
            // ),
            );
      }).toList(),
    );
  }
}
