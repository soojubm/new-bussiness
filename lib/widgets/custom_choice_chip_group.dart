import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CustomChoiceChipGroup extends StatelessWidget {
  final int selectedIndex;
  final List<String> chipLabels;
  final ValueChanged<int> onSelectionChanged;
  final List<String>? chipSvgPaths; // SVG 경로는 선택 사항

  CustomChoiceChipGroup({
    required this.selectedIndex,
    required this.chipLabels,
    required this.onSelectionChanged,
    this.chipSvgPaths, // 선택 사항으로 변경
  });

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 8.0,
      children: chipLabels
          .asMap()
          .map((index, label) {
            final svgPath = chipSvgPaths != null && index < chipSvgPaths!.length
                ? chipSvgPaths![index]
                : null; // svgPath가 null일 수도 있음

            return MapEntry(
              index,
              ChoiceChip(
                showCheckmark: false, // 기본 체크 표시 제거
                label: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // 선택된 경우에만 체크 아이콘을 표시
                    if (selectedIndex == index)
                      Icon(
                        Icons.check,
                        size: 18,
                        color: Colors.white, // 체크 아이콘 색상
                      ),
                    // SVG 이미지가 있는 경우
                    if (svgPath != null && selectedIndex != index) ...[
                      SvgPicture.asset(
                        svgPath,
                        width: 18,
                        height: 18,
                        colorFilter: ColorFilter.mode(
                          Colors.black,
                          BlendMode.srcIn,
                        ),
                        placeholderBuilder: (context) =>
                            Icon(Icons.image_not_supported, size: 18),
                      ),
                    ],
                    SizedBox(width: 4),
                    // 텍스트 표시
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
