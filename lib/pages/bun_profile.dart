import 'package:bunbunmart/Utilities/layout/texts/My_Subtitle.dart';
import 'package:bunbunmart/data/controller/profile_controller.dart';
import 'package:bunbunmart/data/controller/user/user_controller.dart';
import 'package:bunbunmart/models/bun_colors.dart';
import 'package:bunbunmart/models/size_configs.dart';
import 'package:bunbunmart/pages/features/bun_orders.dart';
import 'package:bunbunmart/utilities/bun%20profile/profile_header.dart';
import 'package:bunbunmart/utilities/bun%20profile/profile_icons.dart';
import 'package:bunbunmart/utilities/bun%20profile/orders_tab.dart';
import 'package:bunbunmart/utilities/layout/containers/bunbun_container.dart';
import 'package:bunbunmart/utilities/layout/texts/bun_text.dart';
import 'package:bunbunmart/utilities/popups/bun_shimmer.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BunBunProfile extends StatefulWidget {
  final String? initialStatus;
  const BunBunProfile({super.key, this.initialStatus});

  @override
  State<BunBunProfile> createState() => _BunBunProfileState();
}

class _BunBunProfileState extends State<BunBunProfile> with SingleTickerProviderStateMixin{
  final ProfileController profileController = Get.find<ProfileController>();

  late TabController _tabController;

  final List<String> statuses = [
    'All',
    'Unpaid',
    'Pending',
    'Shipped',
    'Completed',
  ];

  @override
  void initState() {
    super.initState();
    profileController.loadProfileImage(); // Load from Firestore
    int initialTabIndex = 0; // Default to 'All orders'
    if (widget.initialStatus != null) {
      initialTabIndex = statuses.indexWhere(
        (status) => status.toLowerCase() == widget.initialStatus!.toLowerCase(),
      );
      if (initialTabIndex == -1) initialTabIndex = 0;
    }

    _tabController = TabController(length: statuses.length, vsync: this, initialIndex: initialTabIndex);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(UserController());
    BunSizeConfig.init(context);
    double circleSize =
        BunSizeConfig.screenWidth > BunSizeConfig.screenHeight
            ? BunSizeConfig.screenHeight
            : BunSizeConfig.screenWidth;

    return DefaultTabController(
      length: 5,
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Column(
              children: [
                Center(
                  child: Column(
                    children: [
                      Transform.translate(
                        offset: Offset(0, -circleSize * 0.56),
                        child: ProfileHeader(),
                      ),

                      Transform.translate(
                        offset: Offset(0, -circleSize * 0.8),
                        child: Container(
                          padding: EdgeInsets.all(3),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: BunColors.white,
                          ),
                          child: ClipOval(
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
                    ],
                  ),
                ),

                Transform.translate(
                  offset: Offset(0, -circleSize * 0.76),
                  child: Column(
                    children: [
                      BunSmallContainer(
                        height: 60,
                        color: BunColors.navy,
                        child: IntrinsicWidth(
                          child: Center(
                            child: Obx(() {
                              if (controller.profileLoading.value) {
                                return BunShimmerEffect(width: 80, height: 15);
                              } else {
                                final name = controller.user.value.userName;
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

                      ProfileIcons(),

                      MySubtitle(
                        subtitle: "Your Orders",
                        onPressed: () {
                          Get.to(() => BunBunOrders());
                        },
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 30.0),
                        child: OrdersTab(color: BunColors.beige, tabController: _tabController,),
                      ),
                    ],
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
