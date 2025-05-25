import 'package:bunbunmart/models/bun_colors.dart';
import 'package:bunbunmart/pages/seller/seller_homepage.dart';
import 'package:bunbunmart/pages/seller/seller_manageorders.dart';
import 'package:bunbunmart/pages/seller/seller_products.dart';
import 'package:bunbunmart/pages/seller/seller_profile.dart';
import 'package:flutter/material.dart';

class SellerMainPage extends StatefulWidget {
  final int selectedIndex;
  const SellerMainPage({super.key, this.selectedIndex = 2});

  @override
  State<SellerMainPage> createState() => _HomePageState();
}

class _HomePageState extends State<SellerMainPage> {
  late int selectedIndex;

  @override
  void initState() {
    super.initState();
    selectedIndex = widget.selectedIndex;
  }

  final List pages = [
    const SellerProducts(),
    const SellerManageOrders(),
    const SellerHomePage(),
    const SellerProfile(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: BunColors.white,

      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: BottomNavigationBar(
            showSelectedLabels: false,
            showUnselectedLabels: false,
            elevation: 0,
            backgroundColor: BunColors.navy,
            unselectedItemColor: BunColors.white,
            selectedItemColor: BunColors.white.withOpacity(0.5),
            type: BottomNavigationBarType.fixed,
            currentIndex: selectedIndex,
            onTap: (value) {
              setState(() {
                selectedIndex = value;
              });
            },
            items: [
              BottomNavigationBarItem(
                icon: Image.asset('assets/seller/nav bar/bun_products.png', width: 32, height: 32,),
                label: '',
              ),
              BottomNavigationBarItem(
                icon: Image.asset('assets/seller/nav bar/bun_orders.png', width: 32, height: 32,),
                label: '',
              ),
              BottomNavigationBarItem(
                icon: Image.asset('assets/icons/home.png'),
                label: '',
              ),
              BottomNavigationBarItem(
                icon: Image.asset('assets/icons/circle-user.png'),
                label: '',
              ),
            ],
          ),
        ),
      ),

      body: pages[selectedIndex],
    );
  }
}
