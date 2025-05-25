
import 'package:bunbunmart/data/controller/forgotpassword_controller.dart';
import 'package:bunbunmart/data/validator/input_validator.dart';
import 'package:bunbunmart/login/login.dart';
import 'package:bunbunmart/models/bun_colors.dart';
import 'package:bunbunmart/utilities/layout/bun_button.dart';
import 'package:bunbunmart/utilities/layout/containers/bunbun_container.dart';
import 'package:bunbunmart/utilities/layout/textfields/white_inputfield.dart';
import 'package:bunbunmart/utilities/layout/texts/bun_text.dart';
import 'package:bunbunmart/utilities/social_icons.dart';
import 'package:bunbunmart/utilities/verification/imagewithtext.dart';
import 'package:flutter/material.dart';
import 'package:get/instance_manager.dart';

class BunForgotPassword extends StatefulWidget {
  const BunForgotPassword({super.key});

  @override
  State<BunForgotPassword> createState() => _BunForgotPasswordState();
}

class _BunForgotPasswordState extends State<BunForgotPassword> {
  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ForgotpasswordController());
    return Scaffold(
      backgroundColor: BunColors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: BunPageContainer(
              padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 30.0),
              color: BunColors.lightbeige,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                   Align(
                      alignment: Alignment.topRight,
                      child: CircularIcons(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => LoginPage(),
                            ),
                          );
                        },
                        imagepath: "assets/icons/exit.png",
                        imageheight: 16,
                        imagewidth: 16,
                        color: Colors.transparent,
                      ),
                    ),
            
                  ImageWithText(
                    imagepath: "assets/bunbunmart/forgot.png",
                    title: "Forget Your Password?",
                    text: "No worries, fur-parent! Just enter your email and we’ll help you sniff out your account in no time!",
                  ),
            
                  SizedBox(height: 36,),
                  Form(
                    key: controller.forgotPasswordFormKey,
                    child: MyInputField(
                      controller: controller.email,
                      validator: (value) => InputValidator.validateEmail(value),
                      labelText: "Email", imagepath: "assets/icons/mail.png")),
                  SizedBox(height: 16,),
                  BunButton(
                      padding: EdgeInsets.all(20.0),
                      onTap: () => controller.sendPasswordResetEmail(),
                      child: Center(
                        child: BTextBold(
                          text: "Submit",
                          color: BunColors.white,
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
