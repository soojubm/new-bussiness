import 'package:flutter/material.dart';
import 'screens/splash_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.green),
        useMaterial3: true,
      ),
      debugShowCheckedModeBanner: false,

      routes: <String, WidgetBuilder>{
        // '/': (BuildContext context) {
        //   return Scaffold(appBar: AppBar(title: const Text('Home Route')));
        // },
        '/about': (BuildContext context) {
          return Scaffold(appBar: AppBar(title: const Text('About Route')));
        },
      },
      home: SplashScreen(),
      // home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}
