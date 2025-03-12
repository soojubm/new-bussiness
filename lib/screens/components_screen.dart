import 'package:flutter/material.dart';
import 'package:flutter_application_1/constants/toekns_constants.dart';
import 'package:flutter_application_1/providers/test_provider.dart';
import 'package:flutter_application_1/screens/login_screen.dart';
import 'package:flutter_application_1/widgets/custom_button_group.dart';
import 'package:flutter_application_1/widgets/custom_choice_chip_group.dart';
import 'package:flutter_application_1/widgets/custom_button.dart';
import 'package:flutter_application_1/widgets/custom_filter_chip_group.dart';
import 'package:flutter_application_1/widgets/custom_icon_button.dart';
import 'package:flutter_application_1/widgets/custom_input_chip_group.dart';
import 'package:flutter_application_1/widgets/custom_modal_bottom_sheet.dart';
import 'package:flutter_application_1/widgets/custom_radio.dart';
import 'package:flutter_application_1/widgets/custom_radio_group.dart';
import 'package:flutter_application_1/widgets/custom_switch.dart';
import 'package:flutter_application_1/widgets/custom_text.dart';
import 'package:flutter_application_1/widgets/custom_text_field.dart';
import 'package:flutter_application_1/widgets/custom_checkbox.dart';
import 'package:flutter_application_1/widgets/custom_chip.dart';
import 'package:flutter_application_1/widgets/custom_input_chip.dart';
import 'package:flutter_application_1/widgets/result.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ComponentsScreen extends ConsumerStatefulWidget {
  @override
  _ComponentsScreenState createState() => _ComponentsScreenState();
}

