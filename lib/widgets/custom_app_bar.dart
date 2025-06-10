import 'package:flutter/material.dart';
import 'package:flutter_application_1/widgets/custom_avatar.dart';
import 'package:flutter_application_1/widgets/custom_text.dart';
// import 'package:url_launcher/url_launcher.dart';

enum AppBarVariant { menu, up }

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final AppBarVariant variant;
  final VoidCallback? onMenuPressed;
  final VoidCallback? onBackPressed;
  final List<Widget>? actions;
  final String colorMode;

  const CustomAppBar({
    Key? key,
    required this.title,
    this.variant = AppBarVariant.up,
    this.onMenuPressed,
    this.onBackPressed,
    this.actions,
    this.colorMode = 'light',
  }) : super(key: key);

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    final isMenu = variant == AppBarVariant.menu;

    return AppBar(
      backgroundColor: colorMode == 'dark'
          ? Colors.black
          : Theme.of(context).appBarTheme.backgroundColor,
      automaticallyImplyLeading: false,
      centerTitle: isMenu,
      leading: isMenu
          ? IconButton(
              icon: const Icon(Icons.menu),
              color: colorMode == 'dark' ? Colors.white : Colors.black,
              onPressed: () {
                // 메뉴 아이콘을 눌렀을 때 새로운 화면을 Navigator로 띄우기
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (BuildContext context) {
                      return MenuScreen();
                    },
                  ),
                );
              },
            )
          : IconButton(
              icon: const Icon(Icons.arrow_back),
              color: colorMode == 'dark' ? Colors.white : Colors.black,
              onPressed:
                  onBackPressed ?? () => Navigator.of(context).maybePop(),
            ),
      title: Align(
        alignment: isMenu ? Alignment.center : Alignment.centerLeft,
        child: Text(
          title,
          style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
        ),
      ),
      actions: actions,
    );
  }
}

// CouponItem 모델 클래스
class CouponItem {
  final String text;
  final String link;

  CouponItem({required this.text, required this.link});
}

class MenuScreen extends StatelessWidget {
  final List<CouponItem> couponItems = [
    CouponItem(text: '고객센터', link: 'https://example.com/1'),
    CouponItem(text: '공지사항', link: 'https://example.com/2'),
    CouponItem(text: '자주 묻는 질문', link: 'https://example.com/3'),
    CouponItem(text: '쉬운 가이드', link: 'https://example.com/3'),
    CouponItem(text: '약관 및 정책', link: 'https://example.com/3'),
    CouponItem(text: '앱 설정', link: 'https://example.com/3'),
  ];

  // URL을 열기 위한 함수
  // Future<void> _launchURL(String url) async {
  //   if (await canLaunch(url)) {
  //     await launch(url);
  //   } else {
  //     throw 'Could not launch $url';
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
            icon: Icon(Icons.notifications),
            onPressed: () {
              print('Notifications pressed');
            },
          ),
          IconButton(
            icon: Icon(Icons.close), // 닫기 아이콘
            onPressed: () {
              // 닫기 버튼을 눌렀을 때 동작할 코드
              print('Close button pressed');
              // 예를 들어 현재 화면을 닫으려면 Navigator.pop(context) 사용
              Navigator.pop(context); // 현재 화면을 닫기
            },
          ),
        ],
      ),
      body: ListView(
        padding: EdgeInsets.symmetric(horizontal: 20.0),
        children: [
          ListTile(
            contentPadding: EdgeInsets.zero,
            leading: CustomAvatar(
              size: 'large',
              imageUrl: '',
            ),
            title: CustomText(variant: 'h4', text: '반가워요!'),
            subtitle: CustomText(variant: 'label2', text: '로그인하고 혜택받기'),
            onTap: () {
              // Navigator.push(
              //     context, MaterialPageRoute(builder: (context) => ));
              print('');
            },
          ),

          SizedBox(height: 40.0),

          Container(
            width: double.infinity,
            padding: EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Color(0xFF525E68),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start, // Column 내에서 왼쪽 정렬
              children: [
                Text(
                  '전문가의 ....상품 홍보를 위한 모든 것, 구독관리 버튼 안나옴\nAI가 도와드려요. 텍스트 써야 함, 구독 안할 시 나오게',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.left, // 텍스트 왼쪽 정렬
                ),
                Container(
                  width: double.infinity,
                  height: 48,
                  margin: EdgeInsets.only(top: 60),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      padding:
                          EdgeInsets.symmetric(horizontal: 32, vertical: 12),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      // elevation: 5,
                    ),
                    onPressed: () {
                      print('배너 버튼 클릭됨');
                    },
                    child: Text('더 알아보기'),
                  ),
                ),
              ],
            ),
          ),

          SizedBox(height: 40.0),

          // 다른 메뉴 항목 추가
          CustomText(variant: 'label2', text: '혜택 정보'),
          SizedBox(height: 8.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Expanded(
                flex: 1,
                child: Container(
                  height: 32,
                  child: CustomText(variant: 'label1bold', text: '진행 중인 이벤트'),
                ),
              ),
              Expanded(
                flex: 1,
                child: Container(
                  height: 32,
                  child: CustomText(variant: 'label1bold', text: '쿠폰 등록'),
                ),
              ),
            ],
          ),

          SizedBox(height: 40.0),

          CustomText(variant: 'label2', text: '혜택 정보'),
          SizedBox(height: 8.0),
          Container(
            height: 100, // 높이 지정
            child: GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2, // 한 줄에 2개의 항목을 배치 (50% 너비)
                crossAxisSpacing: 24.0, // 항목 간의 수평 간격
                mainAxisSpacing: 8.0, // 항목 간의 수직 간격
              ),
              itemCount: 3, // 항목 수
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    // 클릭 시 해당 링크로 이동
                    // _launchURL(couponItems[index].link);
                  },
                  child: Container(
                    child: CustomText(
                      variant: 'label1bold',
                      text: couponItems[index].text, // 고정된 텍스트 사용
                    ),
                  ),
                );
              },
            ),
          ),

          CustomText(
              text: 'Ⓒ 2025. Insplanet all right reserved.', variant: 'label3')
        ],
      ),
    );
  }
}
