import 'package:bunbunmart/data/controller/user/address_controller.dart';
import 'package:bunbunmart/models/address_model.dart';
import 'package:bunbunmart/models/bun_colors.dart';
import 'package:bunbunmart/models/size_configs.dart';
import 'package:bunbunmart/utilities/layout/containers/bunbun_image.dart';
import 'package:bunbunmart/utilities/layout/texts/bun_text.dart';
import 'package:bunbunmart/utilities/social_icons.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/get_state_manager.dart';

class AdressCard extends StatefulWidget {

  const AdressCard({super.key, required this.address, required this.onTap, required this.onPressed});

  final AddressModel address;
  final VoidCallback onTap;
  final VoidCallback onPressed;

  @override
  State<AdressCard> createState() => _AdressCardState();
}

class _AdressCardState extends State<AdressCard> {
  final controller = AddressController.instance;
  @override
  Widget build(BuildContext context) {
    BunSizeConfig.init(context);
    return Obx(
      () { 
        final selectedAddressId = controller.selectedAddress.value.id;
        final selectedAddress = selectedAddressId == widget.address.id;

        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 6.0),
          child: InkWell(
          onTap: widget.onTap,
          child: Container(
            width: BunSizeConfig.screenWidth,
            padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 30.0),
            decoration: BoxDecoration(
              color: selectedAddress ? BunColors.navy : BunColors.white,
              borderRadius: BorderRadius.circular(20),
              border: Border.all(
                color:
                    selectedAddress
                        ? Colors.transparent
                        : BunColors.black.withOpacity(0.5),
                width: 1.5,
              ),
            ),
          
            child: Stack(
              children: [
                if (selectedAddress)
                  Positioned(
                    right: 2,
                    top: 2,
                    child: BunCircularImage(
                      imageheight: 16,
                      imagewidth: 16,
                      imagepath: "assets/icons/checked.png",
                    ),
                  ),
          
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    BTextBold(
                      text: widget.address.recipient,
                      color:
                          selectedAddress ? BunColors.white : BunColors.black,
                      maxLiness: 1,
                    ),
                    SizedBox(height: 3),
                    BunbunText(
                      text: widget.address.phoneNumber,
                      color:
                          selectedAddress ? BunColors.white : BunColors.black,
                    ),
          
                    BunbunText(
                      text: widget.address.toString(),
                      size: 10,
                      color:
                          selectedAddress ? BunColors.white : BunColors.black,
                    ),
          
                    
          
                    SizedBox(height: 3),
                    Align(
                      alignment: Alignment.bottomRight,
                      child: CircularIcons(
                        onPressed: widget.onPressed,
                        imagepath: "assets/seller/remove.png",
                        imageheight: 10,
                        imagewidth: 10,
                        color: BunColors.richRed,
                        padding: EdgeInsets.all(0),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
                ),
        );
      }
    );
  }
}
