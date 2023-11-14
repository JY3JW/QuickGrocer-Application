import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:quickgrocer_application/src/constants/sizes.dart';
import 'package:quickgrocer_application/src/constants/text_strings.dart';
import 'package:quickgrocer_application/src/features/authentication/controllers/mail_verification_controller.dart';
import 'package:quickgrocer_application/src/repository/authentication_repository/authentication_repository.dart';

class MailVerificationScreen extends StatelessWidget {
  const MailVerificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(MailVerificationController());
    return SafeArea(
      child: Scaffold(
          body: SingleChildScrollView(
              child: Padding(
                  padding: const EdgeInsets.all(defaultSize),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Icon(LineAwesomeIcons.envelope_open, size: 100),
                      const SizedBox(height: defaultSize * 2),
                      Text(emailVerificationTitle,
                          style: Theme.of(context).textTheme.headlineMedium),
                      const SizedBox(height: defaultSize),
                      Text(
                        emailVerificationSubtitle,
                        style: Theme.of(context).textTheme.bodyMedium,
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: defaultSize * 2),
                      SizedBox(
                        width: 200,
                        child: OutlinedButton(
                            child: Text(continueEmailVerification),
                            onPressed: () => controller
                                .manuallyCheckEmailVerificationStatus()),
                      ),
                      const SizedBox(height: defaultSize),
                      TextButton(
                        onPressed: () => controller.sendVerificationEmail(),
                        child: Text(resendEmailLink),
                      ),
                      TextButton(
                        onPressed: () => AuthenticationRepository.instance.logout(),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Icon(LineAwesomeIcons.alternate_long_arrow_left),
                            const SizedBox(width: 5),
                            Text(backToLogin.toLowerCase()),
                          ],
                        )
                      )
                    ],
                  )))),
    );
  }
}
