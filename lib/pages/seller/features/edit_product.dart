import 'dart:typed_data';
import 'package:bunbunmart/data/controller/seller/edit_product_controller.dart';
import 'package:bunbunmart/data/validator/input_validator.dart';
import 'package:bunbunmart/models/bun_colors.dart';
import 'package:bunbunmart/models/category_list.dart';
import 'package:bunbunmart/models/product_model.dart';
import 'package:bunbunmart/pages/seller/seller_mainpage.dart';
import 'package:bunbunmart/pages/seller/utils/add%20product/color_pickerchips.dart';
import 'package:bunbunmart/pages/seller/utils/add%20product/product_imagepicker.dart';
import 'package:bunbunmart/pages/seller/utils/add%20product/size_pickerchips.dart';
import 'package:bunbunmart/pages/seller/utils/bun_dropdown.dart';
import 'package:bunbunmart/utilities/layout/bun_button.dart';
import 'package:bunbunmart/utilities/layout/buttons/back_button.dart';
import 'package:bunbunmart/utilities/layout/containers/bunbun_container.dart';
import 'package:bunbunmart/pages/seller/utils/add%20product/quantity_inputfield.dart';
import 'package:bunbunmart/utilities/layout/textfields/white_inputfield.dart';
import 'package:bunbunmart/utilities/layout/texts/bun_text.dart';
import 'package:bunbunmart/utilities/popups/bun_loaders.dart';
import 'package:bunbunmart/utilities/social_icons.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class EditProduct extends StatefulWidget {
  final ProductModel product;

  const EditProduct({super.key, required this.product});

  @override
  State<EditProduct> createState() => _EditProductState();
}

class _EditProductState extends State<EditProduct> {
  final List<Uint8List> _updatedImages = [];

