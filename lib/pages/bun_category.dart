import 'package:bunbunmart/data/controller/seller/shop/category_controller.dart';
import 'package:bunbunmart/models/bun_colors.dart';
import 'package:bunbunmart/utilities/layout/containers/bunbun_container.dart';
import 'package:bunbunmart/utilities/layout/product%20list/category_productlist.dart';
import 'package:bunbunmart/utilities/layout/texts/bun_text.dart';
import 'package:bunbunmart/utilities/my_category.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BunBunCategory extends StatefulWidget {
  const BunBunCategory({Key? key}) : super(key: key);

  @override
  State<BunBunCategory> createState() => _BunBunCategoryState();
}

class _BunBunCategoryState extends State<BunBunCategory> {
  final controller = Get.find<CategoryController>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: BunColors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 30.0,
                  vertical: 10.0,
                ),
                child: BunBunContainer(
                  child: Center(
                    child: BunbunHeader(
                      header: "Category",
                      color: BunColors.lightbeige,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 20.0),

              //Categories
              MyCategory(),

              Padding(
                padding: const EdgeInsets.only(
                  left: 30.0,
                  right: 30.0,
                  top: 20.0,
                  bottom: 10.0,
                ),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: BunbunSubText(
                    subtext:
                        controller.selectedCategory.value.isNotEmpty
                            ? controller.selectedCategory.value
                            : 'All Products',
                    color: BunColors.black,
                  ),
                ),
              ),
              Obx(
                () => CategoryProductlist(
                  color: BunColors.lightbeige,
                  categoryName: controller.selectedCategory.value,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
