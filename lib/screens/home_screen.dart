import 'package:flutter/material.dart';
import 'package:flutter_application_1/widgets/custom_bottom_nav_bar.dart';

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
  int _counter = 0;

  String selectedPage = '';

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  // bottomNavigationBar state
  // int _selectedIndex = 0;
  // void _onItemTapped(int index) {
  //   setState(() {
  //     _selectedIndex = index;
  //   });
  // }
  int currentPageIndex = 0;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        // leading: Padding(
        //   padding: const EdgeInsets.all(8.0),
        //   child: Image.asset('assets/logo.png'), // 로고 이미지 (로컬 파일)
        // ),
        title: Row(
          children: [
            Image.asset('assets/logo.png', height: 40),
            SizedBox(width: 10),
            Text(widget.title),
          ],
        ),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
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
              // 페이지 이동
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

      body: <Widget>[
        Card(
          shadowColor: Colors.transparent,
          margin: const EdgeInsets.all(8.0),
          child: SizedBox.expand(
            child: Center(
              child: Text(
                'Home page',
                style: theme.textTheme.titleLarge,
              ),
            ),
          ),
        ),

        /// Notifications page
        const Padding(
          padding: EdgeInsets.all(8.0),
          child: Column(
            children: <Widget>[
              Card(
                child: ListTile(
                  leading: CircleAvatar(
                    // backgroundColor: Color,
                    child: const Text('CJ'),
                  ),
                  title: Text('이창준'),
                  subtitle: Text('벤치마킹 참고자료 공유 드라이브에 올려놨어요.'),
                ),
              ),
              Card(
                child: ListTile(
                  leading: Icon(Icons.notifications_sharp),
                  title: Text('Notification 2'),
                  subtitle: Text('This is a notification'),
                ),
              ),
            ],
          ),
        ),

        /// Messages page
        ListView.builder(
          reverse: true,
          itemCount: 2,
          itemBuilder: (BuildContext context, int index) {
            if (index == 0) {
              return Align(
                alignment: Alignment.centerRight,
                child: Container(
                  margin: const EdgeInsets.all(8.0),
                  padding: const EdgeInsets.all(8.0),
                  decoration: BoxDecoration(
                    color: theme.colorScheme.primary,
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  child: Text(
                    'Hello',
                    style: theme.textTheme.bodyLarge!
                        .copyWith(color: theme.colorScheme.onPrimary),
                  ),
                ),
              );
            }
            return Align(
              alignment: Alignment.centerLeft,
              child: Container(
                margin: const EdgeInsets.all(8.0),
                padding: const EdgeInsets.all(8.0),
                decoration: BoxDecoration(
                  color: theme.colorScheme.primary,
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: Text(
                  'Hi!',
                  style: theme.textTheme.bodyLarge!
                      .copyWith(color: theme.colorScheme.onPrimary),
                ),
              ),
            );
          },
        ),

        // 프로필
        Padding(
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
