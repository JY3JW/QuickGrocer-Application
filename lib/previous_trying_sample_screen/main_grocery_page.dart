import 'package:flutter/material.dart';
import 'package:quickgrocer_application/src/constants/colors.dart';

class MainGroceryPage extends StatefulWidget {
  const MainGroceryPage({super.key});

  @override
  State<MainGroceryPage> createState() => _MainGroceryPageState();
}

class _MainGroceryPageState extends State<MainGroceryPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column (
        children: [
          Container(
            
            child: Container(
              margin: EdgeInsets.only(top: 45, bottom: 15),
              padding: EdgeInsets.only(left: 20, right: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    children: [
                      Text("Welcome"),
                      Text("Find and order your groceries here 🛍️"),
                    ],
                  ),
                  Center(
                    child: Container(
                      width: 45,
                      height: 45,
                      child: Icon(Icons.search, color: AppColors.greyColor2),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: AppColors.greyColor1, 
                        border: Border.all(
                          color: AppColors.greyColor2,
                          width: 2,
                        )
                      ),
                    )
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}