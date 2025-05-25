import 'package:bunbunmart/models/bun_colors.dart';
import 'package:bunbunmart/models/size_configs.dart';
import 'package:bunbunmart/pages/main_page.dart';
import 'package:bunbunmart/utilities/layout/bun_button.dart';
import 'package:bunbunmart/utilities/layout/containers/bunbun_container.dart';
import 'package:bunbunmart/utilities/layout/texts/bun_text.dart';
import 'package:bunbunmart/utilities/verification/imagewithtext.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BunOrderSuccess extends StatelessWidget {
  const BunOrderSuccess({super.key,});

  @override
  Widget build(BuildContext context) {
    BunSizeConfig.init(context);
    return Scaffold(
      backgroundColor: BunColors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: BunPageContainer(
              color: BunColors.lightbeige,
              padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 30.0),
              child: Center(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ImageWithText(
                      imagepath: "assets/bunbunmart/success.png",
                      title: "Your order was a success!",
                      text: "High paws, fur-parent! Your order has been completed!",
                    ),
                
                    SizedBox(height: 36),
                    BunButton(
                      padding: EdgeInsets.all(20.0),
                      onTap: () => Get.to(MainPage(selectedIndex: 1,)),
                      child: Center(
                        child: BTextBold(
                          text: "Continue",
                          color: BunColors.white,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
