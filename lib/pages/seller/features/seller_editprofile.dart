import 'package:bunbunmart/data/controller/profile_controller.dart';
import 'package:bunbunmart/data/controller/seller/update_storename_controller.dart';
import 'package:bunbunmart/data/supabase/profile_upload.dart';
import 'package:bunbunmart/data/validator/input_validator.dart';
import 'package:bunbunmart/models/bun_colors.dart';
import 'package:bunbunmart/models/size_configs.dart';
import 'package:bunbunmart/pages/seller/seller_mainpage.dart';
import 'package:bunbunmart/utilities/layout/bun_button.dart';
import 'package:bunbunmart/utilities/layout/buttons/back_button.dart';
import 'package:bunbunmart/utilities/layout/textfields/white_inputfield.dart';
import 'package:bunbunmart/utilities/layout/texts/bun_text.dart';
import 'package:bunbunmart/utilities/popups/bun_shimmer.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SellerEditProfile extends StatefulWidget {
  const SellerEditProfile({super.key});

  @override
  State<SellerEditProfile> createState() => _SellerEditProfileState();
}

class _SellerEditProfileState extends State<SellerEditProfile> {
  final ProfileController profileController = Get.find<ProfileController>();

  @override
  void initState() {
    super.initState();
    profileController.loadProfileImage(); // Load from Firestore
  }

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(UpdateStoreNameController());
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
                        onPressed:
                            () =>
                                Get.off(() => const SellerMainPage(selectedIndex: 3)),
                      ),
                    ),
                    BunbunHeader(
                      header: "Edit Profile",
                      color: BunColors.white,
                    ),
                  ],
                ),

                SizedBox(height: 16.0),

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

                  child: Column(
                    children: [
                      Container(
                        padding: EdgeInsets.all(3),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          gradient: LinearGradient(
                            colors: [BunColors.beige, BunColors.navy],
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                          ),
                        ),
                        child: ClipOval(
                          child: Obx(
                            () => Image.network(
                              profileController.profileImageUrl.value.isNotEmpty
                                  ? profileController.profileImageUrl.value
                                  : 'https://via.placeholder.com/160',
                              width: 160,
                              height: 160,
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
                        ),
                      ),
                      SizedBox(height: 12),

                      BunButton(
                        onTap:
                            () => uploadImage((newUrl) async {
                              profileController.updateProfileImageUrl(newUrl);
                              // Save new URL to Firestore
                              final user = FirebaseAuth.instance.currentUser;
                              if (user != null) {
                                final db = FirebaseFirestore.instance;
                                final userDoc =
                                    await db
                                        .collection('Users')
                                        .doc(user.uid)
                                        .get();
                                final isUser = userDoc.exists;

                                final collection = isUser ? 'Users' : 'Sellers';
                                await db
                                    .collection(collection)
                                    .doc(user.uid)
                                    .update({'profilePicture': newUrl});
                              }
                            }),
                        padding: EdgeInsets.all(12),
                        width: 120,
                        child: Center(
                          child: BTextBold(
                            text: "Edit",
                            color: BunColors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                SizedBox(height: 16),
                Form(
                  key: controller.updateStoreNameFormKey,
                  child: MyInputField(
                    labelText: "Store Name",
                    radius: BorderRadius.circular(20),
                    controller: controller.updatedStoreName,
                    validator:
                        (value) => InputValidator.validateUsername(value),
                  ),
                ),
                SizedBox(height: 16),
                BunWhiteButton(
                  padding: EdgeInsets.all(20.0),
                  width: BunSizeConfig.screenWidth,
                  child: Center(child: GradientText(text: "Save")),
                  onTap: () => controller.updateStoreName(),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
