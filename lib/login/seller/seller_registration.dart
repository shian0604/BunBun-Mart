import 'package:bunbunmart/login/seller/util/seller_regform.dart';
import 'package:bunbunmart/models/bun_colors.dart';
import 'package:bunbunmart/models/size_configs.dart';
import 'package:bunbunmart/pages/features/bun_settings.dart';
import 'package:bunbunmart/utilities/layout/buttons/back_button.dart';
import 'package:flutter/material.dart';

class BunBunSellerRegistration extends StatefulWidget {
  const BunBunSellerRegistration({super.key});

  @override
  State<BunBunSellerRegistration> createState() =>
      _BunBunSellerRegistrationState();
}

class _BunBunSellerRegistrationState extends State<BunBunSellerRegistration> {
  @override
  Widget build(BuildContext context) {
    BunSizeConfig.init(context);
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  width: BunSizeConfig.screenWidth,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20.0),
                    gradient: LinearGradient(
                      colors: [BunColors.lightbeige, BunColors.beige],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                    ),
                  ),

                  child: Column(
                    children: [
                      ClipRect(
                        child: Container(
                          padding: EdgeInsets.all(10.0),
                          width: double.infinity,
                          height: 260,
                          decoration: BoxDecoration(
                            color: Color(0xFF183B49),
                            image: DecorationImage(
                              image: AssetImage('assets/screentone/tone.jpg'),
                              fit: BoxFit.cover,
                              alignment: Alignment.bottomCenter,
                              repeat: ImageRepeat.noRepeat,
                              opacity: 0.03,
                            ),
                            borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(110),
                              bottomRight: Radius.circular(110),
                              topLeft: Radius.circular(20),
                              topRight: Radius.circular(20),
                            ),
                          ),

                          child: Stack(
                            children: [
                              Align(
                                alignment: Alignment.centerLeft,
                                child: WhiteBackButton(
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => BunBunSettings(),
                                      ),
                                    );
                                  },
                                ),
                              ),
                              Align(
                                alignment: Alignment.center,
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Text(
                                      "Sign Up",
                                      style: TextStyle(
                                        color: const Color(0xFFD3CAAB),
                                        fontSize: 36,
                                        fontFamily: 'DeliusSwashCaps',
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),

                                    SizedBox(height: 10),
                                    Text(
                                      "Become part of the BunBun Family!",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 12,
                                        fontFamily: 'Poppins',
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),

                      Transform.translate(
                        offset: Offset(0, -BunSizeConfig.blockSizeVertical * 8),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 30.0),
                          child: SellerRegForm(),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
