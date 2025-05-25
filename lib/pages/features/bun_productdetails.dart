import 'package:bunbunmart/data/controller/user/cart_controller.dart';
import 'package:bunbunmart/data/validator/input_validator.dart';
import 'package:bunbunmart/models/bun_colors.dart';
import 'package:bunbunmart/models/product_model.dart';
import 'package:bunbunmart/models/size_configs.dart';
import 'package:bunbunmart/utilities/layout/bun_divider.dart';
import 'package:bunbunmart/utilities/layout/buttons/back_button.dart';
import 'package:bunbunmart/utilities/layout/containers/bunbun_container.dart';
import 'package:bunbunmart/utilities/layout/containers/bunbun_image.dart';
import 'package:bunbunmart/utilities/layout/product%20list/vertical_productlist.dart';
import 'package:bunbunmart/utilities/layout/textfields/white_inputfield.dart';
import 'package:bunbunmart/utilities/layout/texts/bun_text.dart';
import 'package:bunbunmart/utilities/layout/texts/my_subtitle.dart';
import 'package:bunbunmart/utilities/popups/bun_loaders.dart';
import 'package:bunbunmart/utilities/product%20details/color_selector.dart';
import 'package:bunbunmart/utilities/product%20details/review.dart';
import 'package:bunbunmart/utilities/product%20details/size_selector.dart';
import 'package:bunbunmart/utilities/social_icons.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BunProductDetails extends StatefulWidget {
  final ProductModel product;
  const BunProductDetails({super.key, required this.product});

  @override
  State<BunProductDetails> createState() => _BunProductDetailsState();
}

class _BunProductDetailsState extends State<BunProductDetails> {
  final CartController cartController = Get.put(CartController());

  @override
  Widget build(BuildContext context) {
    final controller = PageController();

    BunSizeConfig.init(context);

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.all(20.0),
                child: BunPageContainer(
                  padding: EdgeInsets.all(20.0),
                  color: BunColors.lightbeige,
                  child: Column(
                    children: [
                      Stack(
                        alignment: Alignment.center,
                        children: [
                          Align(
                            alignment: Alignment.centerLeft,
                            child: BunBackButton(
                              onPressed: () {
                                Get.back();
                              },
                            ),
                          ),
                          BunSubHeader(
                            header: "BunBun Mart",
                            color: BunColors.navy,
                          ),
                        ],
                      ),

                      BunDivider(
                        color: BunColors.beige,
                        indent: 0,
                        endIndent: 0,
                        thickness: 3,
                      ),
                      SizedBox(height: 20.0),
                      //Product Image
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 30.0),
                        child: SizedBox(
                          height: 340,
                          width: BunSizeConfig.screenWidth,
                          child: PageView(
                            physics: BouncingScrollPhysics(),
                            controller: controller,
                            scrollDirection: Axis.horizontal,
                            children:
                                widget.product.productImages.map((url) {
                                  return ClipRRect(
                                    borderRadius: BorderRadius.circular(20),
                                    child: Image.network(
                                      url,
                                      fit: BoxFit.cover,
                                    ),
                                  );
                                }).toList(),
                          ),
                        ),
                      ),

                      SizedBox(height: 10.0),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: BunbunSubText(
                          subtext:
                              '₱${widget.product.productPrice.toStringAsFixed(2)}',
                          color: BunColors.black,
                          size: 22,
                        ),
                      ),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: BunbunText(
                          text: widget.product.productName,
                          color: BunColors.black,
                          size: 16,
                        ),
                      ),

                      Row(
                        children: [
                          BunbunText(
                            text: "Stock: ",
                            color: BunColors.black,
                            size: 12,
                          ),

                          BunbunText(
                            text: widget.product.productStocks.toString(),
                            color: BunColors.black,
                            size: 12,
                            weight: FontWeight.w600,
                          ),
                        ],
                      ),

                      SizedBox(height: 10.0),
                      BunDivider(
                        color: BunColors.beige,
                        indent: 0,
                        endIndent: 0,
                        thickness: 3,
                      ),

                      //Color
                      SizedBox(height: 10.0),
                      Align(
                        alignment: Alignment.center,
                        child: BunbunText(
                          text: "Select Color:",
                          color: BunColors.black,
                        ),
                      ),
                      SizedBox(height: 10.0),
                      //Color Container
                      ColorSelector(
                        productColors: widget.product.productColors,
                        onColorSelected:
                            (color) => cartController.setColor(color),
                      ),

                      SizedBox(height: 10.0),
                      Align(
                        alignment: Alignment.center,
                        child: BunbunText(
                          text: "Select Size:",
                          color: BunColors.black,
                        ),
                      ),
                      SizedBox(height: 10.0),
                      //Size Selection
                      SizeSelector(
                        sizes: widget.product.productSizes,
                        onSizeSelected: (size) => cartController.setSize(size),
                      ),
                      SizedBox(height: 20.0),

                      // Quantity Input Section
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Align(
                            alignment: Alignment.centerLeft,
                            child: BunbunText(
                              text: "Quantity:",
                              color: BunColors.black,
                            ),
                          ),

                          SizedBox(width: 10),

