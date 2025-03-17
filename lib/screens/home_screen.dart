import 'package:flutter/material.dart';
import 'package:flutter_application_1/providers/test_provider.dart';
import 'package:flutter_application_1/screens/messages_screen.dart';
import 'package:flutter_application_1/screens/notifications_screen.dart';
import 'package:flutter_application_1/screens/profile_screen.dart';
import 'package:flutter_application_1/widgets/custom_bottom_nav_bar.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
// class HomeScreen extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text('Home Screen')),
//       body: Center(child: Text('Welcome to Home Screen')),
//     );
//   }
// }

class HomeScreen extends StatefulWidget {
  // const HomeScreen({super.key, required this.title});
  const HomeScreen({super.key, this.title = "home screen"});

  final String title;

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final FirebaseFirestore db = FirebaseFirestore.instance;
  int currentPageIndex = 0;

  // Firestore에서 데이터를 가져오는 메서드
  Future<List<Map<String, dynamic>>> getData() async {
    try {
      QuerySnapshot querySnapshot = await db.collection('product').get();

      // 각 문서에서 데이터를 가져오기
      List<Map<String, dynamic>> usersList = [];
      for (var doc in querySnapshot.docs) {
        usersList.add(doc.data() as Map<String, dynamic>);
      }
      return usersList;
    } catch (e) {
      print('Error occurred: $e');
      return [];
    }
  }

  int _counter = 0;

  String selectedPage = '';

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  List _pages = [
    NotificationsScreen(),
  ];

  // bottomNavigationBar state
  // int _selectedIndex = 0;
  // void _onItemTapped(int index) {
  //   setState(() {
  //     _selectedIndex = index;
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        // leading: Padding(
        //   padding: const EdgeInsets.all(8.0),
        //   child: Image.asset('assets/logo.png'), // 로고 이미지 (로컬 파일)
        // )
        // ,
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Row(
          children: [
            Image.asset('assets/logo.png', height: 40),
            SizedBox(width: 10),
            Text(widget.title),
          ],
        ),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.add_alert),
            tooltip: 'Show Snackbar',
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('This is a snackbar')));
            },
          ),
          IconButton(
            icon: const Icon(Icons.navigate_next),
            tooltip: 'Go to the next page',
            onPressed: () {
              Navigator.push(context, MaterialPageRoute<void>(
                builder: (BuildContext context) {
                  return Scaffold(
                    appBar: AppBar(
                      title: const Text('Next page'),
                    ),
                    body: const Center(
                      child: Text('This is the next page'),
                    ),
                  );
                },
              ));
            },
          ),
        ],
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            const DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
              child: Text(
                'Drawer Header',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                ),
              ),
            ),
            ListTile(
              leading: const Icon(Icons.account_circle),
              title: const Text('로그인 샘플러'),
              onTap: () {
                Navigator.pushNamed(context, '/login');
                setState(() {
                  selectedPage = 'Profile';
                });
              },
            ),
            ListTile(
              leading: const Icon(Icons.account_circle),
              title: const Text('회원가입'),
              onTap: () {
                Navigator.pushNamed(context, '/signup');
                setState(() {
                  selectedPage = 'Profile';
                });
              },
            ),
            ListTile(
              leading: const Icon(Icons.account_circle),
              title: const Text('컴포넌트'),
              onTap: () {
                Navigator.pushNamed(context, '/components');
                setState(() {
                  selectedPage = 'Profile';
                });
              },
            ),
            ListTile(
              leading: const Icon(Icons.settings),
              title: const Text('Settings'),
              onTap: () {
                setState(() {
                  selectedPage = 'Settings';
                  // context는 어디에서 온 것?
                  // Navigator.pop(context);
                });
              },
            ),
          ],
        ),
      ),

      body: [
        FutureBuilder<List<Map<String, dynamic>>>(
          future: getData(), // 데이터를 가져오는 메서드 호출
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text("Error: ${snapshot.error}"));
            } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return Center(child: Text("No data found"));
            } else {
              // 데이터를 가져오고 화면에 표시
              List<Map<String, dynamic>> users = snapshot.data!;
              return ListView.builder(
                itemCount: users.length,
                itemBuilder: (context, index) {
                  var user = users[index];
                  return ListTile(
                    title: Text(user['price'].toString() ?? 'No name'),
                    subtitle: Text('createdAt: ${user['createdAt']}'),
                  );
                },
              );
            }
          },
        ),
        NotificationsScreen(),
        MessagesScreen(),
        ProfileScreen()
      ][currentPageIndex],

      // );
      //   body: Center(
      //     child: Column(
      //       mainAxisAlignment: MainAxisAlignment.center,
      //       children: <Widget>[
      //         const Text(
      //           'You have pushed the button this many times:',
      //         ),
      //         Text(
      //           '$_counter',
      //           style: Theme.of(context).textTheme.headlineMedium,
      //         ),
      //         Text('Page: $selectedPage')
      //       ],
      //     ),
      //   ),

      bottomNavigationBar: CustomBottomNavBar(
        currentPageIndex: currentPageIndex,
        onDestinationSelected: (int index) {
          setState(() {
            currentPageIndex = index;
          });
        },
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}
