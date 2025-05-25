import 'package:bunbunmart/data/controller/login_controller.dart';
import 'package:bunbunmart/utilities/social_icons.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginSocialicons extends StatefulWidget {
  const LoginSocialicons({super.key});

  @override
  State<LoginSocialicons> createState() => _LoginSocialiconsState();
}

class _LoginSocialiconsState extends State<LoginSocialicons> {
  @override
  Widget build(BuildContext context) {
    final controller = Get.put(LoginController());
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,

        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          CircularIcons(
            imagepath: 'assets/icons/google.png',
            imageheight: 36,
            imagewidth: 36,
            onPressed: () => controller.googleSignIn(),
          ),
          SizedBox(width: 20.0),
          CircularIcons(
            imagepath: 'assets/icons/instagram.png',
            imageheight: 36,
            imagewidth: 36,
          ),
          SizedBox(width: 20.0),
          CircularIcons(
            imagepath: 'assets/icons/facebook.png',
            imageheight: 36,
            imagewidth: 36,
          ),
        ],
      ),
    );
  }
}
