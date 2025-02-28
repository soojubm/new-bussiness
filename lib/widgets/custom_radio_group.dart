import 'package:flutter/material.dart';
import 'package:flutter_application_1/widgets/custom_radio.dart';

class CustomRadioGroup extends StatelessWidget {
  final List<String> options; // 라디오 버튼의 옵션들
  final int selectedValue; // 선택된 값의 인덱스
  final ValueChanged<int> onChanged; // 라디오 버튼 클릭 시 호출되는 콜백

  CustomRadioGroup({
    required this.options,
    required this.selectedValue,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: List.generate(
        options.length,
        (index) => GestureDetector(
          onTap: () {
            onChanged(index); // 라디오 버튼 클릭 시 선택된 인덱스 전달
          },
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              CustomRadio(
                value: selectedValue == index, // 선택된 인덱스와 비교
                onChanged: (_) {
                  onChanged(index); // 라디오 버튼 클릭 시 선택된 인덱스 전달
                },
              ),
              SizedBox(width: 10),
              Text(
                options[index], // 옵션 이름
                style: TextStyle(fontSize: 18),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
