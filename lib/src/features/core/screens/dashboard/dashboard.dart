import 'package:flutter/material.dart';
import 'package:quickgrocer_application/src/constants/colors.dart';
import 'package:quickgrocer_application/src/features/core/screens/grocery/browse_grocery_screen.dart';
import 'package:quickgrocer_application/src/features/core/screens/order/view_order_status.dart';
import 'package:quickgrocer_application/src/features/core/screens/profile/profile_screen.dart';
import 'package:quickgrocer_application/src/features/core/screens/shopping_cart/shopping_cart_screen.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  int _selectedIndex = 0;

  static List<Widget> _widgetOptions = <Widget>[
    SafeArea(
      child: BrowseGroceryScreen(),
    ),
    SafeArea(
      child: ShoppingCartScreen(), // cart screen
    ),
    SafeArea(
      child: ViewOrderStatusScreen(), // order history screen
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
            activeIcon: Icon(Icons.local_grocery_store),
            icon: Icon(Icons.local_grocery_store_outlined),
            label: 'Cart',
            backgroundColor: AppColors.mainPineColor,
          ),
          BottomNavigationBarItem(
            activeIcon: Icon(Icons.note_alt),
            icon: Icon(Icons.note_alt_outlined),
            label: 'Order',
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
