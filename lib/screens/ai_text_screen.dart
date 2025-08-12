import 'package:flutter/material.dart';
import 'package:flutter_application_1/main.dart';
import 'package:flutter_application_1/screens/ai_screen.dart';
import 'package:flutter_application_1/widgets/action_list.dart';
import 'package:flutter_application_1/widgets/chat_bubble.dart';
import 'package:flutter_application_1/widgets/custom_button.dart';
import 'package:flutter_application_1/widgets/custom_text.dart';
import 'package:flutter_application_1/widgets/typing_sequence.dart';
import 'package:flutter_application_1/widgets/typing_text.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../widgets/custom_app_bar.dart'; // 경로는 프로젝트에 맞게 조정

enum ButtonState {
  nullState, // 초기 상태 또는 비활성화 상태
  productDetail, // 상품 상세 페이지 상태
  instagram, // 인스타그램 상태
  shortform, // 틱톡/쇼츠 상태
}

class AiTextScreen extends StatefulWidget {
  @override
  _AiTextScreenState createState() => _AiTextScreenState();
}

class _AiTextScreenState extends State<AiTextScreen> {
  // const AiTextScreen({super.key});
  ButtonState selectedButtonState = ButtonState.nullState;

  void _updateButtonState(ButtonState newState) {
    setState(() {
      selectedButtonState = newState;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: 'AI 텍스트',
        variant: AppBarVariant.up,
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.symmetric(
              vertical: 16.0, horizontal: horizontalPadding),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // SizedBox(height: 8),
              // CustomText(
              //   variant: 'label1',
              //   text: '상세페이지 제작을 위한 모든 것 \nAI가 도와드려요.',
              //   color: Color(0xFF5D5D5D),
              // ),
              TypingSequence(
                firstWidget: TypingText(variant: 'h4', text: '어떤 내용이 필요하세요?'),
                secondWidget: TypingText(
                  variant: 'label1',
                  text: '상세페이지 내용, SNS 게시물 등 \n상품 홍보를 위한 내용을 자동으로 만들어 드려요.',
                  color: Color(0xFF5D5D5D),
                ),
                thirdWidget: Column(
                  spacing: 8.0,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomButton(
                      variant: 'secondary',
                      size: 'medium',
                      text: '상품 상세페이지',
                      onPressed: () {
                        _updateButtonState(ButtonState.productDetail);
                      },
                      disabled: selectedButtonState != ButtonState.nullState,
                    ),
                    CustomButton(
                      variant: 'secondary',
                      size: 'medium',
                      text: '인스타그램',
                      onPressed: () {
                        _updateButtonState(ButtonState.instagram);
                      },
                      disabled: true,
                    ),
                    CustomButton(
                      variant: 'secondary',
                      size: 'medium',
                      text: '틱톡/쇼츠',
                      onPressed: () {
                        _updateButtonState(ButtonState.shortform);
                      },
                      disabled: true,
                    ),
                  ],
                ),
              ),
              SizedBox(height: 24),

              // 상태에 맞는 위젯을 출력하는 StatusWidget
              StatusWidget(selectedButtonState: selectedButtonState), // 여기서 전달

              ActionList(
                children: [
                  CustomButton(
                    variant: 'secondary2',
                    size: 'medium',
                    text: '텍스트 복사',
                    onPressed: () => {},
                    leadingIcon: SvgPicture.asset(
                      '/icons/image_save.svg',
                      width: 24,
                      height: 24,
                      // colorFilter: Color(0xFFDE3B35)),
                    ),
                  ),
                  CustomButton(
                    variant: 'secondary2',
                    size: 'medium',
                    text: '텍스트 재작성',
                    onPressed: () => {},
                    leadingIcon: SvgPicture.asset(
                      '/icons/background_remove.svg',
                      width: 24,
                      height: 24,
                      // colorFilter: Color(0xFFDE3B35)),
                    ),
                  ),
                  CustomButton(
                    variant: 'secondary2',
                    size: 'medium',
                    text: 'AI 이미지 생성',
                    onPressed: () => {},
                    leadingIcon: SvgPicture.asset(
                      '/icons/ai_generate.svg',
                      width: 24,
                      height: 24,
                      // colorFilter: Color(0xFFDE3B35)),
                    ),
                  ),
                ],
              ),
              // 버블
              ChatBubble(isUser: true, message: '2025년 신년 이벤트 감사 특별한 선물 와인'),
            ],
          ),
        ),
      ),
      floatingActionButton: Align(
        alignment: Alignment.bottomCenter, // 하단 가운데로 정렬
        child: Column(
          mainAxisSize: MainAxisSize.min, // Column의 크기를 필요한 만큼만 설정
          children: [
            // TextField 위젯에 좌우 간격 추가
            Padding(
              padding: const EdgeInsets.fromLTRB(24.0, 0, 24.0, 8.0),
              child: TextField(
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: 16.0,
                ),
                cursorColor: Colors.grey,
                decoration: InputDecoration(
                  hintText: 'AI에게 상세내용을 알려주세요.',
                  hintStyle: TextStyle(
                    color: Colors.grey,
                    fontSize: 16.0,
                  ),
                  filled: true,
                  fillColor: Color(0xFF141414),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(100.0),
                    borderSide: BorderSide(color: Colors.blue, width: 2.0),
                  ),
                  suffixIcon: Padding(
                    padding: const EdgeInsets.only(right: 12.0),
                    child: Container(
                      width: 56.0,
                      height: 40.0,
                      decoration: BoxDecoration(
                        color: Color(0xFF373C42),
                        borderRadius: BorderRadius.circular(40.0),
                      ),
                      child: IconButton(
                        icon: SvgPicture.asset(
                          'assets/icons/input_submit.svg',
                          width: 20,
                          height: 20,
                        ),
                        onPressed: () {},
                        iconSize: 24.0,
                        color: Colors.white,
                        padding: EdgeInsets.zero,
                        splashColor: Colors.transparent,
                        highlightColor: Colors.transparent,
                      ),
                    ),
                  ),
                  contentPadding: EdgeInsets.fromLTRB(32.0, 24.0, 12.0, 24.0),
                ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}

class StatusWidget extends StatelessWidget {
  final ButtonState selectedButtonState;

  StatusWidget({required this.selectedButtonState}); // 상태를 전달받음

  @override
  Widget build(BuildContext context) {
    switch (selectedButtonState) {
      case ButtonState.productDetail:
        return Column(
          children: [
            TypingSequence(
              firstWidget: TypingText(variant: 'h4', text: '상품에 대한 내용을 알려주세요.'),
              secondWidget: TypingText(
                variant: 'label1',
                text: '상품의 구체적인 특징이나 상세한 정보를 알려주시면, 더 완성도 있게 작성할 수 있어요.',
                color: Color(0xFF5D5D5D),
              ),
              thirdWidget: Column(
                spacing: 8.0,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [],
              ),
            ),
          ],
        );
      case ButtonState.instagram:
        return Column(
          children: [
            Text("인스타그램이 선택되었습니다."),
            // Instagram 관련 UI 추가
          ],
        );
      case ButtonState.shortform:
        return Column(
          children: [
            Text("틱톡/쇼츠가 선택되었습니다."),
            // TikTok/ShortForm 관련 UI 추가
          ],
        );
      case ButtonState.nullState:
      default:
        return Center(
          child: Text("아직 선택되지 않았습니다."),
        );
    }
  }
}
