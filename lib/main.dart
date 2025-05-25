import 'package:bunbunmart/bindings/general_bindings.dart';
import 'package:bunbunmart/data/controller/profile_controller.dart';
import 'package:bunbunmart/data/controller/seller/product_controller.dart';
import 'package:bunbunmart/data/controller/seller/shop/category_controller.dart';
import 'package:bunbunmart/data/controller/user/address_controller.dart';
import 'package:bunbunmart/data/controller/user/cart_controller.dart';
import 'package:bunbunmart/data/controller/user/checkout_controller.dart';
import 'package:bunbunmart/data/controller/user/order_controller.dart';
import 'package:bunbunmart/data/controller/user/user_controller.dart';
import 'package:bunbunmart/data/controller/user/user_searchcontroller.dart';
import 'package:bunbunmart/data/repository/authentication_repository.dart';
import 'package:bunbunmart/data/repository/seller/product_repository.dart';
import 'package:bunbunmart/data/repository/seller/seller_repository.dart';
import 'package:bunbunmart/data/repository/user/cart_repository.dart';
import 'package:bunbunmart/data/repository/user/order_repository.dart';
import 'package:bunbunmart/models/bun_colors.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'firebase_options.dart';

Future<void> main() async {
  //Widgets Binding
  final WidgetsBinding widgetsBinding =
      WidgetsFlutterBinding.ensureInitialized();

  //Init Local Storage
  await GetStorage.init();

  //Await Native Splash
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);

  //Initialize Firebase & Authentication Repository
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  ).then((FirebaseApp value) => Get.put(AuthenticationRepository()));

  //
  await Supabase.initialize(
    url: 'https://vcvmyhovmdiefdtfdhic.supabase.co',
    anonKey:
        'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InZjdm15aG92bWRpZWZkdGZkaGljIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NDY5Mjk3MzMsImV4cCI6MjA2MjUwNTczM30.dKShReo1zNWOu6I_JCehWjPnvtGZKtnT5k2fXUWDWSE',
  );

  // ----- User -----
  Get.put(UserController());
  Get.put(ProfileController());
  Get.put(CategoryController());
  Get.put(UserSearchController());
  Get.put(AddressController());

  Get.put(CartRepository());
  Get.put(CartController());
  Get.put(CheckoutController());
  Get.put(OrderRepository());
  Get.put(OrderController());

  // ----- Seller -----
  Get.put(ProductRepository());
  Get.put(ProductController());
  Get.put(SellerRepository());

  runApp(const BunBunMart());
}

class BunBunMart extends StatelessWidget {
  const BunBunMart({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      initialBinding: GeneralBindings(),
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: BunColors.beige,
        body: Center(child: CircularProgressIndicator(color: BunColors.navy)),
      ), // Placeholder while redirecting
    );
  }
}
