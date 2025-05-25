import 'package:bunbunmart/pages/bun_cart.dart';
import 'package:bunbunmart/pages/bun_category.dart';
import 'package:bunbunmart/pages/bun_profile.dart';
import 'package:bunbunmart/pages/home_page.dart';
import 'package:flutter/material.dart';

class MainPage extends StatefulWidget {
  final int selectedIndex;
  const MainPage({super.key, this.selectedIndex = 2});

  @override
  State<MainPage> createState() => _HomePageState();
}

class _HomePageState extends State<MainPage> {
  late int selectedIndex;

  @override
  void initState() {
    super.initState();
    selectedIndex = widget.selectedIndex;
  }

  final List pages = [
    const BunBunCategory(),
    const BunBunCart(),
    const BunBunHomePage(),
    const BunBunProfile(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: BottomNavigationBar(
            showSelectedLabels: false,
            showUnselectedLabels: false,
            elevation: 0,
            backgroundColor: Color(0xFF183B49),
            unselectedItemColor: Colors.white,
            selectedItemColor: Colors.white.withOpacity(0.5),
            type: BottomNavigationBarType.fixed,
            currentIndex: selectedIndex,
            onTap: (value) {
              setState(() {
                selectedIndex = value;
              });
            },
            items: [
              BottomNavigationBarItem(
                icon: Image.asset('assets/icons/category.png'),
                label: '',
              ),
              BottomNavigationBarItem(
                icon: Image.asset('assets/icons/shopping-cart.png'),
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
