import 'package:bunbunmart/models/size_configs.dart';
import 'package:bunbunmart/utilities/bun%20login/bun_loginform.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    BunSizeConfig.init(context);
    double paddingValue = BunSizeConfig.screenWidth * 0.1; // Responsive padding

    return Scaffold(
      backgroundColor: Colors.white,

      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.all(paddingValue * 0.1),
              child: Center(
                child: Container(
                  width: BunSizeConfig.screenWidth,
                  padding: EdgeInsets.symmetric(
                    horizontal: paddingValue,
                    vertical: BunSizeConfig.screenHeight * 0.05,
                  ),
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [Color(0xFFEFE8D8), Color(0xFFD3CAAB)],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                    ),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: BunLoginform(),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
