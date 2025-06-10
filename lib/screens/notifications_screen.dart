import 'package:flutter/material.dart';
import 'package:flutter_application_1/main.dart';
import 'package:flutter_application_1/widgets/custom_app_bar.dart';
import 'package:flutter_application_1/widgets/custom_button.dart';
import 'package:flutter_application_1/widgets/custom_text.dart';

class NotificationsScreen extends StatefulWidget {
  @override
  _NotificationsScreenState createState() => _NotificationsScreenState();
}

class _NotificationsScreenState extends State<NotificationsScreen> {
  bool _isNotificationsEnabled = true;
  bool _isDarkMode = false;
  double _volume = 0.5;
  String _language = 'English';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: 'Settings',
      ),
      body: ListView(children: [
        ListTile(
          leading: CircleAvatar(
            // backgroundColor: Color,
            child: const Text('CJ'),
          ),
          title: Text('이창준'),
          subtitle: Text('벤치마킹 참고자료 공유 드라이브에 올려놨어요.'),
          onTap: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => SettingsTestScreen()));
            print('');
          },
        ),
        ListTile(
          leading: Icon(Icons.notifications_sharp),
          title: Text('Notification 2'),
          subtitle: Text('This is a notification'),
        ),
        // Card(
        //   child: ListTile(
        //     leading: Icon(Icons.notifications_sharp),
        //     title: Text('Notification 2'),
        //     subtitle: Text('This is a notification'),
        //   ),
        // ),
      ]),
    );
  }
}

class SettingsTestScreen extends StatefulWidget {
  @override
  _SettingsTestScreenState createState() => _SettingsTestScreenState();
}

class _SettingsTestScreenState extends State<SettingsTestScreen> {
  bool _emailNotifications = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: 'Settings',
      ),
      body: ListView(children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 20.0),
            Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: horizontalPadding), // 좌우 패딩 추가
              child: CustomText(
                variant: 'label1',
                text: '기기의 알림 설정이 꺼져있어요',
              ),
            ),
            SizedBox(height: 8.0),
            Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: horizontalPadding), // 좌우 패딩 추가
              child: CustomText(
                variant: 'label1',
                text: '인셋에서 드리는 알림을 받아보시려면\n기기의 알림 설정에서 인셋 알림을 켜주세요.',
              ),
            ),
            SizedBox(height: 20.0),
            Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: horizontalPadding), // 좌우 패딩 추가
              child: CustomButton(
                  size: 'small', text: '기기 알림 켜기', onPressed: () {}),
            ),
            SizedBox(height: 24.0),
          ],
        ),
        SizedBox(height: 56.0),
        SwitchListTile(
          contentPadding: EdgeInsets.symmetric(horizontal: horizontalPadding),
          title: CustomText(
            variant: 'label1',
            text: '이메일 알림',
          ),
          subtitle: CustomText(
            variant: 'label2',
            text: '서비스 이용에 필요한 안내 사항을 알려드려요.' '이메일 알림을 받으시겠습니까?',
          ),
          value: _emailNotifications,
          onChanged: (bool value) {
            setState(() {
              _emailNotifications = value;
            });
          },
        ),
        SwitchListTile(
          contentPadding: EdgeInsets.symmetric(horizontal: horizontalPadding),
          title: CustomText(
            variant: 'label1',
            text: '혜택 알림',
          ),
          subtitle: CustomText(
            variant: 'label2',
            text: '인셋의 다양한 소식와 혜택 정보를 알려드려요.',
          ),
          value: _emailNotifications,
          onChanged: (bool value) {
            setState(() {
              _emailNotifications = value;
            });
          },
        ),
        ListTile(
          contentPadding: EdgeInsets.symmetric(horizontal: horizontalPadding),
          title: CustomText(
            variant: 'label1',
            text: '앱 버전',
          ),
          subtitle: CustomText(
            variant: 'label2',
            text: '최신버전 사용중',
          ),
          trailing: CustomText(
            variant: 'label2',
            text: 'v1.42.0',
          ),
        ),
      ]),
    );
  }
}
