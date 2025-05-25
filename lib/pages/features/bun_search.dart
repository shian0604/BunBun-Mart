import 'package:bunbunmart/data/controller/user/user_searchcontroller.dart';
import 'package:bunbunmart/models/bun_colors.dart';
import 'package:bunbunmart/models/size_configs.dart';
import 'package:bunbunmart/pages/main_page.dart';
import 'package:bunbunmart/utilities/layout/buttons/back_button.dart';
import 'package:bunbunmart/utilities/layout/containers/bunbun_container.dart';
import 'package:bunbunmart/utilities/layout/product%20list/search_productlist.dart';
import 'package:bunbunmart/utilities/search_bar.dart';
import 'package:bunbunmart/utilities/social_icons.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BunBunSearch extends StatefulWidget {
  final String searchKeyword;

  const BunBunSearch({super.key, required this.searchKeyword});

  @override
  State<BunBunSearch> createState() => _BunBunSearchState();
}

class _BunBunSearchState extends State<BunBunSearch> {
  final UserSearchController searchController = UserSearchController.instance;
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
            child: Column(
              children: [
                BunPageContainer(
                  padding: EdgeInsets.symmetric(
                    horizontal: 30.0,
                    vertical: 20.0,
                  ),
                  color: BunColors.lightbeige,
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          BunBackButton(
                            onPressed: () {
                              Get.off(() => MainPage(selectedIndex: 2));
                            },
                          ),
                          SizedBox(width: 10.0),
                          Expanded(
                            child: MySearchBar(
                              onSubmitted: (_) {
                                searchController.searchWithoutNavigation();
                              },
                            ),
                          ),
                          SizedBox(width: 10.0),
                          CircularIcons(
                            imagepath: "assets/icons/filter.png",
                            imageheight: 20,
                            imagewidth: 20,
                            color: Colors.transparent,
                          ),
                        ],
                      ),
                      SizedBox(height: 6.0),
                      SearchProductlist(
                        color: BunColors.white,
                        padding: EdgeInsets.all(10.0),
                        searchKeyword: widget.searchKeyword,
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