class _ComponentsScreenState extends ConsumerState<ComponentsScreen> {
  TextEditingController _controller = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  void _login() {
    if (_formKey.currentState?.validate() ?? false) {
      Navigator.pushNamed(context, '/home');
    } else {
      // 검증 실패 시 알림
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Please fill in all fields correctly.')),
      );
    }
  }

  // 공통 입력값 검증 함수
  String? commonValidator(String? value, String fieldName) {
    if (value == null || value.isEmpty) {
      return 'Please enter a $fieldName';
    }
    return null;
  }

  // 체크박스
  bool _isChecked = false;

  void _handleCheckboxChange(bool value) {
    setState(() {
      _isChecked = value;
    });
  }

  // 스위치
  bool _isSwitched = false;

  void _toggleSwitch(bool value) {
    setState(() {
      _isSwitched = value;
    });
  }

  // 라디오
  int? _selectedValue;

  void _handleRadioValueChanged(int? value) {
    setState(() {
      _selectedValue = value;
    });
  }

  // 라디오 그룹룹
  int _selectedIndex = 0;

  void _handleRadioValueChanged1(int value) {
    setState(() {
      _selectedIndex = value;
    });
  }

  // 칩
  // 선택된 인덱스를 MyApp에서 관리
  int _selectedIndex1 = 1;

  final List<String> _chipLabels = [
    'ChoiceChip 1',
    'ChoiceChip 2',
    'ChoiceChip 3',
    'ChoiceChip 4',
  ];

  // filterChips
  List<String> selectedFilters = ['FilterChip 1'];

  void onSelectionChanged(List<String> selectedFilters) {
    setState(() {
      this.selectedFilters = selectedFilters;
    });
  }

  List<String> inputChips = [
    'InputChip 1',
    'InputChip 2',
    'InputChip 3',
    'InputChip 4'
  ];
  void handleChipDeleted(String filter) {
    setState(() {
      inputChips.remove(filter); // 선택된 필터를 리스트에서 제거
    });
  }

  @override
  Widget build(BuildContext context) {
    // 글로벌 상태
    final globalCounter = ref.watch(counterProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text('Login Page'),
      ),
      body: SingleChildScrollView(
        child: Padding(
            padding: const EdgeInsets.all(gridMargin),
            child: Form(
              key: _formKey,
              child: Column(
                // mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Global Counter: $globalCounter',
                    style: TextStyle(fontSize: 30),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      IconButton(
                        icon: Icon(Icons.add),
                        onPressed: () {
                          ref.read(counterProvider.notifier).state++;
                        },
                      ),
                      IconButton(
                        icon: Icon(Icons.remove),
                        onPressed: () {
                          ref.read(counterProvider.notifier).state--;
                        },
                      ),
                    ],
                  ),
                  Result(title: '페이지가 없습니다.', description: '내용입니다'),
                  CustomText(
                      variant: 'title',
                      text: 'Title 텍스트',
                      color: Colors.indigo),
                  CustomText(variant: 'body', text: 'body 텍스트'),
                  CustomText(variant: 'label', text: 'label 텍스트'),

                  Column(spacing: 4.0, children: [
                    CustomButton(
                      variant: 'fille',
                      size: 'small',
                      text: '로그인',
                      onPressed: _login,
                    ),
                    CustomButton(
                      variant: 'secondary',
                      size: 'small',
                      text: '로그인',
                      onPressed: _login,
                    ),
                    CustomButton(
                      variant: 'fille',
                      text: '로그인',
                      onPressed: _login,
                    ),
                  ]),

                  // 왜 안 됨
                  CustomButtonGroup(
                    firstButtonText: '확인',
                    secondButtonText: '취소',
                    onFirstButtonPressed: () {
                      print('확인');
                    },
                    onSecondButtonPressed: () {
                      print('취소');
                    },
                  ),

                  Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                    CustomIconButton(
                        icon: Icons.volume_up,
                        tooltip: "아이콘 버튼 스몰",
                        onPressed: () {
                          print('아이콘 버튼이 눌렸습니다!');
                        },
                        size: ButtonSize.small),
                    CustomIconButton(
                        icon: Icons.volume_up,
                        tooltip: "아이콘 버튼 미디엄",
                        onPressed: () {
                          print('아이콘 버튼이 눌렸습니다!');
                        }),
                  ]),
                  CustomCheckbox(
                    value: _isChecked,
                    onChanged: _handleCheckboxChange,
                  ),

                  // CustomRadio(
                  //   value: _selectedValue == 0,
                  //   onChanged: (bool newValue) {
                  //     _handleRadioValueChanged(newValue ? 0 : null);
                  //   },
                  // ),
                  // SizedBox(height: 10),
                  // CustomRadio(
                  //   value: _selectedValue == 1,
                  //   onChanged: (bool newValue) {
                  //     _handleRadioValueChanged(newValue ? 1 : null);
                  //   },
                  // ),

                  CustomRadioGroup(
                    options: ['Option 1', 'Option 2', 'Option 3'], // 라디오 버튼 옵션
                    selectedValue: _selectedIndex, // 선택된 인덱스
                    onChanged: _handleRadioValueChanged1, // 라디오 버튼 선택 시 호출되는 콜백
                  ),

                  CustomChip(label: "커스텀 칩이다 이놈아 에라이 이놈어ㅏ"),
                  CustomInputChip(label: "InputChip"),

                  CustomInputChipGroup(
                    filters: inputChips,
                    onDeleted: handleChipDeleted,
                    // selectedFilters: selectedFilters,
                    // onSelectionChanged: onSelectionChanged,
                  ),

                  CustomChoiceChipGroup(
                    selectedIndex: _selectedIndex1, // MyApp에서 관리되는 상태 전달
                    chipLabels: _chipLabels,
                    onSelectionChanged: (int index) {
                      setState(() {
                        _selectedIndex1 = index; // 상태를 MyApp에서 업데이트
                      });
                    },
                  ),

                  CustomFilterChipGroup(
                    filters: [
                      'FilterChip 1',
                      'FilterChip 2',
                      'FilterChip 3',
                      'FilterChip 4'
                    ],
                    selectedFilters: selectedFilters,
                    onSelectionChanged: onSelectionChanged,
                  ),

                  CustomSwitch(
                    value: _isSwitched,
                    onChanged: _toggleSwitch,
                  ),
                  // Button to navigate to the NativePluginWidget page
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => NativePluginWidget()),
                      );
                    },
                    child: Text('Open Image Picker'),
                  ),

                  const SizedBox(height: 8),

                  // dialog
                  ElevatedButton(
                    onPressed: () => showDialog<String>(
                      context: context,
                      builder: (BuildContext context) => Dialog(
                        child: Padding(
                          padding: const EdgeInsets.all(24.0),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            // mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              CustomText(
                                  variant: 'body',
                                  text: 'This is a typical dialog.'),
                              const SizedBox(height: 4),
                              const Text('This is a typical dialog.'),
                              const SizedBox(height: 15),
                              // buttonGroup
                              TextButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                child: const Text('Close'),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    child: const Text('Show Dialog'),
                  ),

                  const SizedBox(height: 8),

                  // bottom sheet
                  ElevatedButton(
                    child: Text('showModalBottomSheet'),
                    onPressed: () {
                      showModalBottomSheet<void>(
                        context: context,
                        builder: (BuildContext context) {
                          return CustomModalBottomSheet(
                            title: 'Modal BottomSheet',
                            child: ElevatedButton(
                              onPressed: () => Navigator.pop(context),
                              child: Text('Close BottomSheet'),
                            ),
                          );
                        },
                      );
                    },
                  )
                ],
              ),
            )),
      ),
    );
  }
}
