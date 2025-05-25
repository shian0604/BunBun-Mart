import 'package:bunbunmart/data/repository/authentication_repository.dart';
import 'package:bunbunmart/data/repository/user/search_repository.dart';
import 'package:bunbunmart/models/search_model.dart';
import 'package:bunbunmart/pages/features/bun_search.dart';
import 'package:bunbunmart/utilities/popups/bun_loaders.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class UserSearchController extends GetxController {
  static UserSearchController get instance => Get.find();

  final userSearchRepo = Get.put(UserSearchRepository());
  final searchController = TextEditingController();
  final isLoading = false.obs;
  final RxString searchKeyword = ''.obs;

  /// Save input and navigate to results
  Future<void> navigateToSearchResults() async {
    try {
      final keyword = searchController.text.trim();
      if (keyword.isEmpty) return;

      isLoading.value = true;

      // Get current user ID
      final userId = AuthenticationRepository.instance.authUser?.uid;
      if (userId == null) throw 'User not authenticated';

      // Save search to Firestore
      final search = UserSearch(
        id: '',
        keyword: keyword,
        timestamp: DateTime.now(),
        userId: userId, // Include user ID
      );

      await userSearchRepo.saveSearchKeyword(search);
      searchController.clear();

      // Navigate to BunBunSearch with keyword
      Get.off(() => BunBunSearch(searchKeyword: keyword));
    } catch (e) {
      BunSnackBar.bunwarning(title: "Oops! 🐾", message: e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> searchWithoutNavigation() async {
    try {
      final keyword = searchController.text.trim();
      if (keyword.isEmpty) return;

      isLoading.value = true;

      final userId = AuthenticationRepository.instance.authUser?.uid;
      if (userId == null) throw 'User not authenticated';

      final search = UserSearch(
        id: '',
        keyword: keyword,
        timestamp: DateTime.now(),
        userId: userId,
      );

      await userSearchRepo.saveSearchKeyword(search);

      // Update keyword and trigger UI updates
      searchKeyword.value = keyword;
      update(); // triggers GetBuilder

      searchController.clear();

    } catch (e) {
      BunSnackBar.bunwarning(title: "Oops! 🐾", message: e.toString());
    } finally {
      isLoading.value = false;
    }
  }
}
