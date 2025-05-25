import 'package:bunbunmart/Utilities/layout/texts/My_Subtitle.dart';
import 'package:bunbunmart/Utilities/my_banner.dart';
import 'package:bunbunmart/Utilities/search_bar.dart';
import 'package:bunbunmart/data/controller/user/user_searchcontroller.dart';
import 'package:bunbunmart/models/bun_colors.dart';
import 'package:bunbunmart/models/size_configs.dart';
import 'package:bunbunmart/pages/main_page.dart';
import 'package:bunbunmart/utilities/my_category.dart';
import 'package:bunbunmart/utilities/layout/product%20list/vertical_productlist.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'dart:async';

class BunBunHomePage extends StatefulWidget {
  const BunBunHomePage({super.key});

  @override
  State<BunBunHomePage> createState() => _BunBunHomePageState();
}

class _BunBunHomePageState extends State<BunBunHomePage> {
  final _controller = PageController();
   final UserSearchController searchController = UserSearchController.instance;
  late Timer _timer;

  @override
  void initState() {
    super.initState();

    _timer = Timer.periodic(const Duration(seconds: 3), (timer) {
      int nextPage = _controller.page!.round() + 1;

      if (nextPage == 3) {
        nextPage = 0;
      }

      _controller.animateToPage(
        nextPage,
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeInOut,
      );
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    BunSizeConfig.init(context);

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Column(
            children: [
              Column(
                children: [
                  Container(
                    padding: EdgeInsets.all(10.0),
                    width: BunSizeConfig.screenWidth,
                    height: 150,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      gradient: LinearGradient(
                        colors: [
                          BunColors.navy,
                          BunColors.gray,
                          BunColors.beige,
                        ],
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
                    child: Column(
                      children: [
                        Text(
                          textAlign: TextAlign.center,
                          'BunBun Mart',
                          style: TextStyle(
                            fontFamily: 'DeliusSwashCaps',
                            fontSize: 36,
                            color: Color(0xFFEFE8D8),
                          ),
                        ),
                        SizedBox(height: 20),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 30.0),
                          child: MySearchBar(
                            onSubmitted: (_) {
                              searchController.navigateToSearchResults();
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),

              // ignore: sized_box_for_whitespace
              Container(
                height: 180,
                width: BunSizeConfig.screenWidth,
                child: PageView(
                  physics: ClampingScrollPhysics(),
                  controller: _controller,
                  scrollDirection: Axis.horizontal,
                  children: [
                    MyBanner(imagepath: "assets/banner/banner1.jpg"),
                    MyBanner(imagepath: "assets/banner/banner2.jpg"),
                    MyBanner(imagepath: "assets/banner/banner3.jpg"),
                  ],
                ),
              ),

              SmoothPageIndicator(
                controller: _controller,
                count: 3,
                effect: ExpandingDotsEffect(
                  activeDotColor: Colors.black,
                  dotHeight: 5,
                  dotWidth: 5,
                ),
              ),

              MySubtitle(
                subtitle: "Category",
                onPressed: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => MainPage(selectedIndex: 0),
                    ),
                  );
                },
              ),
              MyCategory(),

              MySubtitle(subtitle: "Suggested Products", onPressed: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => MainPage(selectedIndex: 0),
                    ),
                  );
                },),

              //Product list
              VerticalProductlist(),
            ],
          ),
        ),
      ),
    );
  }
}
