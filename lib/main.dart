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

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform)
      .then((value) {
    Get.put(AuthenticationRepository());
    Get.put(UserRepository());
    Get.put(CartRepository());
  });

  Stripe.publishableKey =
      "pk_test_51OOsGHH2s1vVpFNUg2iBVoqB8yAXHoFt5BPCErrPb1GkdBz58hGmof0AlfbrhugQ9jcHtrEHu7EvT8bvWqgabBpn00aoukvZe2";
  Stripe.instance.applySettings();
  
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
