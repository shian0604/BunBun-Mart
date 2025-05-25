import 'package:bunbunmart/data/controller/user/checkout_controller.dart';
import 'package:bunbunmart/data/repository/authentication_repository.dart';
import 'package:bunbunmart/data/repository/network_manager.dart';
import 'package:bunbunmart/data/repository/seller/product_repository.dart';
import 'package:bunbunmart/data/repository/user/cart_repository.dart';
import 'package:bunbunmart/data/repository/user/order_repository.dart';
import 'package:bunbunmart/models/address_model.dart';
import 'package:bunbunmart/models/bun_colors.dart';
import 'package:bunbunmart/models/order_model.dart';
import 'package:bunbunmart/models/product_model.dart';
import 'package:bunbunmart/pages/features/bun_order_success.dart';
import 'package:bunbunmart/utilities/layout/texts/bun_text.dart';
import 'package:bunbunmart/utilities/popups/bun_fullscreen_loader.dart';
import 'package:bunbunmart/utilities/popups/bun_loaders.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uuid/uuid.dart';

class OrderController extends GetxController {
  static OrderController get instance => Get.find();

  final _orderRepository = OrderRepository.instance;
  final _checkoutController = CheckoutController.instance;

  final RxBool isLoading = false.obs;

  /// Observable list of orders
  final RxList<OrderModel> userOrders = <OrderModel>[].obs;

