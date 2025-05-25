import 'package:bunbunmart/data/controller/profile_controller.dart';
import 'package:bunbunmart/data/controller/user/user_controller.dart';
import 'package:bunbunmart/data/repository/authentication_repository.dart';
import 'package:bunbunmart/login/seller/seller_registration.dart';
import 'package:bunbunmart/models/bun_colors.dart';
import 'package:bunbunmart/models/size_configs.dart';
import 'package:bunbunmart/pages/features/bun_address.dart';
import 'package:bunbunmart/pages/main_page.dart';
import 'package:bunbunmart/pages/terms%20and%20conditions/bun_about_bunbun_mart.dart';
import 'package:bunbunmart/pages/terms%20and%20conditions/bun_about_us.dart';
import 'package:bunbunmart/pages/terms%20and%20conditions/bun_privacy_policy.dart';
import 'package:bunbunmart/pages/terms%20and%20conditions/bun_terms_and_conditions.dart';
import 'package:bunbunmart/utilities/bun%20settings/settings_proceed.dart';
import 'package:bunbunmart/utilities/layout/bun_button.dart';
import 'package:bunbunmart/utilities/layout/buttons/back_button.dart';
import 'package:bunbunmart/utilities/layout/texts/bun_text.dart';
import 'package:bunbunmart/utilities/popups/bun_shimmer.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BunBunSettings extends StatefulWidget {
  const BunBunSettings({super.key});

  @override
  State<BunBunSettings> createState() => _BunBunSettingsState();
}

class _BunBunSettingsState extends State<BunBunSettings> {
  final ProfileController profileController = Get.find<ProfileController>();

  @override
  void initState() {
    super.initState();
    profileController.loadProfileImage(); // Load from Firestore
  }

  @override
  Widget build(BuildContext context) {
    final controller = UserController.instance;
    BunSizeConfig.init(context);
    return Scaffold(
      body: Container(
        padding: EdgeInsets.all(20.0),
        width: BunSizeConfig.screenWidth,
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
                        onPressed: () {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) => MainPage(selectedIndex: 3),
                            ),
                          );
                        },
                      ),
                    ),
                    BunbunHeader(header: "Settings", color: BunColors.white),
                  ],
                ),

                SizedBox(height: 16.0),

                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: BunColors.white,
                  ),
                  width: BunSizeConfig.screenWidth,
                  padding: EdgeInsets.symmetric(
                    vertical: 10.0,
                    horizontal: 30.0,
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          ClipOval(
                            child: Image.network(
                              profileController.profileImageUrl.value.isNotEmpty
                                  ? profileController.profileImageUrl.value
                                  : 'https://via.placeholder.com/160',
                              width: 100,
                              height: 100,
                              fit: BoxFit.cover,
                              errorBuilder: (context, error, stackTrace) {
                                // If the network image fails to load, show the default asset image
                                return Image.asset(
                                  'assets/profile/default_profile.jpg', // Path to your default profile image
                                  width: 160,
                                  height: 160,
                                  fit: BoxFit.cover,
                                );
                              },

                              loadingBuilder: (
                                context,
                                child,
                                loadingProgress,
                              ) {
                                if (loadingProgress == null) return child;
                                return BunShimmerEffect(
                                  width: 160,
                                  height: 160,
                                  radius:
                                      80, // Adjust the radius for the circular effect
                                );
                              },
                            ),
                          ),
                          SizedBox(width: 15.0),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Obx(() {
                                if (controller.profileLoading.value) {
                                  return BunShimmerEffect(
                                    width: 80,
                                    height: 15,
                                  );
                                } else {
                                  final name = controller.user.value.userName;
                                  return BunbunText(
                                    text: name.isNotEmpty ? name : "Guest User",
                                    color: BunColors.black,
                                  );
                                }
                              }),
                              Obx(() {
                                if (controller.profileLoading.value) {
                                  return BunShimmerEffect(
                                    width: 80,
                                    height: 15,
                                  );
                                } else {
                                  final email = controller.user.value.email;
                                  return BTextBold(
                                    text:
                                        email.isNotEmpty
                                            ? email
                                            : "No email provided",
                                    color: BunColors.black,
                                  );
                                }
                              }),
                              Obx(() {
                                if (controller.profileLoading.value) {
                                  return BunShimmerEffect(
                                    width: 80,
                                    height: 15,
                                  );
                                } else {
                                  final phone =
                                      controller.user.value.phoneNumber;
                                  return BTextSmall(
                                    text:
                                        phone.isNotEmpty
                                            ? phone
                                            : "No phone number",
                                    color: BunColors.black,
                                  );
                                }
                              }),
                            ],
                          ),
                        ],
                      ),

                      BunProceedButton(),
                    ],
                  ),
                ),

                SizedBox(height: 16.0),

                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: BunColors.white,
                  ),
                  width: BunSizeConfig.screenWidth,
                  padding: EdgeInsets.symmetric(
                    vertical: 10.0,
                    horizontal: 30.0,
                  ),
                  child: SettingsRow(
                    text: "Seller Registration",
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => BunBunSellerRegistration(),
                        ),
                      );
                    },
                  ),
                ),

                SizedBox(height: 16.0),

                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: BunColors.white,
                  ),
                  width: BunSizeConfig.screenWidth,
                  padding: EdgeInsets.symmetric(
                    vertical: 10.0,
                    horizontal: 30.0,
                  ),
                  child: Column(
                    children: [
                      SettingsRow(
                        text: "Address",
                        onPressed: () {
                          Get.to(() => BunBunAddress());
                        },
                      ),
                      SettingsRow(text: "Terms and Conditions", onPressed: () {
                        Get.to(() => BunTermsAndConditions());
                      },),
                      SettingsRow(text: "Privacy Policy", onPressed: () {
                        Get.to(() => BunPrivacyPolicy());
                      },),
                      SettingsRow(text: "About Us", onPressed: () {
                        Get.to(() => BunAboutUs());
                      },),
                      SettingsRow(text: "About BunBun Mart", onPressed: () {
                        Get.to(() => BunAboutBunbunMart());
                      },),
                    ],
                  ),
                ),

                SizedBox(height: 16.0),

                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: BunColors.white,
                  ),
                  width: BunSizeConfig.screenWidth,
                  padding: EdgeInsets.symmetric(
                    vertical: 10.0,
                    horizontal: 30.0,
                  ),
                  child: SettingsRow(
                    text: "Delete Account",
                    onPressed: () => controller.deleteAccountWarningPopup(),
                  ),
                ),

                SizedBox(height: 16.0),

                BunWhiteButton(
                  padding: EdgeInsets.all(25.0),
                  width: BunSizeConfig.screenWidth,
                  child: Center(child: GradientText(text: "SIGN OUT")),
                  onTap: () => AuthenticationRepository.instance.logout(),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
