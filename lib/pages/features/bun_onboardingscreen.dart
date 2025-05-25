import 'package:bunbunmart/models/bun_colors.dart';
import 'package:bunbunmart/models/size_configs.dart';
import 'package:bunbunmart/pages/main_page.dart';
import 'package:bunbunmart/utilities/bun%20boardingscreen/bun_onboardingpage.dart';
import 'package:bunbunmart/utilities/layout/containers/bunbun_container.dart';
import 'package:bunbunmart/utilities/layout/texts/bun_text.dart';
import 'package:bunbunmart/utilities/social_icons.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:get_storage/get_storage.dart';

class BunBunOnBoardingScreen extends StatefulWidget {
  const BunBunOnBoardingScreen({super.key});

  @override
  State<BunBunOnBoardingScreen> createState() => _BunBunOnBoardingScreenState();
}

class _BunBunOnBoardingScreenState extends State<BunBunOnBoardingScreen> {
  final _controller = PageController();
  @override
  Widget build(BuildContext context) {
    BunSizeConfig.init(context);
    return Scaffold(
      backgroundColor: BunColors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: BunPageContainer(
              color: BunColors.lightbeige,
              padding: EdgeInsets.all(10.0),
              child: Stack(
                children: [
                  Column(
                    children: [
                      Align(
                        alignment: Alignment.topRight,
                        child: CircularIcons(
                          imagepath: "assets/icons/next_w.png",
                          imageheight: 12,
                          imagewidth: 12,
                          color: BunColors.navy,
                          onPressed: () {
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder:
                                    (context) => MainPage(selectedIndex: 2),
                              ),
                            );
                          },
                        ),
                      ),

                      Container(
                        width: BunSizeConfig.screenWidth,
                        height: 430,
                        decoration: BoxDecoration(color: Colors.transparent),
                        child: PageView(
                          physics: ClampingScrollPhysics(),
                          controller: _controller,
                          scrollDirection: Axis.horizontal,
                          children: [
                            BunOnboardingPage(
                              imagepath: "assets/bunbunmart/bun_splash1.png",
                              title: "Welcome to BunBun Mart",
                              text:
                                  "BunBun Mart is your one-stop shop for all essential fur-parent needs, from food to grooming, making shopping easy and full of love.",
                            ),

                            BunOnboardingPage(
                              imagepath: "assets/bunbunmart/bun_splash2.png",
                              title: "Essentials Made Easy",
                              text:
                                  "Discover top-quality, handpicked products for every breed and need—trusted and loved by fur parents like you.",
                            ),

                            BunOnboardingPage(
                              imagepath: "assets/bunbunmart/bun_splash3.png",
                              title: "Fast Delivery, Happy Pets",
                              text:
                                  "Enjoy fast, reliable delivery with real-time tracking, because your pets deserve only the best—right on time.",
                            ),
                          ],
                        ),
                      ),

                      //Dot Navigation
                      SizedBox(height: 16),
                      SmoothPageIndicator(
                        controller: _controller,
                        count: 3,
                        effect: ExpandingDotsEffect(
                          activeDotColor: BunColors.navy,
                          dotHeight: 6,
                          dotWidth: 12,
                        ),
                      ),
                      SizedBox(height: 16),

                      //Circular Button
                    ],
                  ),

                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: GestureDetector(
                        onTap: () {
                          if (_controller.page! < 2) {
                            _controller.nextPage(
                              duration: Duration(milliseconds: 300),
                              curve: Curves.easeInOut,
                            );
                          } else {
                            final storage = GetStorage();
                            storage.write('IsFirstTime', false);
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder:
                                    (context) => MainPage(selectedIndex: 2),
                              ),
                            );
                          }
                        },
                        child: Container(
                          height: 50,
                          width: 110,
                          padding: EdgeInsets.all(5.0),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10.0),
                            color: BunColors.navy,
                          ),
                          child: Center(
                            child: BTextBold(
                              text: "Next",
                              color: BunColors.white,
                              size: 16,
                            ),
                          ),
                        ),
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
