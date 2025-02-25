import 'package:flutter/material.dart';

class SettingsPage extends StatefulWidget {
  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  bool _isNotificationsEnabled = true;
  bool _isDarkMode = false;
  double _volume = 0.5;
  String _language = 'English';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Settings'),
      ),
      body: ListView(
        padding: EdgeInsets.all(16.0),
        children: [
          // Notifications Setting
          ListTile(
            title: Text('Enable Notifications'),
            trailing: Switch(
              value: _isNotificationsEnabled,
              onChanged: (value) {
                setState(() {
                  _isNotificationsEnabled = value;
                });
              },
            ),
          ),

          // Dark Mode Setting
          ListTile(
            title: Text('Dark Mode'),
            trailing: Switch(
              value: _isDarkMode,
              onChanged: (value) {
                setState(() {
                  _isDarkMode = value;
                });
              },
            ),
          ),

          // Volume Setting (Slider)
          ListTile(
            title: Text('Volume'),
            subtitle: Text('Volume: ${(_volume * 100).toStringAsFixed(0)}%'),
            trailing: Slider(
              value: _volume,
              min: 0.0,
              max: 1.0,
              onChanged: (value) {
                setState(() {
                  _volume = value;
                });
              },
            ),
          ),

          // Language Setting (Dropdown)
          ListTile(
            title: Text('Language'),
            subtitle: Text('Current language: $_language'),
            trailing: DropdownButton<String>(
              value: _language,
              onChanged: (String? newValue) {
                setState(() {
                  _language = newValue!;
                });
              },
              items: <String>['English', 'Spanish', 'French', 'German']
                  .map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            ),
          ),

          // Reset Settings Button
          ElevatedButton(
            onPressed: () {
              setState(() {
                _isNotificationsEnabled = true;
                _isDarkMode = false;
                _volume = 0.5;
                _language = 'English';
              });
            },
            child: Text('Reset Settings'),
          ),
        ],
      ),
    );
  }
}
