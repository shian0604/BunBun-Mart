import 'package:bunbunmart/data/controller/seller/seller_controller.dart';
import 'package:bunbunmart/data/validator/input_validator.dart';
import 'package:bunbunmart/models/bun_colors.dart';
import 'package:bunbunmart/models/size_configs.dart';
import 'package:bunbunmart/pages/seller/features/seller_settings.dart';
import 'package:bunbunmart/utilities/layout/bun_button.dart';
import 'package:bunbunmart/utilities/layout/buttons/back_button.dart';
import 'package:bunbunmart/utilities/layout/textfields/white_inputfield.dart';
import 'package:bunbunmart/utilities/layout/texts/bun_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:get/route_manager.dart';

class SellerReauth extends StatefulWidget {
  const SellerReauth({super.key});

  @override
  State<SellerReauth> createState() => _SellerReauthState();
}

class _SellerReauthState extends State<SellerReauth> {
  final controller = SellerController.instance;
  @override
  Widget build(BuildContext context) {
    BunSizeConfig.init(context);
    return Scaffold(
      body: Container(
        padding: EdgeInsets.all(20.0),
        width: BunSizeConfig.screenWidth,
        height: BunSizeConfig.screenHeight,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [BunColors.navy, BunColors.gray, BunColors.beige],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
          image: DecorationImage(
            image: AssetImage('assets/screentone/tone.jpg'),
            fit: BoxFit.cover,
            alignment: Alignment.bottomCenter,
            repeat: ImageRepeat.noRepeat,
            opacity: 0.03,
          ),
        ),

        child: SafeArea(
          child: SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Column(
              children: [
                Stack(
                  alignment: Alignment.center,
                  children: [
                    Align(
                      alignment: Alignment.centerLeft,
                      child: WhiteBackButton(
                        onPressed: () => Get.off(() => const SellerSettings()),
                      ),
                    ),
                    BunbunHeader(
                      header: "Re-Authenticate User",
                      color: BunColors.white,
                    ),
                  ],
                ),

                Container(
                  width: BunSizeConfig.screenWidth,
                  padding: EdgeInsets.symmetric(
                    vertical: 10.0,
                    horizontal: 30.0,
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: BunColors.white,
                  ),
                  child: Form(
                    key: controller.reAuthFormKey,
                    child: Column(
                      children: [
                        MyInputField(
                          labelText: "Email",
                          imagepath: "assets/icons/mail.png",
                          validator:
                              (value) => InputValidator.validateEmail(value),
                          controller: controller.verifyEmail,
                        ),
                        Obx(
                          () => MyInputField(
                            labelText: "Password",
                            imagepath: "assets/icons/padlock.png",
                            suffixpath: 'assets/icons/visible.png',
                            altSuffixPath: 'assets/icons/eye.png',
                            controller: controller.verifyPassword,
                            obscureText: controller.hidePassword.value,
                            isToggled: controller.hidePassword.value,
                            suffixAction:
                                () =>
                                    controller.hidePassword.value =
                                        !controller.hidePassword.value,
                            validator:
                                (value) => InputValidator.validateEmptyText(
                                  'Password',
                                  value,
                                ),
                          ),
                        ),

                        SizedBox(height: 16),
                        BunButton(
                          onTap: () => controller.reAuthenticateEmailAndPasswordSeller(),
                          padding: EdgeInsets.all(16),
                          radius: BorderRadius.circular(20),
                          child: Center(
                            child: BTextBold(
                              text: "Verify",
                              color: BunColors.white,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
