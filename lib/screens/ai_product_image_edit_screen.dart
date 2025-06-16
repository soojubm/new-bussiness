import 'package:flutter/material.dart';
import 'package:flutter_application_1/screens/ai_screen.dart';
import 'package:flutter_application_1/widgets/custom_button.dart';
import 'package:flutter_application_1/widgets/custom_icon_button.dart';
import 'package:flutter_application_1/widgets/custom_modal_bottom_sheet.dart';
import 'package:flutter_application_1/widgets/custom_text.dart';
import 'package:flutter_application_1/widgets/image_with_fallback.dart';
import 'package:flutter_application_1/widgets/typing_text.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:webview_flutter/webview_flutter.dart';

// webview_flutter 패키지와 플랫폼별 기능을 가져옵니다.
// import 'package:webview_flutter/webview_flutter.dart';

import '../widgets/custom_app_bar.dart';

class AiProductImageEditScreen extends StatefulWidget {
  // const AiProductImageEditScreen({super.key});

  @override
  _AIProductImageEditScreenState createState() =>
      _AIProductImageEditScreenState();
}

class _AIProductImageEditScreenState extends State<AiProductImageEditScreen> {
  int selectedIndex = 0;

  late final WebViewController _controller;

  // @override
  // void initState() {
  //   super.initState();
  //   // WebView 초기화
  //   _controller = WebViewController()
  //     ..setJavaScriptMode(JavaScriptMode.unrestricted)
  //     ..setNavigationDelegate(
  //       NavigationDelegate(
  //         onProgress: (int progress) {
  //           // Update loading bar.
  //         },
  //         onPageStarted: (String url) {},
  //         onPageFinished: (String url) {},
  //         onHttpError: (HttpResponseError error) {},
  //         onWebResourceError: (WebResourceError error) {},
  //         onNavigationRequest: (NavigationRequest request) {
  //           if (request.url.startsWith('https://www.youtube.com/')) {
  //             return NavigationDecision.prevent;
  //           }
  //           return NavigationDecision.navigate;
  //         },
  //       ),
  //     )
  //     ..loadRequest(Uri.parse('https://flutter.dev'));
  // }

  // // input 값을 Flutter에서 수정하는 함수
  // void _updateInputValue() async {
  //   // WebView 안에서 JavaScript를 실행하여 input 값을 변경
  //   await _controller.runJavaScript(
  //       'document.getElementById("myInput").value = "Flutter에서 수정된 값";');
  // }

  @override
  initState() {
    super.initState();
    _controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..loadRequest(Uri.parse('https://flutter.dev'));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: CustomAppBar(
        title: 'AI 이미지',
        variant: AppBarVariant.up,
        colorMode: 'dark',
        actions: [
          CustomIconButton(
            icon: SvgPicture.asset(
              '/icons/layers.svg',
              width: 24,
              height: 24,
            ),
            tooltip: "아이콘 버튼 미디엄",
            onPressed: () {
              showModalBottomSheet<void>(
                context: context,
                showDragHandle: true,
                builder: (BuildContext context) {
                  return CustomModalBottomSheet(
                    title: '전체 레이어 변경',
                    child: ListView.separated(
                      shrinkWrap: true,
                      itemCount: 4,
                      itemBuilder: (context, index) {
                        return ListTile(
                          contentPadding:
                              EdgeInsets.symmetric(vertical: 8, horizontal: 8),
                          leading: SizedBox(
                            width: 64,
                            height: 64,
                            child: Image.network(
                              'https://example.com/photo.jpg',
                              fit: BoxFit.cover,
                            ),
                          ),
                          title: Text('Item ${index + 1}'),
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              CustomButton(
                                variant: 'secondary',
                                size: 'small',
                                text: '업로드',
                                onPressed: () {},
                              ),
                              SizedBox(width: 4),
                              CustomButton(
                                variant: 'secondary',
                                size: 'small',
                                text: 'AI 생성',
                                onPressed: () {},
                              ),
                              SizedBox(width: 4),
                              CustomButton(
                                variant: 'secondary',
                                size: 'small',
                                text: '텍스트 변경',
                                onPressed: () {},
                              ),
                            ],
                          ),
                          onTap: () {
                            Navigator.pop(context);
                          },
                        );
                      },
                      separatorBuilder: (context, index) => Divider(
                        color: Colors.grey[300],
                        thickness: 1,
                        height: 1,
                      ),
                    ),
                  );
                },
              );
            },
          ),
          CustomButton(
            variant: 'secondary',
            size: 'small',
            text: "저장",
            leadingIcon: SvgPicture.asset(
              '/icons/download.svg',
              width: 20,
              height: 20,
            ),
            onPressed: () {},
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // WebViewWidget을 사용하여 WebView 로드
              // WebViewWidget(controller: _controller),
              // input 값을 수정하는 버튼
              // ElevatedButton(
              //   onPressed: _updateInputValue,
              //   child: Text("Input 값 수정"),
              // ),

              WebViewWidget(
                controller: _controller,
              ),

              // 🔧 Expanded 제거하고 고정 높이로 변경
              Container(
                height: 300,
                child: _buildViewer(selectedIndex),
              ),
              SizedBox(height: 16),

              Container(
                padding: EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomIconButton(
                      icon: SvgPicture.asset(
                        '/icons/layers.svg',
                        width: 24,
                        height: 24,
                      ),
                      tooltip: "아이콘 버튼 미디엄",
                      backgroundColor: Colors.white,
                      onPressed: () {
                        print('아이콘 버튼이 눌렸습니다!');
                      },
                    ),
                    SizedBox(height: 8),
                    CustomIconButton(
                      icon: SvgPicture.asset(
                        '/icons/image_save.svg',
                        width: 24,
                        height: 24,
                      ),
                      tooltip: "아이콘 버튼 미디엄",
                      backgroundColor: Colors.white,
                      onPressed: () {
                        print('아이콘 버튼이 눌렸습니다!');
                      },
                    ),
                    SizedBox(height: 16),
                    SizedBox(
                      height: 96,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: 8,
                        itemBuilder: (context, index) {
                          return GestureDetector(
                            onTap: () {
                              setState(() {
                                selectedIndex = index;
                              });
                            },
                            child: Container(
                              margin: EdgeInsets.only(right: 8.0),
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: selectedIndex == index
                                      ? Colors.blue
                                      : Colors.red,
                                ),
                                borderRadius: BorderRadius.circular(8.0),
                              ),
                              width: 64,
                              height: 96,
                              child: Center(child: Text('Tab $index')),
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildViewer(int index) {
    return Center(
      child: Text(
        '선택된 뷰어: Tab $index',
        style: TextStyle(fontSize: 24, color: Colors.white),
      ),
    );
  }
}
