import 'package:flutter/material.dart';
import 'package:flutter_application_1/widgets/custom_app_bar.dart';

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
        SwitchListTile(
          title: const Text('이메일 알림'),
          value: _emailNotifications,
          onChanged: (bool value) {
            setState(() {
              _emailNotifications = value;
            });
          },
        ),
        SwitchListTile(
          title: Text('test'),
          value: _emailNotifications,
          onChanged: (bool value) {
            setState(() {
              _emailNotifications = value;
            });
          },
        ),
      ]),
    );
  }
}
