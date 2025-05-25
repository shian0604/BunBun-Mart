import 'package:bunbunmart/data/controller/user/address_controller.dart';
import 'package:bunbunmart/data/controller/user/cart_controller.dart';
import 'package:bunbunmart/models/address_model.dart';
import 'package:bunbunmart/models/cart_model.dart';
import 'package:get/get.dart';

class CheckoutController extends GetxController {
  static CheckoutController get instance => Get.find();

  final CartController _cartController = Get.find<CartController>();

  // Selected cart items for summary
  final selectedCartItems = <CartModel>[].obs;

  bool validateSelectedItems() {
    return selectedCartItems.isNotEmpty;
  }

  // Selected shipping method
  final RxBool isStandardShippingSelected = false.obs;

  // Selected payment methods
  final RxString selectedPaymentMethod = ''.obs;

  // total quantity
  int get totalQuantity =>
      selectedCartItems.fold(0, (sum, item) => sum + item.quantity);

  final Rx<AddressModel?> selectedAddress = Rx<AddressModel?>(null);

  // This method is already in your onTap logic:
  Future<void> selectAddress(AddressModel address) async {
    final updatedAddress = await AddressController.instance.selectAddress(
      address,
    );
    if (updatedAddress != null) {
      selectedAddress.value = updatedAddress;
      print(updatedAddress);
    }
  }

  // Shipping estimated arrival
  String get estimatedArrival {
    final now = DateTime.now();
    final arrival = now.add(
      const Duration(days: 7),
    ); // At least 1 week from now
    final formattedDate =
        "${_formatMonth(arrival.month)} ${arrival.day}-${arrival.day + 1}";
    return "(Arrives between $formattedDate)";
  }

  double get totalOrderPrice =>
      selectedCartItems.fold(0, (sum, item) => sum + item.totalPrice);

  @override
  void onInit() {
    super.onInit();
    ever(_cartController.selectedCartItems, (_) => _updateSelectedItems());
    _updateSelectedItems();
  }

  void _updateSelectedItems() {
    selectedCartItems.assignAll(
      _cartController.cartItems.where(
        (item) => _cartController.selectedCartItems.contains(item.cartItemId),
      ),
    );
  }

  // Validation methods
  bool validateShippingMethod() => isStandardShippingSelected.value;

  bool validatePaymentMethod() => selectedPaymentMethod.isNotEmpty;

  static String _formatMonth(int month) {
    const months = [
      '',
      'January',
      'February',
      'March',
      'April',
      'May',
      'June',
      'July',
      'August',
      'September',
      'October',
      'November',
      'December',
    ];
    return months[month];
  }
}
