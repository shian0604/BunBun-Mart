// ignore_for_file: avoid_types_as_parameter_names

import 'package:bunbunmart/data/repository/authentication_repository.dart';
import 'package:bunbunmart/data/repository/network_manager.dart';
import 'package:bunbunmart/data/repository/user/cart_repository.dart';
import 'package:bunbunmart/models/bun_colors.dart';
import 'package:bunbunmart/models/cart_model.dart';
import 'package:bunbunmart/models/product_model.dart';
import 'package:bunbunmart/utilities/layout/texts/bun_text.dart';
import 'package:bunbunmart/utilities/popups/bun_fullscreen_loader.dart';
import 'package:bunbunmart/utilities/popups/bun_loaders.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CartController extends GetxController {
  static CartController get instance => Get.find();

  final cartItems = <CartModel>[].obs;

  // User selections
  final selectedColor = ''.obs;
  final selectedSize = ''.obs;
  final quantity = 1.obs;

  final isLoading = false.obs;

  final selectedCartItems = <String>{}.obs;

  @override
  void onInit() {
    super.onInit();
    _listenToCartChanges(); // ✅ Automatically load items when app/controller starts
  }

  void _listenToCartChanges() {
  final userId = AuthenticationRepository.instance.authUser?.uid;
  if (userId == null) return;

  FirebaseFirestore.instance
      .collection("Users")
      .doc(userId)
      .collection("Cart")
      .orderBy("timestamp", descending: true)
      .snapshots()
      .listen((snapshot) {
        final updatedCart = snapshot.docs.map((doc) {
          return CartModel.fromSnapshot(doc);
        }).toList();
        cartItems.assignAll(updatedCart);
        
        // Sync selected items again, to retain selection on update
        selectedCartItems.removeWhere((id) => 
          !updatedCart.any((item) => item.cartItemId == id)
        );
      });
}


  double get totalSelectedPrice => cartItems
      .where((item) => selectedCartItems.contains(item.cartItemId))
      .fold(0.0, (sum, item) => sum + item.totalPrice);

  void toggleCartItemSelection(String cartItemId) async {
    final isCurrentlySelected = selectedCartItems.contains(cartItemId);
    final newSelected = !isCurrentlySelected;

    if (newSelected) {
      selectedCartItems.add(cartItemId);
    } else {
      selectedCartItems.remove(cartItemId);
    }

    try {
      final userId = AuthenticationRepository.instance.authUser?.uid;
      if (userId != null) {
        await FirebaseFirestore.instance
            .collection("Users")
            .doc(userId)
            .collection("Cart")
            .doc(cartItemId)
            .update({'selected': newSelected});
      }

      // ✅ Optional: Update local cart item object
      final index = cartItems.indexWhere(
        (item) => item.cartItemId == cartItemId,
      );
      if (index != -1) {
        cartItems[index] = CartModel(
          cartItemId: cartItems[index].cartItemId,
          userId: cartItems[index].userId,
          sellerId: cartItems[index].sellerId,
          productId: cartItems[index].productId,
          productName: cartItems[index].productName,
          totalPrice: cartItems[index].totalPrice,
          productImage: cartItems[index].productImage,
          quantity: cartItems[index].quantity,
          selectedSize: cartItems[index].selectedSize,
          selectedColor: cartItems[index].selectedColor,
          timestamp: cartItems[index].timestamp,
          selected: newSelected,
        );
      }
    } catch (e) {
      BunSnackBar.bunerror(
        title: "Uh-oh! 🐾",
        message:
            "We ran into a hiccup while updating your selection. Give it another try!",
      );
    }
  }

  void selectAllCartItems() {
    selectedCartItems.assignAll(cartItems.map((e) => e.cartItemId));
  }

  void deselectAllCartItems() {
    selectedCartItems.clear();
  }

  bool isSelected(String cartItemId) => selectedCartItems.contains(cartItemId);

  /// Increment product quantity
  Future<void> incrementQuantity(CartModel cartItem) async {
    try {
      BunLoader.openLoadingDialog("Topping up your product stash... 🧺✨");
      final updatedQuantity = cartItem.quantity + 1;
      final updatedTotalPrice =
          updatedQuantity * cartItem.totalPrice / cartItem.quantity;

      final updatedItem = cartItem.copyWith(
        quantity: updatedQuantity,
        totalPrice: updatedTotalPrice,
      );

      await CartRepository.instance.saveCartItem(updatedItem);

      // ✅ Update the item in the observable list
      final index = cartItems.indexWhere(
        (item) => item.cartItemId == cartItem.cartItemId,
      );
      if (index != -1) {
        cartItems[index] = updatedItem;
      }

      BunLoader.stopLoading();
    } catch (e) {
      BunLoader.stopLoading();
      BunSnackBar.bunerror(
        title: "Uh-oh! 🐾 Update Fizzled",
        message: "Something went bumpy: ${e.toString()}",
      );
    }
  }

  /// Decrement product quantity
  Future<void> decrementQuantity(CartModel cartItem) async {
    if (cartItem.quantity <= 1) {
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
        title: "Remove Item? 🧺",
        middleText:
            "Are you sure you want to remove this product from your cart?",

        confirm: ElevatedButton(
          onPressed: () async {
            Navigator.of(Get.overlayContext!).pop(); // Close the dialog
            BunLoader.openLoadingDialog("Removing your product... 🧺✨");

            try {
              await CartRepository.instance.removeSelectedCartItems([
                cartItem.cartItemId,
              ]);
              cartItems.removeWhere(
                (item) => item.cartItemId == cartItem.cartItemId,
              );
              BunLoader.stopLoading();
            } catch (e) {
              BunLoader.stopLoading();
              BunSnackBar.bunerror(
                title: "Oops! 🐾",
                message: "Couldn’t remove item: ${e.toString()}",
              );
            }
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: BunColors.richRed,
            side: const BorderSide(color: BunColors.richRed),
          ),
          child: const Padding(
            padding: EdgeInsets.symmetric(horizontal: 30.0),
            child: BTextBold(text: "Remove", color: BunColors.white),
          ),
        ),

        cancel: OutlinedButton(
          onPressed: () => Navigator.of(Get.overlayContext!).pop(),
          child: const Padding(
            padding: EdgeInsets.symmetric(horizontal: 30.0),
            child: BTextBold(text: "Cancel", color: BunColors.black),
          ),
        ),
      );
    } else {
      try {
        BunLoader.openLoadingDialog("Updating your cart... 🛒");
        final updatedQuantity = cartItem.quantity - 1;
        final updatedTotalPrice =
            updatedQuantity * cartItem.totalPrice / cartItem.quantity;

        final updatedItem = cartItem.copyWith(
          quantity: updatedQuantity,
          totalPrice: updatedTotalPrice,
        );

        await CartRepository.instance.saveCartItem(updatedItem);

        final index = cartItems.indexWhere(
          (item) => item.cartItemId == cartItem.cartItemId,
        );
        if (index != -1) {
          cartItems[index] = updatedItem;
        }

        BunLoader.stopLoading();
      } catch (e) {
        BunLoader.stopLoading();
        BunSnackBar.bunerror(
          title: "Uh-oh! 🐾 Update Fizzled",
          message: "Something went bumpy: ${e.toString()}",
        );
      }
    }
  }

  /// Add product to cart with full validation
  Future<void> addToCart(ProductModel product) async {
    try {
      // Start loader
      isLoading(true);
      BunLoader.openLoadingDialog("Hopping your pick into the cart... 🐰🛒");

      final userId = AuthenticationRepository.instance.authUser?.uid;
      if (userId == null) {
        throw 'Whoopsie! You need to be logged in to add items to your cart. 🐾';
      }

      //Check connection
      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        BunLoader.stopLoading();
        return;
      }

      // ----- Validations -----
      if (selectedColor.value.isEmpty) {
        throw 'Pick a color to match your pet’s paw-sonality! 🎨';
      }

      if (selectedSize.value.isEmpty) {
        throw 'Please choose a size for the perfect snuggle fit! 📏';
      }

      if (quantity.value <= 0) {
        throw 'You need to add at least 1 item. Let’s not leave the cart empty! 🧺';
      }

      if (product.productStocks <= 0) {
        throw 'Oh no! This product is currently out of stock. 🥲';
      }

      if (quantity > product.productStocks) {
        throw 'Oops! You’ve requested more than we have in stock. 🐾 Try a smaller number!';
      }

      // ----- Check if item already exists in cart -----
      final existingItems = await CartRepository.instance.getCartItems();
      final duplicate = existingItems.firstWhereOrNull(
        (item) =>
            item.productId == product.productId &&
            item.selectedColor == selectedColor.value &&
            item.selectedSize == selectedSize.value,
      );

      if (duplicate != null) {
        // Calculate total quantity if added together
        final totalRequestedQuantity = duplicate.quantity + quantity.value;

        if (totalRequestedQuantity > product.productStocks) {
          throw 'You’re asking for $totalRequestedQuantity, but we only have ${product.productStocks} in stock. Let’s keep it paws-ible! 🐾';
        }

        // Update quantity of existing cart item
        final updatedCartItem = CartModel(
          cartItemId: duplicate.cartItemId,
          userId: duplicate.userId,
          sellerId: duplicate.sellerId,
          productId: duplicate.productId,
          productName: duplicate.productName,
          totalPrice: product.productPrice * totalRequestedQuantity,
          productImage: duplicate.productImage,
          quantity: totalRequestedQuantity,
          selectedSize: duplicate.selectedSize,
          selectedColor: duplicate.selectedColor,
          timestamp: Timestamp.now(),
          selected: duplicate.selected,
        );

        await CartRepository.instance.saveCartItem(updatedCartItem);
        BunLoader.stopLoading();
        BunSnackBar.bunsuccess(
          title: "Cart Updated! 🎉",
          message: "Your cart is looking paw-some!",
        );
      } else {
        // Add new cart item
        final cartItemId = DateTime.now().millisecondsSinceEpoch.toString();
        final newItem = CartModel.fromProduct(
          cartItemId: cartItemId,
          userId: userId,
          product: product,
          quantity: quantity.value,
          selectedSize: selectedSize.value,
          selectedColor: selectedColor.value,
        );

        await CartRepository.instance.saveCartItem(newItem);
        BunLoader.stopLoading();
        BunSnackBar.bunsuccess(
          title: "Yay! 🎁",
          message: "Your product has been added to your cart with extra love!",
        );
      }

      // Reload cart items
      await loadCartItems();

      //Automatically check the newly added cart
      final latestItems = await CartRepository.instance.getCartItems();

      final newItem = latestItems.firstWhereOrNull(
        (item) =>
            item.productId == product.productId &&
            item.selectedColor == selectedColor.value &&
            item.selectedSize == selectedSize.value,
      );

      if (newItem != null) {
        selectedCartItems.add(newItem.cartItemId);
      }

      
    } catch (e) {
      BunLoader.stopLoading();
      BunSnackBar.bunerror(
        title: "Oh no! 🧺💔",
        message: "Something went wrong while adding to cart: ${e.toString()}",
      );
    } finally {
      isLoading(false);
      BunLoader.stopLoading();
    }
  }

  /// Load all cart items for the user
  Future<void> loadCartItems() async {
    try {
      final items = await CartRepository.instance.getCartItems();
      cartItems.assignAll(items);

      // ✅ Restore selections from Firebase
      final selectedIds =
          items
              .where((item) => item.selected == true)
              .map((item) => item.cartItemId)
              .toList();
      selectedCartItems.assignAll(selectedIds);
    } catch (e) {
      BunSnackBar.bunerror(
        title: "Whoopsie! 🐰🧺",
        message: "We had a hiccup while loading your cart. ${e.toString()}",
      );
    }
  }

  

  

  /// Set selected color
  void setColor(String color) => selectedColor.value = color;

  /// Set selected size
  void setSize(String size) => selectedSize.value = size;

  /// Set quantity
  void setQuantity(int qty) => quantity.value = qty;
}
