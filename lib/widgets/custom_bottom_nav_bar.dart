import 'package:flutter/material.dart';

class CustomBottomNavBar extends StatelessWidget {
  final int currentPageIndex;
  final ValueChanged<int> onDestinationSelected;

  const CustomBottomNavBar({
    Key? key,
    required this.currentPageIndex,
    required this.onDestinationSelected,
  }) : super(key: key);

  // bottomNavigationBar: BottomNavigationBar(
  //   items: const <BottomNavigationBarItem>[
  //     BottomNavigationBarItem(
  //       icon: Icon(Icons.home),
  //       label: 'Home',
  //     ),
  //     BottomNavigationBarItem(
  //       icon: Icon(Icons.business),
  //       label: 'Business',
  //     ),
  //   ],
  //   currentIndex: _selectedIndex,
  //   // selectedItemColor: Colors.amber[800],
  //   onTap: _onItemTapped,
  // ),

  @override
  Widget build(BuildContext context) {
    return NavigationBar(
      onDestinationSelected: onDestinationSelected,
      indicatorColor: Colors.amber,
      selectedIndex: currentPageIndex,
      destinations: const <Widget>[
        NavigationDestination(
          selectedIcon: Icon(Icons.home),
          icon: Icon(Icons.home_outlined),
          label: 'Home',
        ),
        NavigationDestination(
          icon: Badge(child: Icon(Icons.notifications_sharp)),
          label: 'Notifications',
        ),
        NavigationDestination(
          icon: Badge(
            label: Text('2'),
            child: Icon(Icons.messenger_sharp),
          ),
          label: 'Messages',
        ),
        NavigationDestination(
          icon: Badge(
            child: Icon(Icons.person),
          ),
          label: '마이페이지',
        ),
      ],
    );
  }
}
