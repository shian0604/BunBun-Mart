import 'package:bunbunmart/data/repository/categories/category_repository.dart';
import 'package:bunbunmart/data/repository/network_manager.dart';
import 'package:bunbunmart/models/category_model.dart';
import 'package:bunbunmart/utilities/popups/bun_fullscreen_loader.dart';
import 'package:bunbunmart/utilities/popups/bun_loaders.dart';
import 'package:get/get.dart';

class CategoryController extends GetxController {
  static CategoryController get instance => Get.find();

  final isLoading = false.obs;
  final _categoryRepository = Get.put(CategoryRepository());
  RxList<CategoryModel> allCategories = <CategoryModel>[].obs;
  RxList<CategoryModel> featuredCategories = <CategoryModel>[].obs;
  
  var selectedCategory = ''.obs;
  void updateCategory(String category) => selectedCategory.value = category;

  @override
  void onInit() {
    super.onInit();
    fetchCategories();
  }

  Future<void> fetchCategories() async {
    try {
      //Show loader while loading categories
      isLoading.value = true;

      //Fetch categories from firebase
      final categories = await _categoryRepository.getAllCategories();

      //Check connection
      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        BunLoader.stopLoading();
        return;
      }

      //update the category list
      allCategories.assignAll(categories);
      featuredCategories.assignAll(
        allCategories
            .where(
              (category) => category.isFeatured && category.parentId.isEmpty,
            )
            .take(8)
            .toList(),
      );
      print("Loaded categories: ${categories.map((e) => e.name)}");

    } catch (e) {
      BunLoader.stopLoading();
      BunSnackBar.bunerror(title: "Error! 🐾", message: e.toString());
    } finally {
      isLoading.value = false;
    }
  }
}
