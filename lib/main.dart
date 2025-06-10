import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/firebase_options.dart';
import 'package:flutter_application_1/screens/ai_screen.dart';
import 'package:flutter_application_1/screens/components_screen.dart';
import 'package:flutter_application_1/screens/faqs_screen.dart';
import 'package:flutter_application_1/screens/login_screen.dart';
import 'package:flutter_application_1/screens/notifications_screen.dart';
import 'package:flutter_application_1/screens/signup_screen.dart';
import 'package:flutter_application_1/theme.dart';
import 'package:flutter_application_1/widgets/custom_app_bar.dart';
import 'screens/splash_screen.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

// ProviderScope
import 'package:flutter_riverpod/flutter_riverpod.dart';

// @riverpod
import 'package:riverpod_annotation/riverpod_annotation.dart';
part 'main.g.dart';

// guides
// 1차에서는 tokenize 하지 않고 themeData에서 바로 사용해 본다.
// colorScheme이이 MD3 방식.

const double horizontalPadding = 24.0;

@riverpod
String helloWorld(Ref ref) {
  return 'Hello world';
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  ); // Firebase 초기화

  // riverpod
  runApp(
    ProviderScope(
      child: MyApp(),
    ),
  );
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

// riverpod ConsumerWidget
class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: lightTheme,
      darkTheme: darkTheme,
      themeMode: ThemeMode.system,
      debugShowCheckedModeBanner: false,

      // initialRoute:
      //     FirebaseAuth.instance.currentUser != null ? '/components' : '/components',
      // initialRoute: '/ai',
      routes: <String, WidgetBuilder>{
        // '/': (BuildContext context) {
        //   return Scaffold(appBar: CustomAppBar(title: const Text('Home Route')));
        // },
        '/about': (BuildContext context) {
          return Scaffold(appBar: CustomAppBar(title: 'About Route'));
        },
        '/login': (BuildContext context) {
          return LoginScreen();
        },
        '/signin': (BuildContext context) {
          return LoginScreen();
        },
        '/signup': (BuildContext context) {
          return SignUpScreen();
        },
        '/components': (BuildContext context) {
          return ComponentsScreen();
        },
        '/faqs': (BuildContext context) {
          return FAQsScreen();
        },
        '/ai': (BuildContext context) {
          return AIScreen();
        },
        '/settings': (BuildContext context) {
          return SettingsTestScreen();
        },
        // '/': (context) => LoginScreen(), // 로그인 페이지
      },
      home: SplashScreen(),
      // home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}
