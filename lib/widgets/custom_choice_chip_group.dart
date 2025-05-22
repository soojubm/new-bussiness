import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CustomChoiceChipGroup extends StatelessWidget {
  final int selectedIndex;
  final List<String> chipLabels;
  final ValueChanged<int> onSelectionChanged;
  final List<String>? chipSvgPaths;

  CustomChoiceChipGroup({
    required this.selectedIndex,
    required this.chipLabels,
    required this.onSelectionChanged,
    this.chipSvgPaths,
  });

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 8.0,
      children: chipLabels
          .asMap()
          .map((index, label) {
            final svgPath =
                (chipSvgPaths != null && index < chipSvgPaths!.length)
                    ? chipSvgPaths![index]
                    : null;

            return MapEntry(
              index,
              ChoiceChip(
                showCheckmark: false,
                label: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    if (svgPath != null) ...[
                      SvgPicture.asset(
                        svgPath,
                        width: 18,
                        height: 18,
                        colorFilter: ColorFilter.mode(
                          selectedIndex == index ? Colors.white : Colors.black,
                          BlendMode.srcIn,
                        ),
                        placeholderBuilder: (context) =>
                            Icon(Icons.image_not_supported, size: 18),
                      ),
                      SizedBox(width: 4),
                    ],
                    Text(label),
                  ],
                ),
                selected: selectedIndex == index,
                onSelected: (bool selected) {
                  onSelectionChanged(index);
                },
                backgroundColor: Color(0xFFFFF5F5),
                shape: StadiumBorder(
                  side: BorderSide(
                    color: selectedIndex == index
                        ? Colors.black
                        : Color(0xFFD1D1D1),
                  ),
                ),
                selectedColor: Colors.black,
                labelStyle: TextStyle(
                  color: selectedIndex == index ? Colors.white : Colors.black,
                ),
              ),
            );
          })
          .values
          .toList(),
    );
  }
}
