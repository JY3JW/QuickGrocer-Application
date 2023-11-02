import 'package:flutter/material.dart';
import 'package:quickgrocer_application/home/main_grocery_page.dart';
import 'package:quickgrocer_application/home/testingDatabaseConnection.dart';
import 'package:quickgrocer_application/utils/colors.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: AppColors.mainPineColor),
        useMaterial3: true,
      ),
      home: const UserDetailsPage(),
    );
  }
}
