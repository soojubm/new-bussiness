import 'package:flutter/material.dart';
import 'package:flutter_application_1/screens/login_screen.dart';
import 'package:flutter_application_1/theme.dart';
import 'screens/splash_screen.dart';
import 'screens/settings_screen.dart';

// guides
// 1차에서는 tokenize 하지 않고 themeData에서 바로 사용해 본다.
// colorScheme이이 MD3 방식.

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: lightTheme,
      darkTheme: darkTheme,
      themeMode: ThemeMode.system,
      debugShowCheckedModeBanner: false,

      initialRoute: '/',
      routes: <String, WidgetBuilder>{
        // '/': (BuildContext context) {
        //   return Scaffold(appBar: AppBar(title: const Text('Home Route')));
        // },
        '/about': (BuildContext context) {
          return Scaffold(appBar: AppBar(title: const Text('About Route')));
        },
        '/login': (BuildContext context) {
          return LoginScreen();
        },
        // '/': (context) => LoginScreen(), // 로그인 페이지
      },
      home: SplashScreen(),
      // home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}
