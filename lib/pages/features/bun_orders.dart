import 'package:bunbunmart/models/bun_colors.dart';
import 'package:bunbunmart/models/size_configs.dart';
import 'package:bunbunmart/pages/main_page.dart';
import 'package:bunbunmart/utilities/bun%20profile/orders_tab.dart';
import 'package:bunbunmart/utilities/layout/buttons/back_button.dart';
import 'package:bunbunmart/utilities/layout/containers/bunbun_container.dart';
import 'package:bunbunmart/utilities/layout/texts/bun_text.dart';
import 'package:flutter/material.dart';

class BunBunOrders extends StatefulWidget {
  final String? initialStatus;
  const BunBunOrders({super.key, this.initialStatus});

  @override
  State<BunBunOrders> createState() => _BunBunOrdersState();
}

class _BunBunOrdersState extends State<BunBunOrders>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  final List<String> statuses = [
    'All',
    'Unpaid',
    'Pending',
    'Shipped',
    'Review',
  ];

  @override
  void initState() {
    super.initState();

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
    BunSizeConfig.init(context);
    return DefaultTabController(
      length: 5,
      child: Scaffold(
        body: Container(
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
              child: Column(
                children: [
                  Stack(
                    children: [
                      Transform.translate(
                        offset: Offset(
                          0,
                          BunSizeConfig.blockSizeVertical * 0.8,
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: BunPageContainer(
                            color: BunColors.white,
                            padding: EdgeInsets.all(30.0),
                            child: Column(
                              children: [
                                SizedBox(
                                  height: BunSizeConfig.blockSizeVertical * 20,
                                ),
                                OrdersTab(color: Colors.transparent, tabController: _tabController,),
                              ],
                            ),
                          ),
                        ),
                      ),

                      Container(
                        width: BunSizeConfig.screenWidth,
                        height: 160,
                        padding: EdgeInsets.symmetric(horizontal: 30.0),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(80.0),
                            bottomRight: Radius.circular(80.0),
                          ),
                          color: BunColors.navy,
                        ),

                        //Header
                        child: Stack(
                          alignment: Alignment.center,
                          children: [
                            Align(
                              alignment: Alignment.centerLeft,
                              child: WhiteBackButton(
                                onPressed: () {
                                  Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                      builder:
                                          (context) =>
                                              MainPage(selectedIndex: 3),
                                    ),
                                  );
                                },
                              ),
                            ),

                            BunbunHeader(
                              header: "Orders",
                              color: BunColors.white,
                            ),
                          ],
                        ),
                      ),
                    ],
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
