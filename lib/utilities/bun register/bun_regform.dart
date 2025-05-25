import 'package:bunbunmart/data/controller/signup_controller.dart';
import 'package:bunbunmart/data/validator/input_validator.dart';
import 'package:bunbunmart/models/bun_colors.dart';
import 'package:bunbunmart/utilities/bun_checkbox.dart';
import 'package:bunbunmart/utilities/layout/textfields/underline_inputfield.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BunRegisterForm extends StatefulWidget {
  const BunRegisterForm({super.key});

  @override
  State<BunRegisterForm> createState() => _BunRegisterFormState();
}

class _BunRegisterFormState extends State<BunRegisterForm> {
  @override
  Widget build(BuildContext context) {
    final controller = Get.put(SignupController());
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: Form(
        key: controller.signupFormKey,
        child: Column(
          children: [
            UnderlineInputfield(
              labelText: "Username",
              controller: controller.username,
              validator: (value) => InputValidator.validateUsername(value),
            ),
            UnderlineInputfield(
              labelText: "Email",
              controller: controller.email,
              validator: (value) => InputValidator.validateEmail(value),
            ),
            UnderlineInputfield(
              labelText: "Phone Number",
              controller: controller.number,
              validator: (value) => InputValidator.validatePhoneNumber(value),
            ),
            Obx(
              () => UnderlineInputfield(
                controller: controller.password,
                validator: (value) => InputValidator.validatePassword(value),
                labelText: "Password",
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
            Obx(
              () => UnderlineInputfield(
                controller: controller.reenterpassword,
                validator:
                    (value) => InputValidator.validateReEnterPassword(
                      value,
                      controller.password.text,
                    ),
                labelText: "Re-enter Password",
                obscureText: controller.hideReenterPassword.value,
                suffixpath: 'assets/icons/visible.png',
                altSuffixPath: 'assets/icons/eye.png',
                isToggled: controller.hideReenterPassword.value,
                suffixAction:
                    () =>
                        controller.hideReenterPassword.value =
                            !controller.hideReenterPassword.value,
              ),
            ),

            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Container(
                padding: EdgeInsets.all(10.0),
                width: double.infinity,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [BunColors.navy, BunColors.gray, BunColors.beige],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ),
                  borderRadius: BorderRadius.circular(30),
                ),
                child: ElevatedButton(
                  onPressed: () => controller.signup(),
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.all(5.0),
                    backgroundColor: Colors.transparent,
                    shadowColor: Colors.transparent,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                  child: Text(
                    'Sign Up',
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
            SizedBox(height: 10.0),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Your custom checkbox
                Obx(
                  () => BunBoxCheckBox(
                    value: controller.privacyPolicy.value,
                    onChanged:
                        (value) => controller.privacyPolicy.value = value!,
                  ),
                ),

                // Text with Terms and Conditions
                Expanded(
                  child: Text.rich(
                    TextSpan(
                      children: [
                        TextSpan(
                          text: "By clicking this button, you agree with our ",
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 12,
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        TextSpan(
                          text: "Terms and Conditions",
                          style: TextStyle(
                            color: Color(0xFF183B49),
                            fontSize: 12,
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
