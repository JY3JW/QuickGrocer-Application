import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:get/get.dart';
import 'package:quickgrocer_application/src/features/authentication/screens/welcome/welcome_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:quickgrocer_application/src/repository/authentication_repository/authentication_repository.dart';
import 'package:quickgrocer_application/src/repository/cart_repository/cart_repository.dart';
import 'package:quickgrocer_application/src/repository/user_repository/user_repository.dart';
import 'package:quickgrocer_application/src/utils/theme/theme.dart';
import 'firebase_options.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform)
      .then((value) {
    Get.put(AuthenticationRepository());
    Get.put(UserRepository());
    Get.put(CartRepository());
  });

  WidgetsFlutterBinding.ensureInitialized();
  Stripe.publishableKey =
      "pk_live_51OOsGHH2s1vVpFNUw1bqdXg1tuCKZ3dYKG2iKnFW6LGazdEf6Uozt8uw6oj58hR81TFtwXGxdSh1wsivXV3NEqNK00XnFVBs2T";
  
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: ThemeMode.system,
      home: const WelcomeScreen(),
    );
  }
}
