import 'package:bunbunmart/models/bun_colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BunSnackBar {
  static hideSnackBar() =>
      ScaffoldMessenger.of(Get.context!).hideCurrentSnackBar();

  static customtoast({required String message}) {
    ScaffoldMessenger.of(Get.context!).showSnackBar(
      SnackBar(
        elevation: 0,
        duration: const Duration(seconds: 3),
        backgroundColor: Colors.transparent,
        content: Container(
          padding: EdgeInsets.all(12.0),
          margin: EdgeInsets.symmetric(horizontal: 30.0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30.0),
            color: BunColors.beige,
          ),
          child: Center(
            child: Text(
              message,
              style: TextStyle(
                fontFamily: "Poppins",
                fontWeight: FontWeight.w600,
                fontSize: 16,
                color: Colors.black, // Add if needed
              ),
            ),
          ),
        ),
      ),
    );
  }

  static bunsuccess({required title, message = '', duration = 3}) {
    Get.snackbar(
      title,
      message,
      isDismissible: true,
      shouldIconPulse: true,
      backgroundColor: BunColors.boldGreen,
      snackPosition: SnackPosition.BOTTOM,
      duration: Duration(seconds: duration),
      margin: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 30.0),
      icon: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0),
        child: Image.asset("assets/icons/w-check.png", height: 32, width: 32),
      ),
      titleText: Text(
        title,
        style: TextStyle(
          fontFamily: "Poppins",
          fontWeight: FontWeight.w600,
          fontSize: 16,
          color: BunColors.white,
        ),
      ),
      messageText: Text(
        message,
        style: TextStyle(
          fontFamily: "Poppins",
          fontWeight: FontWeight.w400,
          fontSize: 12,
          color: BunColors.white,
        ),
      ),
    );
  }

  static bunwarning({required title, message = '', duration = 3}) {
    Get.snackbar(
      title,
      message,
      isDismissible: true,
      shouldIconPulse: true,
      backgroundColor: BunColors.goldenYellow,
      snackPosition: SnackPosition.BOTTOM,
      duration: Duration(seconds: duration),
      margin: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 30.0),
      icon: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0),
        child: Image.asset("assets/icons/w-warning.png", height: 32, width: 32),
      ),
      titleText: Text(
        title,
        style: TextStyle(
          fontFamily: "Poppins",
          fontWeight: FontWeight.w600,
          fontSize: 16,
          color: BunColors.white,
        ),
      ),
      messageText: Text(
        message,
        style: TextStyle(
          fontFamily: "Poppins",
          fontWeight: FontWeight.w400,
          fontSize: 12,
          color: BunColors.white,
        ),
      ),
    );
  }

  static bunerror({required title, message = '', duration = 3}) {
    Get.snackbar(
      title,
      message,
      isDismissible: true,
      shouldIconPulse: true,
      backgroundColor: BunColors.richRed,
      snackPosition: SnackPosition.BOTTOM,
      duration: Duration(seconds: duration),
      margin: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 30.0),
      icon: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0),
        child: Image.asset("assets/icons/w-error.png", height: 32, width: 32),
      ),
      titleText: Text(
        title,
        style: TextStyle(
          fontFamily: "Poppins",
          fontWeight: FontWeight.w600,
          fontSize: 16,
          color: BunColors.white,
        ),
      ),
      messageText: Text(
        message,
        style: TextStyle(
          fontFamily: "Poppins",
          fontWeight: FontWeight.w400,
          fontSize: 12,
          color: BunColors.white,
        ),
      ),
    );
  }
}
