import 'package:flutter/material.dart';
import 'package:quickgrocer_application/src/constants/colors.dart';
import 'package:quickgrocer_application/src/features/core/screens/admin/manage_user/manage_user_screen.dart';
import 'package:quickgrocer_application/src/features/core/screens/grocery/browse_grocery_screen.dart';
import 'package:quickgrocer_application/src/features/core/screens/grocery/manage_grocery_screen.dart';
import 'package:quickgrocer_application/src/features/core/screens/profile/profile_screen.dart';

class AdminDashboard extends StatefulWidget {
  const AdminDashboard({super.key});

  @override
  State<AdminDashboard> createState() => _AdminDashboardState();
}

class _AdminDashboardState extends State<AdminDashboard> {
  int _selectedIndex = 0;
  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold);

  static List<Widget> _widgetOptions = <Widget>[
    SafeArea(
      //child: BrowseGroceryScreen(),
      child: Text(
        'Index 0: xx',
        style: optionStyle,
      ),
    ),
    SafeArea(
      //child: ManageGroceryScreen(),
      child: Text(
        'Index 1: xx',
        style: optionStyle,
      ),
    ),
    SafeArea(
      //child: ManageUserScreen(),
      child: Text(
        'Index 2: xx',
        style: optionStyle,
      ),
    ),
    SafeArea(
      child: ProfileScreen(),
    ),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            activeIcon: Icon(Icons.home),
            icon: Icon(Icons.home_outlined),
            label: 'Home',
            backgroundColor: AppColors.mainPineColor,
          ),
          BottomNavigationBarItem(
            activeIcon: Icon(Icons.note_alt),
            icon: Icon(Icons.note_alt_outlined),
            label: 'Grocery',
            backgroundColor: AppColors.mainPineColor,
          ),
          BottomNavigationBarItem(
            activeIcon: Icon(Icons.people_alt_rounded),
            icon: Icon(Icons.people_outline_outlined),
            label: 'User',
            backgroundColor: AppColors.mainPineColor,
          ),
          BottomNavigationBarItem(
            activeIcon: Icon(Icons.account_circle),
            icon: Icon(Icons.account_circle_outlined),
            label: 'Profile',
            backgroundColor: AppColors.mainPineColor,
          ),
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
    );
  }
}
