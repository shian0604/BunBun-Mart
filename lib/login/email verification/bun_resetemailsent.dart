import 'package:bunbunmart/data/controller/forgotpassword_controller.dart';
import 'package:bunbunmart/login/login.dart';
import 'package:bunbunmart/models/bun_colors.dart';
import 'package:bunbunmart/utilities/layout/bun_button.dart';
import 'package:bunbunmart/utilities/layout/containers/bunbun_container.dart';
import 'package:bunbunmart/utilities/layout/texts/bun_text.dart';
import 'package:bunbunmart/utilities/verification/imagewithtext.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BunResetEmailSent extends StatefulWidget {
  final String email;
  const BunResetEmailSent({super.key, required this.email});

  @override
  State<BunResetEmailSent> createState() => _BunResetEmailSentState();
}

class _BunResetEmailSentState extends State<BunResetEmailSent> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: BunColors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Padding(
            padding: EdgeInsets.all(20.0),
            child: BunPageContainer(
              color: BunColors.lightbeige,
              padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 30.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ImageWithText(
                    imagepath: "assets/bunbunmart/success.png",
                    title: "Password Reset Email Sent",
                    subtext: widget.email,
                    text: "Paw-some! A reset link is on its way—check your inbox and let’s fetch your account back!",
                  ),

                  SizedBox(height: 36),
                    BunButton(
                      padding: EdgeInsets.all(20.0),
                      onTap: () => Get.offAll(() => const LoginPage()),
                      child: Center(
                        child: BTextBold(
                          text: "Done",
                          color: BunColors.white,
                        ),
                      ),
                    ),
                    
                    SizedBox(height: 16),
                    Align(
                    alignment: Alignment.center,
                    child: GestureDetector(
                      onTap: () => ForgotpasswordController.instance.resendPasswordResetEmail(widget.email),
                      child: BTextBold(
                        text: "Resend Email",
                        color: BunColors.navy,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
