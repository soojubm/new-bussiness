import 'package:flutter/material.dart';

class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    return Scaffold(
      body: Padding(
          padding: EdgeInsets.all(16.0),
          child: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                CircleAvatar(
                  // backgroundColor: Color,
                  radius: 40.0,
                  child: const Text('CJ', style: TextStyle(fontSize: 32)),
                ),
                SizedBox(height: 4.0), // CircleAvatar와 Text 사이의 간격을 16.0으로 설정
                Text(
                  '이창준',
                  style: TextStyle(
                    fontSize: 22,
                  ),
                ),
                Image.asset('images/food.png'),
              ],
            ),
          )),
    );
  }
}
