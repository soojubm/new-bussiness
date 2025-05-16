import 'package:flutter/material.dart';
import 'package:flutter_application_1/screens/ai_screen.dart';
import 'package:flutter_application_1/widgets/action_list.dart';
import 'package:flutter_application_1/widgets/chat_bubble.dart';
import 'package:flutter_application_1/widgets/custom_button.dart';
import 'package:flutter_application_1/widgets/custom_text.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../widgets/custom_app_bar.dart'; // 경로는 프로젝트에 맞게 조정

class AiTextScreen extends StatelessWidget {
  const AiTextScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: 'AI 텍스트',
        variant: AppBarVariant.up,
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomText(variant: 'h4', text: '어떤 내용이 필요하세요?'),
              SizedBox(height: 8),
              CustomText(
                variant: 'label1',
                text: '상세페이지 내용, SNS 게시물 등 \n상품 홍보를 위한 내용을 자동으로 만들어 드려요.',
                color: Color(0xFF5D5D5D),
              ),
              SizedBox(height: 24),
              Column(
                spacing: 8.0,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomButton(
                    variant: 'secondary',
                    size: 'medium',
                    text: '상품 상세페이지',
                    onPressed: () => {},
                  ),
                  CustomButton(
                    variant: 'secondary',
                    size: 'medium',
                    text: '인스타그램',
                    disabled: true,
                    onPressed: () => {},
                  ),
                  CustomButton(
                    variant: 'secondary',
                    size: 'medium',
                    text: '틱톡/쇼츠',
                    disabled: true,
                    onPressed: () => {},
                  ),
                ],
              ),
              SizedBox(height: 24),

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
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      child: IconButton(
                        icon: SvgPicture.asset(
                          '/icons/input_submit.svg',
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