                          Flexible(
                            flex: 2,
                            child: Obx(
                              () => TransparentInputField(
                                hintText:
                                    cartController.quantity.value.toString(),
                                width: BunSizeConfig.screenWidth,
                                validator: (value) => InputValidator.validateNumber('Quantity', value),
                                keyboardType: TextInputType.number,
                                onChanged: (val) {
                                  final parsed = int.tryParse(val);
                                  if (parsed != null && parsed > 0) {
                                    final clamped = parsed.clamp(
                                      1,
                                      widget.product.productStocks,
                                    );
                                    cartController.setQuantity(clamped);
                                    if (parsed > widget.product.productStocks) {
                                      BunSnackBar.bunwarning(
                                        title: "Stock limit",
                                        message:
                                            "Only ${widget.product.productStocks} piece(s) available.",
                                      );
                                    }
                                  }
                                },
                              ),
                            ),
                          ),

                          SizedBox(width: 10),

                          CircularIcons(
                            imagepath: "assets/icons/plus-b.png",
                            imageheight: 12,
                            imagewidth: 12,
                            color: BunColors.beige,
                            onPressed: () {
                              if (cartController.quantity.value <
                                  widget.product.productStocks) {
                                cartController.setQuantity(
                                  cartController.quantity.value + 1,
                                );
                              } else {
                                BunSnackBar.bunwarning(
                                  title: "Oops!",
                                  message: "Maximum available stock reached.",
                                );
                              }
                            },
                          ),

                          SizedBox(width: 10),

                          CircularIcons(
                            imagepath: "assets/icons/minus.png",
                            imageheight: 12,
                            imagewidth: 12,
                            color: BunColors.beige,
                            onPressed: () {
                              if (cartController.quantity.value > 1) {
                                cartController.setQuantity(
                                  cartController.quantity.value - 1,
                                );
                              }
                            },
                          ),
                        ],
                      ),

                      //Buttons
                      SizedBox(height: 10.0),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Flexible(
                            flex: 3,
                            child: ButtonContainer(
                              onTap: () async {
                                await cartController.addToCart(widget.product);
                              },
                              color: BunColors.navy,
                              height: 36,
                              width: BunSizeConfig.screenWidth,
                              child: Align(
                                alignment: Alignment.center,
                                child: BTextBold(
                                  text: "Add to Cart",
                                  color: BunColors.white,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(width: 10.0),
                          Flexible(
                            flex: 1,
                            child: CircularIcons(
                              imagepath: "assets/icons/heart.png",
                              imageheight: 36,
                              imagewidth: 36,
                              height: 36,
                              width: 36,
                              color: BunColors.beige,
                            ),
                          ),
                        ],
                      ),
                      //Description
                      SizedBox(height: 10.0),

                      // Seller Information
                      Container(
                        width: BunSizeConfig.screenWidth,
                        padding: EdgeInsets.all(10.0),
                        decoration: BoxDecoration(
                          color: BunColors.beige,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Align(
                                  alignment: Alignment.centerLeft,
                                  child: ClipOval(
                                    child:
                                        widget.product.profilePicture.isNotEmpty
                                            ? Image.network(
                                              widget.product.profilePicture,
                                              height: 50,
                                              width: 50,
                                              fit: BoxFit.cover,
                                              errorBuilder: (
                                                context,
                                                error,
                                                stackTrace,
                                              ) {
                                                return BunCircularImage(
                                                  imagepath:
                                                      "assets/profile/default_profile.jpg",
                                                  imageheight: 50,
                                                  imagewidth: 50,
                                                );
                                              },
                                            )
                                            : BunCircularImage(
                                              imagepath:
                                                  "assets/profile/default_profile.jpg",
                                              imageheight: 50,
                                              imagewidth: 50,
                                            ),
                                  ),
                                ),
                                SizedBox(width: 16),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    BTextBold(
                                      text:
                                          widget.product.storeName.isNotEmpty
                                              ? widget.product.storeName
                                              : "Unknown Seller",
                                      color: BunColors.black,
                                    ),
                                    BunbunText(
                                      text: "Seller Ratings: 99% | Online",
                                      color: BunColors.black,
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            BunProceedButton(),
                          ],
                        ),
                      ),

                      SizedBox(height: 10.0),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: BunbunSubText(
                          subtext: "Description",
                          color: Colors.black,
                        ),
                      ),
                      SizedBox(height: 10.0),
                      Container(
                        padding: EdgeInsets.all(10.0),
                        width: BunSizeConfig.screenWidth,
                        decoration: BoxDecoration(
                          color: BunColors.beige,
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        child: Column(
                          children: [
                            BunDetailsText(
                              text: widget.product.productDescription,
                              color: BunColors.black,
                            ),
                          ],
                        ),
                      ),
                      //Reviews
                      SizedBox(height: 10.0),
                      MySubtitle(
                        subtitle: "Reviews & Ratings",
                        containerColor: BunColors.beige,
                        padding: EdgeInsets.all(0),
                      ),
                      SizedBox(height: 20.0),

                      //Review
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 30.0),
                        child: Container(
                          padding: EdgeInsets.all(20.0),
                          width: BunSizeConfig.screenWidth,
                          height: 200,
                          decoration: BoxDecoration(
                            color: BunColors.white,
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          child: ListView(
                            physics: BouncingScrollPhysics(),
                            controller: controller,
                            scrollDirection: Axis.vertical,
                            children: [BunReview(), BunReview(), BunReview()],
                          ),
                        ),
                      ),

                      //Suggested Products
                      SizedBox(height: 10.0),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: BunbunSubText(
                          subtext: "Suggested Products",
                          color: Colors.black,
                        ),
                      ),
                      SizedBox(height: 10.0),
                      VerticalProductlist(
                        color: BunColors.white,
                        padding: EdgeInsets.symmetric(horizontal: 30.0),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
