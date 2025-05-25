import 'dart:typed_data';

import 'package:bunbunmart/data/controller/seller/product_controller.dart';
import 'package:bunbunmart/data/validator/input_validator.dart';
import 'package:bunbunmart/models/bun_colors.dart';
import 'package:bunbunmart/models/category_list.dart';
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
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddProduct extends StatefulWidget {
  const AddProduct({super.key});

  @override
  State<AddProduct> createState() => _AddProductState();
}

class _AddProductState extends State<AddProduct> {
  final List<Uint8List> _selectedImages = [];
  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ProductController());

    controller.clearForm();
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
                    key: controller.productFormKey,
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
                          text: "Add New Product",
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
                          controller: controller.productName,
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
                        BunDropdown(
                          items: categoryList,
                          onChanged: (selectedValue) {
                            controller.setSelectedCategory(selectedValue);
                            print("Selected category: $selectedValue");
                          },
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
                          controller: controller.productPrice,
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
                          controller: controller.productStocks,
                          onChanged: (value) {
                            controller.productStocks.text = value.toString();
                            print("Selected quantity: $value");
                          },
                          initialValue: 1,
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
                        SizePickerChips(
                            availableSizes: controller.productSizes,
                            onSelectionChanged: (sizes) {
                              controller.toggleSize(sizes);
                              print('Selected sizes updated: $sizes');
                            },
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
                          availableColors: controller.productColors,
                          onSelectionChanged: (selected) {
                            controller.toggleColor(selected);
                            print("Selected colors: $selected");
                          },
                          textcontroller: controller.customColorController,
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
                          controller: controller.productDescription,
                          validator:
                              (value) =>
                                  InputValidator.validateProductDescription(
                                    value,
                                  ),
                        ),
                        SizedBox(height: 12),

                        Align(
                          alignment: Alignment.centerLeft,
                          child: BTextBold(
                            text: "Product Images:",
                            color: BunColors.black,
                          ),
                        ),
                        SizedBox(height: 6),
                        ProductImagePickerAdaptive(
                          onImagesSelected: (images) {
                            _selectedImages.clear(); // Clear previous images
                            _selectedImages.addAll(
                              images,
                            ); // Store selected images
                            print("Selected images: ${_selectedImages.length}");
                          },
                        ),

                        SizedBox(height: 12),
                        BunButton(
                          onTap: () => controller.saveProduct(_selectedImages),
                          padding: EdgeInsets.all(20.0),
                          radius: BorderRadius.circular(10),
                          child: Center(
                            child: BTextBold(
                              text: "Add Product",
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
