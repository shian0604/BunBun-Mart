import 'package:bunbunmart/data/controller/login_controller.dart';
import 'package:bunbunmart/data/validator/input_validator.dart';
import 'package:bunbunmart/login/email%20verification/bun_forgotpassword.dart';
import 'package:bunbunmart/login/register.dart';
import 'package:bunbunmart/models/bun_colors.dart';
import 'package:bunbunmart/utilities/bun%20login/login_socialicons.dart';
import 'package:bunbunmart/utilities/bun_checkbox.dart';
import 'package:bunbunmart/utilities/layout/textfields/white_inputfield.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BunLoginform extends StatefulWidget {
  const BunLoginform({super.key});

  @override
  State<BunLoginform> createState() => _BunLoginformState();
}

class _BunLoginformState extends State<BunLoginform> {
  final controller = Get.put(LoginController());
  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    return Form(
      key: controller.loginFormKey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        children: [
          Text(
            "BunBun Mart",
            style: TextStyle(
              color: const Color(0xFF183B49),
              fontSize: 36,
              fontFamily: 'DeliusSwashCaps',
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: screenHeight * 0.02),
          Text(
            "Welcome back! Use your email\nand password to Log In",
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.black,
              fontSize: 12,
              fontFamily: 'Poppins',
              fontWeight: FontWeight.w400,
            ),
          ),
          SizedBox(height: 60),

          // Email Input
          MyInputField(
            labelText: "Email",
            imagepath: "assets/icons/mail.png",
            controller: controller.email,
            validator: (value) => InputValidator.validateEmail(value),
          ),
          SizedBox(height: screenHeight * 0.025),
          Obx(
            () => MyInputField(
              labelText: "Password",
              controller: controller.password,
              validator:
                  (value) =>
                      InputValidator.validateEmptyText('Password', value),
              imagepath: "assets/icons/padlock.png",
              obscureText: controller.hidePassword.value,
              suffixpath: 'assets/icons/visible.png',
              altSuffixPath: 'assets/icons/eye.png',
              isToggled: controller.hidePassword.value,
              suffixAction:
                  () =>
                      controller.hidePassword.value =
                          !controller.hidePassword.value,
            ),
          ),
          SizedBox(height: screenHeight * 0.02),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Obx(
                    () => BunBoxCheckBox(
                      value: controller.rememberMe.value,
                      onChanged:
                          (value) => controller.rememberMe.value = value!,
                    ),
                  ),

                  Text(
                    "Remember me",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 12,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),

              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => BunForgotPassword(),
                    ),
                  );
                },
                child: Text(
                  "Forgot Password?",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 12,
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 60),

          // Login Button
          GestureDetector(
            onTap:() => controller.emailAndPasswordSignIn(),
            child: Container(
              padding: EdgeInsets.all(25),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(50),
                gradient: const LinearGradient(
                  colors: [BunColors.navy, BunColors.gray, BunColors.beige],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
              ),
              child: Center(
                child: Text(
                  'Log In',
                  style: TextStyle(
                    color: Colors.white,
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w600,
                    fontSize: 14,
                  ),
                ),
              ),
            ),
          ),
          SizedBox(height: 20),

          // Or Login With
          Text(
            "Or Login With",
            style: TextStyle(
              color: Colors.black,
              fontSize: 12,
              fontFamily: 'Poppins',
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(height: screenHeight * 0.025),

          // Social Icons
          LoginSocialicons(),
          SizedBox(height: 20),

          // Signup Text
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Don't have an account? ",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 12,
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w400,
                ),
              ),
              GestureDetector(
                onTap: () {
                  // Navigate to RegisterPage when the "Sign Up" text is pressed
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => RegisterPage()),
                  );
                },
                child: Text(
                  "Sign Up",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 12,
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
