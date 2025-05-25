import 'package:bunbunmart/data/controller/verify_email_controller.dart';
import 'package:bunbunmart/data/repository/authentication_repository.dart';
import 'package:bunbunmart/models/bun_colors.dart';
import 'package:bunbunmart/utilities/layout/containers/bunbun_container.dart';
import 'package:bunbunmart/utilities/layout/bun_button.dart';
import 'package:bunbunmart/utilities/layout/texts/bun_text.dart';
import 'package:bunbunmart/utilities/social_icons.dart';
import 'package:bunbunmart/utilities/verification/imagewithtext.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BunEmailVerification extends StatefulWidget {
  final String? email;
  const BunEmailVerification({super.key, this.email});

  @override
  State<BunEmailVerification> createState() => _BunEmailVerificationState();
}

class _BunEmailVerificationState extends State<BunEmailVerification> {
  @override
  Widget build(BuildContext context) {
    final controller = Get.put(VerifyEmailController());

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: BunPageContainer(
              color: BunColors.lightbeige,
              padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 30.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Align(
                    alignment: Alignment.topRight,
                    child: CircularIcons(
                      onPressed: () => AuthenticationRepository.instance.logout(),
                      imagepath: "assets/icons/exit.png",
                      imageheight: 16,
                      imagewidth: 16,
                      color: Colors.transparent,
                    ),
                  ),
                  ImageWithText(
                    imagepath: "assets/bunbunmart/verify_email.png",
                    title: "Verify your Email Address",
                    subtext: widget.email ?? '',
                    text:
                        "Tail wags and high fives! You're one step away from joining the BunBun Family—verify your email to get started!",
                  ),
                  SizedBox(height: 36),
                  BunButton(
                    padding: EdgeInsets.all(20.0),
                    onTap: () => controller.checkEmailVerificationStatus(),
                    child: Center(
                      child: BTextBold(
                        text: "Continue",
                        color: BunColors.white,
                      ),
                    ),
                  ),
                  SizedBox(height: 16),
                  Align(
                    alignment: Alignment.center,
                    child: GestureDetector(
                      onTap: () => controller.sendEmailVerification(),
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
