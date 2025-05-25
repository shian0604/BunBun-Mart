import 'package:bunbunmart/data/cloud_helper_functions.dart';
import 'package:bunbunmart/data/controller/user/address_controller.dart';
import 'package:bunbunmart/models/bun_colors.dart';
import 'package:bunbunmart/models/size_configs.dart';
import 'package:bunbunmart/pages/features/address/add_address.dart';
import 'package:bunbunmart/pages/features/address/adress_card.dart';
import 'package:bunbunmart/pages/features/bun_settings.dart';
import 'package:bunbunmart/utilities/layout/buttons/back_button.dart';
import 'package:bunbunmart/utilities/layout/containers/bunbun_container.dart';
import 'package:bunbunmart/utilities/layout/texts/bun_text.dart';
import 'package:bunbunmart/utilities/social_icons.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BunBunAddress extends StatefulWidget {
  const BunBunAddress({super.key});

  @override
  State<BunBunAddress> createState() => _BunBunAddressState();
}

class _BunBunAddressState extends State<BunBunAddress> {
  @override
  Widget build(BuildContext context) {
    final controller = Get.put(AddressController());

    BunSizeConfig.init(context);

    return Scaffold(
      floatingActionButton: CircularIcons(
        imagepath: "assets/icons/plus.png",
        imageheight: 16,
        imagewidth: 16,
        height: 36,
        width: 36,
        color: BunColors.navy,
        onPressed: () => Get.to(() => AddAddress()),
      ),
      body: Container(
        width: BunSizeConfig.screenWidth,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [BunColors.navy, BunColors.navy, BunColors.beige],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
          image: DecorationImage(
            image: AssetImage('assets/screentone/tone.jpg'),
            fit: BoxFit.cover,
            alignment: Alignment.bottomCenter,
            repeat: ImageRepeat.noRepeat,
            opacity: 0.03,
          ),
        ),

        child: SafeArea(
          child: SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Column(
              children: [
                Stack(
                  children: [
                    Transform.translate(
                      offset: Offset(0, BunSizeConfig.blockSizeVertical * 0.8),
                      child: Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: BunPageContainer(
                          color: BunColors.white,
                          padding: EdgeInsets.all(30.0),
                          child: Column(
                            children: [
                              SizedBox(
                                height: BunSizeConfig.blockSizeVertical * 20,
                              ),

                              Obx(
                                () => FutureBuilder(
                                  key: Key(controller.refreshData.value.toString()),
                                  future: controller.allUserAddress(),
                                  builder: (context, snapshot) {
                                    final response =
                                        CloudHelperFunctions.checkMultiRecordState(
                                          snapshot: snapshot,
                                        );
                                    if (response != null) return response;
                                
                                    final addresses = snapshot.data!;
                                    return ListView.builder(
                                      shrinkWrap: true,
                                      itemCount: addresses.length,
                                      itemBuilder:
                                          (_, index) => AdressCard(
                                            address: addresses[index],
                                            onTap: () => controller.selectAddress(addresses[index]),
                                            onPressed: () => controller.deleteAddressWarningPopup(addresses[index]),
                                          ),
                                    );
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),

                    Container(
                      width: BunSizeConfig.screenWidth,
                      height: 160,
                      padding: EdgeInsets.symmetric(horizontal: 30.0),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(80.0),
                          bottomRight: Radius.circular(80.0),
                        ),
                        color: BunColors.navy,
                      ),

                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          Align(
                            alignment: Alignment.centerLeft,
                            child: WhiteBackButton(
                              onPressed: () {
                                Get.to(() => BunBunSettings());
                              },
                            ),
                          ),

                          BunbunHeader(
                            header: "Address",
                            color: BunColors.white,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
