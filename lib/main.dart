import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/firebase_options.dart';
import 'package:flutter_application_1/screens/components_screen.dart';
import 'package:flutter_application_1/screens/login_screen.dart';
import 'package:flutter_application_1/theme.dart';
import 'screens/splash_screen.dart';
import 'screens/settings_screen.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

// guides
// 1차에서는 tokenize 하지 않고 themeData에서 바로 사용해 본다.
// colorScheme이이 MD3 방식.

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  ); // Firebase 초기화
  runApp(MyApp());
}

void getData() async {
  FirebaseFirestore db = FirebaseFirestore.instance; // Firestore 인스턴스

  // 'users' 컬렉션에서 모든 문서 가져오기
  QuerySnapshot querySnapshot = await db.collection('users').get();

  // 각 문서의 데이터 출력
  for (var doc in querySnapshot.docs) {
    print(doc.data()); // 문서의 데이터를 출력
  }
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

      initialRoute:
          FirebaseAuth.instance.currentUser != null ? '/components' : '/login',
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
        '/components': (BuildContext context) {
          return ComponentsScreen();
        },
        // '/': (context) => LoginScreen(), // 로그인 페이지
      },
      home: SplashScreen(),
      // home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}
