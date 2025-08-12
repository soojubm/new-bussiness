import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

// BottomNavigationBar 1.x / NavigationBar 3.0

class CustomNavigationBar extends StatelessWidget {
  final int currentPageIndex;
  final ValueChanged<int> onDestinationSelected;

  const CustomNavigationBar({
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
      // indicatorColor: Colors.amber,
      selectedIndex: currentPageIndex,
      destinations: <Widget>[
        NavigationDestination(
          icon: SvgPicture.asset(
            'assets/icons/template.svg',
            width: 24.0,
            height: 24.0,
            color: currentPageIndex == 0 ? Colors.black : Color(0xFF4F4F4F),
          ),
          label: '템플릿',
        ),
        NavigationDestination(
          icon: SvgPicture.asset(
            'assets/icons/ai.svg',
            width: 24.0,
            height: 24.0,
            color: currentPageIndex == 1 ? Colors.black : Color(0xFF4F4F4F),
          ),
          label: 'AI',
        ),
        NavigationDestination(
          icon: SvgPicture.asset(
            'assets/icons/library.svg',
            width: 24.0,
            height: 24.0,
            color: currentPageIndex == 2 ? Colors.black : Color(0xFF4F4F4F),
          ),
          // icon: Badge(
          //   label: Text('2'),
          //   child: Icon(Icons.person),
          // ),
          label: '라이브러리',
        ),
      ],
    );
  }
}
