import 'package:bunbunmart/data/controller/user/order_controller.dart';
import 'package:bunbunmart/data/repository/authentication_repository.dart';
import 'package:bunbunmart/pages/seller/utils/product%20list/product%20cards/seller_horizontalpcard.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SellerOrderlist extends StatefulWidget {
  const SellerOrderlist({super.key});

  @override
  State<SellerOrderlist> createState() => _SellerOrderlistState();
}

class _SellerOrderlistState extends State<SellerOrderlist> {
  final OrderController controller = Get.put(OrderController());

  @override
  void initState() {
    super.initState();
    fetchOrders(); // Fetch seller orders on screen load
  }

  void fetchOrders() {
    final sellerId = AuthenticationRepository.instance.authUser?.uid;
    if (sellerId != null) {
      controller.fetchSellerOrders(sellerId);
    }
  }

  @override
  Widget build(BuildContext context) {
    return // **Display Seller Orders**
    Obx(() {
      if (controller.isLoading.value) {
        return Center(child: CircularProgressIndicator());
      }

      final orders = controller.userOrders;

      if (orders.isEmpty) {
        return Center(child: Text("No orders found."));
      }

      return ListView.builder(
        shrinkWrap: true, // Prevents unnecessary scrolling issues
        physics: NeverScrollableScrollPhysics(),
        itemCount: orders.length,
        itemBuilder: (context, index) {
          return SellerOrderCard(
            order: orders[index],
            onPressed: () {
              // Define action when the seller interacts with an order
              print("Order selected: ${orders[index].orderId}");
            },
          );
        },
      );
    });
  }
}
