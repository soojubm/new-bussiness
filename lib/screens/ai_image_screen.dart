import 'package:flutter/material.dart';
import 'package:flutter_application_1/screens/ai_screen.dart';
import 'package:flutter_application_1/widgets/custom_button.dart';
import 'package:flutter_application_1/widgets/custom_text.dart';
import 'package:flutter_application_1/widgets/image_with_fallback.dart';
import 'package:flutter_application_1/widgets/typing_text.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../widgets/custom_app_bar.dart'; // 경로는 프로젝트에 맞게 조정

class AIImageScreen extends StatefulWidget {
  @override
  _AIImageScreenState createState() => _AIImageScreenState();
}

class _AIImageScreenState extends State<AIImageScreen> {
  bool showSecondWidget = false;
  bool showThirdWidget = false;
  bool showFourthWidget = false;

  // const _AIScreenState({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: 'AI 이미지',
        variant: AppBarVariant.up,
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomText(variant: 'h4', text: '어떤 이미지를 만들어 드릴까요?'),
              SizedBox(height: 8),
              CustomText(
                variant: 'label1',
                text: '상품 이미지만 올려주세요. \nAI가 자동으로 어울리는 배경을 만들어 드려요.',
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
                    text: '이미지 배경제거',
                    onPressed: () => {},
                  ),
                  CustomButton(
                    variant: 'secondary',
                    size: 'medium',
                    text: 'AI 이미지 생성',
                    onPressed: () => {},
                  ),
                ],
              ),
              SizedBox(height: 24),

              // 텍스트 영역
              SizedBox(height: 16),
              TypingText(
                // variant: "h4",
                text: '상품 이미지를 업로드해주세요.',
                textStyle: TextStyle(
                  fontSize: 24.0,
                  height: 1.35,
                  fontWeight: FontWeight.bold,
                ),
                onProgress: (progress) {
                  if (progress > 0.85 && !showSecondWidget) {
                    setState(() {
                      showSecondWidget = true;
                      debugPrint(
                          'showSecondWidget is now: $showSecondWidget'); // 상태 값 출력
                    });
                  }
                },
              ),
              SizedBox(height: 8),

              if (showSecondWidget) ...[
                TypingText(
                  text: '업로드한 이미지의 배경을 자동으로 제거해 드려요.',
                  textStyle: TextStyle(
                      fontSize: 16.0, height: 1.5, color: Colors.grey),
                  onProgress: (progress) {
                    if (progress > 0.85 && !showThirdWidget) {
                      setState(() {
                        showThirdWidget = true;
                      });
                    }
                  },
                ),
                SizedBox(height: 24),
              ],

              SizedBox(height: 16),
              if (showThirdWidget) ...[
                Row(
                  spacing: 8,
                  children: [
                    TypingText(
                      text: 'AI가 이미지를 만들고 있어요. \n약간의 시간이 소요됩니다.',
                      textStyle: TextStyle(
                        fontSize: 16.0,
                        height: 1.5,
                        color: Colors.grey,
                      ),
                      onProgress: (progress) {
                        if (progress > 0.85 && !showFourthWidget) {
                          setState(() {
                            showFourthWidget = true;
                          });
                        }
                      },
                    ),
                  ],
                ),
                SizedBox(height: 24),
              ],

              if (showFourthWidget) ...[
                ImageWithFallback(
                  imageUrl: 'assets/images/image_fallback.svg',
                  fallbackImageUrl: 'assets/images/image_fallback.svg',
                  loadingImageAsset: 'assets/images/image_fallback.svg',
                ),
                SizedBox(height: 24),
              ],

              Container(
                width: MediaQuery.of(context).size.width * 0.68,
                child: GridView.count(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(), // 스크롤과 충돌? 방지
                  primary: false,
                  // padding: const EdgeInsets.all(20),
                  crossAxisSpacing: 8,
                  mainAxisSpacing: 8,
                  crossAxisCount: 2,
                  children: <Widget>[
                    ImageWithFallback(
                      imageUrl: 'assets/images/image_fallback.svg',
                      fallbackImageUrl: 'assets/images/image_fallback.svg',
                      loadingImageAsset: 'assets/images/image_fallback.svg',
                    ),
                    ImageWithFallback(
                      imageUrl: 'assets/images/image_fallback.svg',
                      fallbackImageUrl: 'assets/images/image_fallback.svg',
                      loadingImageAsset: 'assets/images/image_fallback.svg',
                    ),
                    ImageWithFallback(
                      imageUrl: 'assets/images/image_fallback.svg',
                      fallbackImageUrl: 'assets/images/image_fallback.svg',
                      loadingImageAsset: 'assets/images/image_fallback.svg',
                    ),
                    ImageWithFallback(
                      imageUrl: 'assets/images/image_fallback.svg',
                      fallbackImageUrl: 'assets/images/image_fallback.svg',
                      loadingImageAsset: 'assets/images/image_fallback.svg',
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: Align(
        alignment: Alignment.bottomCenter, // 하단 가운데로 정렬
        child: Column(
          mainAxisSize: MainAxisSize.min, // Column의 크기를 필요한 만큼만 설정
          children: [
            // CustomButton 위젯에 좌우 간격 추가
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0), // 좌우 여백
              child: CustomButton(
                variant: 'primary',
                size: 'large',
                text: '이미지 업로드',
                isFullWidth: true,
                onPressed: () => {},
              ),
            ),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}
