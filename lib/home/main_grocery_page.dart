import 'package:flutter/material.dart';

class MainGroceryPage extends StatefulWidget {
  const MainGroceryPage({super.key});

  @override
  State<MainGroceryPage> createState() => _MainGroceryPageState();
}

class _MainGroceryPageState extends State<MainGroceryPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Container(
        child: Row(
          children: [
            Row(
              children: [
                Text("Welcome"),
                Text("Find and order your groceries here 🛍️"),
              ],
            ),
            Container(
              width: 45,
              height: 45,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                color: Colors.grey, 
              ),
            )
          ],
        ),
      ),
    );
  }
}