  @override
  void initState() {
    super.initState();
    final controller = Get.put(EditProductController());
    controller.initializeProductData(widget.product); // Load product data
  }

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<EditProductController>();
    return Scaffold(
      backgroundColor: BunColors.lightbeige,
      body: SafeArea(
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(30.0),
                child: BunPageContainer(
                  color: BunColors.white,
                  padding: EdgeInsets.symmetric(
                    vertical: 20.0,
                    horizontal: 30.0,
                  ),
                  radius: BorderRadius.circular(50),
                  child: Form(
                    key: controller.editProductFormKey,
                    child: Column(
                      children: [
                        Stack(
                          alignment: Alignment.center,
                          children: [
                            Align(
                              alignment: Alignment.centerLeft,
                              child: BunBackButton(
                                onPressed: () {
                                  Get.off(
                                    () => SellerMainPage(selectedIndex: 0),
                                  );
                                },
                              ),
                            ),
                            BunbunHeader(
                              header: "BunBun Mart",
                              color: BunColors.beige,
                            ),
                          ],
                        ),
                        BTextBold(
                          text: "Edit Product",
                          color: BunColors.navy,
                          size: 14,
                        ),

                        SizedBox(height: 24),

                        Align(
                          alignment: Alignment.centerLeft,
                          child: BTextBold(
                            text: "Product Name:",
                            color: BunColors.black,
                          ),
                        ),
                        SizedBox(height: 6),
                        BorderInputField(
                          hintText: "Product Name",
                          controller: controller.productController.productName,
                          validator:
                              (value) =>
                                  InputValidator.validateProductName(value),
                        ),
                        SizedBox(height: 12),

                        Align(
                          alignment: Alignment.centerLeft,
                          child: BTextBold(
                            text: "Product Category:",
                            color: BunColors.black,
                          ),
                        ),
                        SizedBox(height: 6),
                        Obx(
                          () => BunDropdown(
                            items: categoryList,
                            initialValue:
                                controller
                                    .productController
                                    .selectedCategory
                                    .value,
                            onChanged: (selectedValue) {
                              controller.productController.setSelectedCategory(
                                selectedValue,
                              );
                              print("Selected category: $selectedValue");
                            },
                          ),
                        ),
                        SizedBox(height: 12),

                        Align(
                          alignment: Alignment.centerLeft,
                          child: BTextBold(
                            text: "Product Price:",
                            color: BunColors.black,
                          ),
                        ),
                        SizedBox(height: 6),
                        BorderInputField(
                          hintText: "Product Price",
                          controller: controller.productController.productPrice,
                          keyboardType: TextInputType.number,
                          validator:
                              (value) =>
                                  InputValidator.validateProductPrice(value),
                        ),
                        SizedBox(height: 12),

                        Align(
                          alignment: Alignment.centerLeft,
                          child: BTextBold(
                            text: "Available Quantity/Stock:",
                            color: BunColors.black,
                          ),
                        ),
                        SizedBox(height: 6),
                        QuantityInput(
                          controller:
                              controller.productController.productStocks,
                          onChanged: (value) {
                            controller.productController.productStocks.text =
                                value.toString();
                            print("Selected quantity: $value");
                          },
                          initialValue:
                              int.tryParse(
                                controller.productController.productStocks.text,
                              ) ??
                              1,
                          max: 999,
                          min: 1,
                        ),
                        SizedBox(height: 12),

                        Align(
                          alignment: Alignment.centerLeft,
                          child: BTextBold(
                            text: "Available Sizes:",
                            color: BunColors.black,
                          ),
                        ),
                        SizedBox(height: 6),
                        Obx(
                          () => SizePickerChips(
                            availableSizes:
                                controller.productController.productSizes,
                            initialSelectedSizes:
                                controller.productController.selectedSizes
                                    .toList(),
                            onSelectionChanged: (sizes) {
                              controller.productController.toggleSize(sizes);
                              print('Selected sizes updated: $sizes');
                            },
                          ),
                        ),
                        SizedBox(height: 12),

                        Align(
                          alignment: Alignment.centerLeft,
                          child: BTextBold(
                            text: "Available Colors:",
                            color: BunColors.black,
                          ),
                        ),
                        SizedBox(height: 6),
                        ColorPickerChips(
                          availableColors:
                              controller.productController.productColors,
                          onSelectionChanged: (selected) {
                            controller.productController.toggleColor(selected);
                            print("Selected colors: $selected");
                          },
                          textcontroller:
                              controller
                                  .productController
                                  .customColorController,
                          validator:
                              (value) =>
                                  InputValidator.validateCustomColor(value),
                        ),
                        SizedBox(height: 12),

                        Align(
                          alignment: Alignment.centerLeft,
                          child: BTextBold(
                            text: "Product Description:",
                            color: BunColors.black,
                          ),
                        ),
                        SizedBox(height: 6),
                        DescriptionInputField(
                          controller:
                              controller.productController.productDescription,
                          validator:
                              (value) =>
                                  InputValidator.validateProductDescription(
                                    value,
                                  ),
                        ),
                        SizedBox(height: 12),

                        Obx(() {
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const BTextBold(
                                text: "Product Images",
                                color: BunColors.black,
                              ),
                              const SizedBox(height: 6),

                              // Existing Images
                              if (controller.existingImageUrls.isNotEmpty)
                                SizedBox(
                                  height: 110,
                                  child: ListView.separated(
                                    scrollDirection: Axis.horizontal,
                                    itemCount:
                                        controller.existingImageUrls.length,
                                    separatorBuilder:
                                        (_, __) => const SizedBox(width: 10),
                                    itemBuilder: (context, index) {
                                      final imageUrl =
                                          controller.existingImageUrls[index];
                                      return Stack(
                                        children: [
                                          ClipRRect(
                                            borderRadius: BorderRadius.circular(
                                              8,
                                            ),
                                            child: Image.network(
                                              imageUrl,
                                              width: 100,
                                              height: 100,
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                          Positioned(
                                            top: 2,
                                            right: 2,
                                            child: CircularIcons(
                                              imagepath:
                                                  "assets/icons/minus_w.png",
                                              imageheight: 8,
                                              imagewidth: 8,
                                              height: 24,
                                              width: 24,
                                              padding: EdgeInsets.all(0),
                                              color: BunColors.navy,
                                              onPressed:
                                                  () => controller
                                                      .deleteExistingImage(
                                                        imageUrl,
                                                      ),
                                            ),
                                          ),
                                        ],
                                      );
                                    },
                                  ),
                                ),

                              // New Selected Images
                              ProductImagePickerAdaptive(
                                onImagesSelected: (images) {
                                  final totalImages =
                                      controller.existingImageUrls.length +
                                      images.length;

                                  if (totalImages > 5) {
                                    BunSnackBar.bunwarning(
                                      title: "Limit Exceeded",
                                      message:
                                          "You can only upload a maximum of 5 images in total.",
                                    );
                                    return;
                                  }

                                  _updatedImages.clear();
                                  _updatedImages.addAll(images);
                                  controller.newSelectedImages.assignAll(
                                    images,
                                  );
                                },
                              ),
                            ],
                          );
                        }),

                        SizedBox(height: 12),
                        BunButton(
                          onTap: () {
                            controller.updateProductData(
                              newImages: _updatedImages,
                            );
                          },
                          padding: EdgeInsets.all(20.0),
                          radius: BorderRadius.circular(10),
                          child: Center(
                            child: BTextBold(
                              text: "Update Product",
                              color: BunColors.white,
                            ),
                          ),
                        ),
                      ],
                    ),
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
