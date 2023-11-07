import 'package:flutter/material.dart';
import 'package:quickgrocer_application/src/constants/sizes.dart';
import 'package:quickgrocer_application/src/constants/text_strings.dart';
import 'package:quickgrocer_application/src/features/authentication/screens/forget_password/forget_password_options/forget_password_btn_widget.dart';

class ForgetPasswordScreen {
  // static function can be accessed by class name
  static Future<dynamic> buildShowModalBottomSheet(BuildContext context) {
    return showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
      builder: (context) => Container(
        padding: EdgeInsets.all(defaultSize),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(forgetPasswordTitle,
                style: Theme.of(context).textTheme.headlineSmall),
            Text(forgetPasswordSubtitle,
                style: Theme.of(context).textTheme.bodyMedium),
            const SizedBox(
              height: 30.0,
            ),
            ForgetPasswordBtnWidget(
              btnIcon: Icons.mail_outline_rounded,
              title: email,
              subTitle: resetViaEmail,
              onTap: () {},
            ),
            const SizedBox(
              height: 20.0,
            ),
            ForgetPasswordBtnWidget(
              btnIcon: Icons.mobile_friendly_rounded,
              title: phoneNum,
              subTitle: resetViaPhoneNum,
              onTap: () {},
            ),
          ],
        ),
      ),
    );
  }
}
