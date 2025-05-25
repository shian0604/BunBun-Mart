import 'package:bunbunmart/data/controller/profile_controller.dart';
import 'package:bunbunmart/data/controller/seller/seller_controller.dart';
import 'package:bunbunmart/models/bun_colors.dart';
import 'package:bunbunmart/models/size_configs.dart';
import 'package:bunbunmart/pages/seller/features/seller_settings.dart';
import 'package:bunbunmart/pages/seller/utils/seller%20orders/spacebetweentext.dart';
import 'package:bunbunmart/utilities/layout/containers/bunbun_container.dart';
import 'package:bunbunmart/utilities/layout/texts/bun_text.dart';
import 'package:bunbunmart/utilities/popups/bun_shimmer.dart';
import 'package:bunbunmart/utilities/social_icons.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SellerProfile extends StatefulWidget {
  const SellerProfile({super.key});

  @override
  State<SellerProfile> createState() => _SellerProfileState();
}

class _SellerProfileState extends State<SellerProfile> {
  final ProfileController profileController = Get.find<ProfileController>();

  @override
  void initState() {
    super.initState();
    profileController.loadProfileImage(); // Load from Firestore
  }

  @override
  Widget build(BuildContext context) {
    BunSizeConfig.init(context);
    final controller = Get.put(SellerController());
    return Scaffold(
      backgroundColor: BunColors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                Container(
                  padding: EdgeInsets.all(20.0),
                  width: BunSizeConfig.screenWidth,
                  decoration: BoxDecoration(
                    color: BunColors.navy,
                    borderRadius: BorderRadius.circular(50),
                    image: DecorationImage(
                      image: AssetImage('assets/screentone/tone.jpg'),
                      fit: BoxFit.cover,
                      alignment: Alignment.bottomCenter,
                      repeat: ImageRepeat.noRepeat,
                      opacity: 0.03,
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      //settings
                      Align(
                        alignment: Alignment.topRight,
                        child: CircularIcons(
                          imagepath: "assets/icons/setting_w.png",
                          imageheight: 20,
                          imagewidth: 20,
                          color: Colors.transparent,
                          padding: EdgeInsets.all(0),
                          onPressed: () {
                            Get.to(
                              () => const SellerSettings(),
                            ); // 👈 Using GetX navigation
                          },
                        ),
                      ),

                      //profile
                      BunbunHeader(
                        header: "Profile",
                        color: BunColors.lightbeige,
                      ),
                      SizedBox(height: 8),

                      //pfp
                      ClipOval(
                        child: Image.network(
                          profileController.profileImageUrl.value.isNotEmpty
                              ? profileController.profileImageUrl.value
                              : 'https://via.placeholder.com/160',
                          width: 210,
                          height: 210,
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

                          loadingBuilder: (context, child, loadingProgress) {
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
                      SizedBox(height: 24),

                      //Store Name
                      BunSmallContainer(
                        height: 60,
                        color: BunColors.beige,
                        child: IntrinsicWidth(
                          child: Center(
                            child: Obx(() {
                              if (controller.profileLoading.value) {
                                return BunShimmerEffect(width: 80, height: 15);
                              } else {
                                final name = controller.seller.value.storeName;
                                return BunbunSubText(
                                  align: TextAlign.center,
                                  subtext:
                                      name.isNotEmpty
                                          ? name
                                          : "Welcome, Guest!",
                                  color: BunColors.white,
                                );
                              }
                            }),
                          ),
                        ),
                      ),

                      SizedBox(height: 50),
                    ],
                  ),
                ),
                SizedBox(height: 24),

                Obx(() {
                  if (controller.profileLoading.value) {
                    return BunShimmerEffect(
                      width: BunSizeConfig.screenWidth * 0.9,
                      height: 300, // adjust height as needed
                      radius: 50,
                    );
                  }

                  final seller = controller.seller.value;

                  return Container(
                    width: BunSizeConfig.screenWidth,
                    padding: const EdgeInsets.symmetric(
                      vertical: 20.0,
                      horizontal: 30.0,
                    ),
                    decoration: BoxDecoration(
                      color: BunColors.lightbeige,
                      borderRadius: BorderRadius.circular(50),
                    ),
                    child: Column(
                      children: [
                        BTextBold(
                          text: "Seller Information",
                          color: BunColors.black,
                          size: 14,
                        ),
                        const SizedBox(height: 16),

                        SpaceBetweenText(
                          maintext: "Seller ID:",
                          subtext: seller.id.isNotEmpty ? seller.id : "N/A",
                        ),
                        SpaceBetweenText(
                          maintext: "Full name:",
                          subtext:
                              seller.fullName.isNotEmpty
                                  ? seller.fullName
                                  : "N/A",
                        ),
                        SpaceBetweenText(
                          maintext: "Email Address:",
                          subtext:
                              seller.email.isNotEmpty ? seller.email : "N/A",
                        ),
                        SpaceBetweenText(
                          maintext: "Contact Number:",
                          subtext:
                              seller.contactNumber.isNotEmpty
                                  ? seller.contactNumber
                                  : "N/A",
                        ),

                        const SizedBox(height: 16),
                        BTextBold(
                          text: "Business & Address Information",
                          color: BunColors.black,
                          size: 14,
                        ),
                        const SizedBox(height: 16),

                        SpaceBetweenText(
                          maintext: "Business Type:",
                          subtext:
                              seller.businessType.isNotEmpty
                                  ? seller.businessType
                                  : "N/A",
                        ),
                        SpaceBetweenText(
                          maintext: "Pickup Address:",
                          subtext:
                              seller.pickupAddress.isNotEmpty
                                  ? seller.pickupAddress
                                  : "N/A",
                        ),
                        const SizedBox(height: 16),
                      ],
                    ),
                  );
                }),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