  /// ✅ Fetch orders for the current user
  Future<void> fetchUserOrders() async {
    try {
      isLoading.value = true;

      // Fetch orders from repository
      final orders = await _orderRepository.fetchUserOrders();

      // Update observable list
      userOrders.assignAll(orders);
    } catch (e) {
      BunSnackBar.bunerror(title: "Order Fetch Failed", message: e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  /// ✅ Fetch orders for a seller
  Future<void> fetchSellerOrders(String sellerId) async {
    try {
      isLoading.value = true;

      // Fetch orders from repository
      final orders = await _orderRepository.fetchOrdersBySellerId(sellerId);

      // Update observable list
      userOrders.assignAll(orders);
    } catch (e) {
      BunSnackBar.bunerror(
        title: "Seller Order Fetch Failed",
        message: e.toString(),
      );
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> updateOrderStatus(String orderId, String newStatus) async {
  try {
    BunLoader.openLoadingDialog("Updating Order Status . . .");

    // Valid status check
    final validStatuses = ["Unpaid", "Pending", "Shipped", "Completed"];
    if (!validStatuses.contains(newStatus)) {
      throw 'Invalid order status: $newStatus';
    }

    isLoading.value = true;

    // 1. Update order status
    await _orderRepository.updateOrderStatus(orderId, newStatus);

    // 2. If status is 'Shipped', reduce stock for each product
    if (newStatus == "Shipped") {
      // Fetch the full order to get items
      final order = await _orderRepository.getOrderById(orderId);

      for (var item in order.items) {
        final String productId = item.productId;
        final int orderedQuantity = item.quantity;
        final String sellerId = order.sellerId;

        // Get the current product
        final docSnapshot = await FirebaseFirestore.instance
            .collection("Sellers")
            .doc(sellerId)
            .collection("Products")
            .doc(productId)
            .get();

        if (docSnapshot.exists) {
          final product = ProductModel.fromSnapshot(docSnapshot);
          final int newStock = product.productStocks - orderedQuantity;

          // Make sure stock does not go below zero
          final int finalStock = newStock < 0 ? 0 : newStock;

          // Update the stock
          await ProductRepository.instance.updateProductStock(
            sellerId,
            productId,
            finalStock,
          );
        }
      }
    }

    // 3. Refresh seller orders
    await fetchSellerOrders(
      AuthenticationRepository.instance.authUser?.uid ?? "",
    );

    BunLoader.stopLoading();
    BunSnackBar.bunsuccess(
      title: "Order Updated",
      message: "Order status successfully changed to $newStatus.",
    );
  } catch (e) {
    BunLoader.stopLoading();
    BunSnackBar.bunerror(title: "Update Failed", message: e.toString());
  } finally {
    isLoading.value = false;
  }
}


  /// ⚠️ Show confirmation dialog before cancelling an order
  void cancelOrderWarningPopup(String orderId) {
    Get.defaultDialog(
      contentPadding: const EdgeInsets.all(16.0),
      titleStyle: const TextStyle(
        fontFamily: "Poppins",
        fontSize: 16,
        fontWeight: FontWeight.w600,
        color: BunColors.black,
      ),
      middleTextStyle: const TextStyle(
        fontFamily: "Poppins",
        fontSize: 12,
        fontWeight: FontWeight.w400,
        color: BunColors.black,
      ),
      title: "Cancel Order? 🛑",
      middleText:
          "Are you sure you want to cancel this order? This action cannot be undone, and your items will be removed from your order history.",

      confirm: ElevatedButton(
        onPressed: () async {
          Navigator.of(Get.overlayContext!).pop(); // Close dialog
          await cancelUserOrder(orderId); // Proceed to cancel
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: BunColors.richRed,
          side: const BorderSide(color: BunColors.richRed),
        ),
        child: const Padding(
          padding: EdgeInsets.symmetric(horizontal: 30.0),
          child: BTextBold(text: "Cancel Order", color: BunColors.white),
        ),
      ),

      cancel: OutlinedButton(
        onPressed: () => Navigator.of(Get.overlayContext!).pop(),
        child: const Padding(
          padding: EdgeInsets.symmetric(horizontal: 30.0),
          child: BTextBold(text: "Go Back", color: BunColors.black),
        ),
      ),
    );
  }

  /// ❌ Cancel a user's order
  Future<void> cancelUserOrder(String orderId) async {
    try {
      // Confirm network connection
      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        BunSnackBar.bunerror(
          title: "No Connection",
          message: "Please check your internet connection.",
        );
        return;
      }

      // Show loading
      BunLoader.openLoadingDialog("Cancelling your order...");

      // Call repository to delete the order
      await _orderRepository.cancelOrderById(orderId);

      // Refresh order list after cancellation
      await fetchUserOrders();

      // Stop loading and notify success
      BunLoader.stopLoading();
      BunSnackBar.bunsuccess(
        title: "Order Cancelled",
        message: "Your order has been successfully cancelled.",
      );
    } catch (e) {
      BunLoader.stopLoading();
      BunSnackBar.bunerror(title: "Cancellation Failed", message: e.toString());
    }
  }

  /// ✅ Place an order
  Future<void> placeOrder() async {
    try {
      // Open loading UI
      BunLoader.openLoadingDialog("Placing your order... 🐾");

      // Check network
      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        BunLoader.stopLoading();
        BunSnackBar.bunerror(
          title: "Connection Error",
          message: "Please check your internet connection.",
        );
        return;
      }

      final userId = AuthenticationRepository.instance.authUser?.uid;
      if (userId == null) {
        BunLoader.stopLoading();
        BunSnackBar.bunerror(
          title: "Login Required",
          message: "Please log in to place an order.",
        );
        return;
      }

      final addressModel = _checkoutController.selectedAddress.value;
      if (addressModel == null) {
        BunLoader.stopLoading();
        BunSnackBar.bunwarning(
          title: "No Address Selected",
          message: "Please select a delivery address.",
        );
        return;
      }

      if (_checkoutController.selectedCartItems.isEmpty) {
        BunLoader.stopLoading();
        BunSnackBar.bunwarning(
          title: "Cart is Empty",
          message: "Please add items to your cart before placing an order.",
        );
        return;
      }

      if (_checkoutController.selectedPaymentMethod.value.isEmpty) {
        BunLoader.stopLoading();
        BunSnackBar.bunwarning(
          title: "Select Payment Method",
          message: "Please choose a payment method to continue.",
        );
        return;
      }

      // Create unique order ID
      final orderId = const Uuid().v4();

      // Construct order model
      final order = OrderModel(
        orderId: orderId,
        userId: userId,
        sellerId: _checkoutController.selectedCartItems.first.sellerId,
        address: addressModel.toFormattedString(),
        deliveryDate: DateTime.now().add(const Duration(days: 7)),
        items: _checkoutController.selectedCartItems,
        orderDate: DateTime.now(),
        paymentMethod: _checkoutController.selectedPaymentMethod.value,
        orderStatus: 'Pending',
        totalAmount: _checkoutController.totalOrderPrice,
        shippingMethod:
            _checkoutController.isStandardShippingSelected.value
                ? 'Standard'
                : 'Express',
      );

      // Save order
      await _orderRepository.saveOrder(order);

      // ✅ Delete ordered cart items from Firestore
      final cartItemIds =
          _checkoutController.selectedCartItems
              .map((item) => item.cartItemId)
              .toList();

      await CartRepository.instance.removeSelectedCartItems(cartItemIds);

      // Stop loading
      BunLoader.stopLoading();

      // Show success message
      BunSnackBar.bunsuccess(
        title: "Order Placed! 🎉",
        message: "Thanks for shopping with us. Your order is on its way!",
      );

      // Clear cart, payment, and shipping selections
      clearOrderData();

      // Redirect user
      Get.to(() => const BunOrderSuccess());
    } catch (e) {
      BunLoader.stopLoading();
      BunSnackBar.bunerror(title: "Order Failed", message: e.toString());
    }
  }

  /// ✅ Clear cart and checkout state after successful order
  void clearOrderData() {
    _checkoutController.selectedCartItems.clear();
    _checkoutController.selectedAddress.value = null;
    _checkoutController.selectedPaymentMethod.value = '';
    _checkoutController.isStandardShippingSelected.value = false;
  }
}
