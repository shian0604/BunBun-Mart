import 'package:bunbunmart/models/bun_colors.dart';
import 'package:bunbunmart/models/size_configs.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class PopupLoader extends StatelessWidget {
  final String message;

  const PopupLoader({super.key, this.message = "Loading..."});

  @override
  Widget build(BuildContext context) {
    BunSizeConfig.init(context);
    return Dialog(
      backgroundColor: Colors.transparent,
      elevation: 0,
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: BunColors.white,
          borderRadius: BorderRadius.circular(50),
        ),
        child: Transform.translate(
          offset: Offset(0, -BunSizeConfig.blockSizeVertical * 1.5),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(
                height: 160,
                width: 160,
                child: Lottie.asset(
                  'assets/animations/bun_loading.json',
                  fit: BoxFit.contain,
                ),
              ),
              Transform.translate(
                offset: Offset(0, -BunSizeConfig.blockSizeVertical * 1.5),
                child: Center(child: 
                Text(message, style: TextStyle(
                  fontFamily: "Poppins",
                  fontWeight: FontWeight.w600,
                  fontSize: 12,
                  color: BunColors.black,
                ),),)
              ),
            ],
          ),
        ),
      ),
    );
  }
}
