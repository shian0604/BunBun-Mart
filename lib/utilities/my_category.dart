import 'package:bunbunmart/data/controller/seller/shop/category_controller.dart';
import 'package:bunbunmart/models/bun_colors.dart';
import 'package:bunbunmart/pages/main_page.dart';
import 'package:bunbunmart/utilities/layout/texts/bun_text.dart';
import 'package:bunbunmart/utilities/popups/bun_shimmer.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MyCategory extends StatefulWidget {
  const MyCategory({super.key});

  @override
  State<MyCategory> createState() => _MyCategoryState();
}

class _MyCategoryState extends State<MyCategory> {
  final categoryController = Get.put(CategoryController());
  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (categoryController.isLoading.value) {
        return const BunShimmerEffect(width: 60, height: 60);
      }

      if (categoryController.featuredCategories.isEmpty) {
        return Center(
          child: BTextBold(text: "No Data Found", color: BunColors.black),
        );
      }

      return SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30.0),
          child: Row(
            children: List.generate(
              categoryController.featuredCategories.length,
              (index) {
                final categoryList =
                    categoryController.featuredCategories[index];
                return InkWell(
                  child: GestureDetector(
                    onTap: () {
                      final currentCategory =
                          categoryController.selectedCategory.value;

                      if (currentCategory != categoryList.name) {
                        categoryController.updateCategory(categoryList.name);
                      }
                      Get.offAll(() => MainPage(selectedIndex: 0));
                    },
                    child: Column(
                      children: [
                        Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: 15.0,
                            vertical: 3.5,
                          ),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            gradient: LinearGradient(
                              colors: [
                                BunColors.navy,
                                BunColors.gray,
                                BunColors.beige,
                              ],
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                            ),
                          ),
                          child: Container(
                            padding: EdgeInsets.all(4.0),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              shape: BoxShape.circle,
                            ),
                            child: CircleAvatar(
                              radius: 35,

                              backgroundColor: Colors.white,
                              backgroundImage: NetworkImage(categoryList.image),
                            ),
                          ),
                        ),
                        SizedBox(height: 10),

                        Text(
                          categoryList.name,
                          style: TextStyle(
                            fontFamily: "Poppins",
                            fontSize: 12,
                            color: Colors.black,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ),
      );
    });
  }
}
