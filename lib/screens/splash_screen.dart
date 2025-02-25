import 'package:flutter/material.dart';
import 'home_screen.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _navigateToHome();
  }

  // 일정 시간 후 HomeScreen으로 이동
  _navigateToHome() async {
    await Future.delayed(Duration(seconds: 1)); // 3초 후
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => HomeScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue, // 배경색
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('assets/images/splash.png'), // 이미지
            SizedBox(height: 20),
            CircularProgressIndicator(), // 로딩 애니메이션
          ],
        ),
      ),
    );
  }
}
