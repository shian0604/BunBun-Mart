import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class ProfileController extends GetxController {
  final profileImageUrl = ''.obs;
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  void onInit() {
    super.onInit();
    loadProfileImage();
  }

  Future<void> loadProfileImage() async {
    final user = _auth.currentUser;
    if (user == null) return;

    try {
      // Try to find in Users collection first
      final userDoc = await _db.collection("Users").doc(user.uid).get();
      if (userDoc.exists && userDoc.data()?['profilePicture'] != null) {
        profileImageUrl.value = userDoc.data()!['profilePicture'];
        return;
      }

      // Fallback to Sellers collection
      final sellerDoc = await _db.collection("Sellers").doc(user.uid).get();
      if (sellerDoc.exists && sellerDoc.data()?['profilePicture'] != null) {
        profileImageUrl.value = sellerDoc.data()!['profilePicture'];
      }
    } catch (e) {
      print("Failed to load profile picture: $e");
    }
  }

  void updateProfileImageUrl(String newUrl) {
    profileImageUrl.value = '$newUrl?t=${DateTime.now().millisecondsSinceEpoch}';
  }
}
