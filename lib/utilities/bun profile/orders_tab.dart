import 'package:bunbunmart/data/controller/user/order_controller.dart';
import 'package:flutter/material.dart';
import 'package:bunbunmart/models/bun_colors.dart';
import 'package:bunbunmart/models/size_configs.dart';
import 'package:bunbunmart/utilities/layout/texts/bun_text.dart';
import 'package:bunbunmart/utilities/product%20cards/productcard_horizontal.dart';
import 'package:get/get.dart';

class OrdersTab extends StatefulWidget {
  final Color color;
  final TabController tabController;
  const OrdersTab({
    super.key,
    required this.color,
    required this.tabController,
  });

  @override
  State<OrdersTab> createState() => _OrdersTabState();
}

class _OrdersTabState extends State<OrdersTab> {
  final controller = Get.put(OrderController());

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
    controller.fetchUserOrders(); // Fetch orders on tab load
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        padding: EdgeInsets.all(10),
        width: BunSizeConfig.screenWidth,
        height: 500,
        decoration: BoxDecoration(
          color: widget.color,
          borderRadius: BorderRadius.circular(20.0),
        ),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: TabBar(
                    controller: widget.tabController,
                    isScrollable: false,
                    indicatorColor: BunColors.navy,
                    labelColor: BunColors.navy,
                    tabs: [
                      Tab(
                        child: BTextBold(
                          text: "All orders",
                          color: Colors.black,
                          size: 10,
                        ),
                      ),
                      Tab(
                        child: BTextBold(
                          text: "Unpaid",
                          color: Colors.black,
                          size: 10,
                        ),
                      ),
                      Tab(
                        child: BTextBold(
                          text: "Pending",
                          color: Colors.black,
                          size: 10,
                        ),
                      ),
                      Tab(
                        child: BTextBold(
                          text: "Shipped",
                          color: Colors.black,
                          size: 10,
                        ),
                      ),
                      Tab(
                        child: BTextBold(
                          text: "Completed",
                          color: Colors.black,
                          size: 10,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Obx(() {
                if (OrderController.instance.isLoading.value) {
                  return const Center(child: CircularProgressIndicator());
                }
              
                final orders = controller.userOrders;
              
                if (orders.isEmpty) {
                  return const Center(child: Text("No orders found."));
                }
              
                return SizedBox(
                  height: 400, // or use MediaQuery for dynamic sizing
                  child: TabBarView(
                    controller: widget.tabController,
                    children: List.generate(5, (tabIndex) {
                      final status = statuses[tabIndex].toLowerCase();
                      final filteredOrders =
                          status == 'all'
                              ? orders
                              : orders
                                  .where(
                                    (order) =>
                                        order.orderStatus.toLowerCase() == status,
                                  )
                                  .toList();
              
                      return ListView.builder(
                        itemCount: filteredOrders.length,
                        itemBuilder: (context, index) {
                          return HPCard(
                            order: filteredOrders[index],
                            onPressed:
                                () => controller.cancelOrderWarningPopup(
                                  filteredOrders[index].orderId,
                                ),
                          );
                        },
                      );
                    }),
                  ),
                );
              }),
            ),
          ],
        ),
      ),
    );
  }
}
