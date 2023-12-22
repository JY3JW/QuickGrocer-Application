import 'package:flutter/material.dart';
import 'package:quickgrocer_application/src/constants/colors.dart';
import 'package:quickgrocer_application/src/features/core/screens/feedback/seller_view_feedback_screen.dart';
import 'package:quickgrocer_application/src/features/core/screens/grocery/manage_grocery_screen.dart';
import 'package:quickgrocer_application/src/features/core/screens/order/manage_order_screen.dart';
import 'package:quickgrocer_application/src/features/core/screens/profile/seller_profile_screen.dart';

class SellerDashboard extends StatefulWidget {
  const SellerDashboard({super.key});

  @override
  State<SellerDashboard> createState() => _SellerDashboardState();
}

class _SellerDashboardState extends State<SellerDashboard> {
  int _selectedIndex = 0;

  static List<Widget> _widgetOptions = <Widget>[
    SafeArea(
      child: ManageGroceryScreen(),
    ),
    SafeArea(
      child: ManageOrderScreen(),
    ),
    SafeArea(
      child: ViewFeedbackScreen(),
    ),
    SafeArea(
      child: SellerProfileScreen(),
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
            activeIcon: Icon(Icons.local_grocery_store),
            icon: Icon(Icons.local_grocery_store_outlined),
            label: 'Grocery',
            backgroundColor: AppColors.mainPineColor,
          ),
          BottomNavigationBarItem(
            activeIcon: Icon(Icons.note_alt),
            icon: Icon(Icons.note_alt_outlined),
            label: 'Order',
            backgroundColor: AppColors.mainPineColor,
          ),
          BottomNavigationBarItem(
            activeIcon: Icon(Icons.grade),
            icon: Icon(Icons.grade_outlined),
            label: 'Feedback',
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
