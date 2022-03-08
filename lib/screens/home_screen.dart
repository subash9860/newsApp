import 'package:flutter/material.dart';

import '../screens/user_profile.dart';
import '../screens/posts_screen.dart';
import '../screens/user_list.dart';
import '../constants/colors.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int index = 0;

  final screens = const [
    PostsScreen(),
    UserList(),
    UserProfile(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: NavigationBarTheme(
        data: NavigationBarThemeData(
          indicatorColor: kPrimary,
          labelTextStyle: MaterialStateProperty.all<TextStyle>(
            const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        child: NavigationBar(
          height: 60,
          backgroundColor: Colors.lightBlue[70],
          labelBehavior: NavigationDestinationLabelBehavior.onlyShowSelected,
          animationDuration: const Duration(milliseconds: 1200),
          selectedIndex: index,
          onDestinationSelected: (int index) {
            setState(() {
              this.index = index;
            });
          },
          destinations: const [
            NavigationDestination(
              selectedIcon: Icon(Icons.home),
              icon: Icon(Icons.home_outlined),
              label: "Home",
            ),
            NavigationDestination(
              selectedIcon: Icon(Icons.people),
              icon: Icon(Icons.people_outlined),
              label: "Users",
            ),
            NavigationDestination(
              // tooltip: "User Details",
              selectedIcon: Icon(Icons.person),
              icon: Icon(Icons.person_outlined),
              label: "Profile",
            ),
          ],
        ),
      ),
      body: screens[index],
    );
  }
}
