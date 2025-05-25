import 'package:bunbunmart/data/repository/network_manager.dart';
import 'package:bunbunmart/utilities/popups/bun_fullscreen_loader.dart';
import 'package:bunbunmart/utilities/popups/bun_loaders.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

Future<void> uploadImage(Function(String) onSuccess) async {
  final user = FirebaseAuth.instance.currentUser;
  if (user == null) return;

  final result = await FilePicker.platform.pickFiles(type: FileType.image);
  if (result != null && result.files.single.bytes != null) {
    final fileBytes = result.files.single.bytes!;
    final fileName = '${user.uid}/profile_picture.png';
    final storage = Supabase.instance.client.storage;
    final publicUrl = storage.from('user-images').getPublicUrl(fileName);

    try {
      BunLoader.openLoadingDialog("Wiggling our tails... Uploading your profile...");

      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        BunLoader.stopLoading();
        return;
      }

      // Attempt to delete existing profile picture
      try {
        await storage.from('user-images').remove([fileName]);
      } catch (e) {
        print('No existing profile picture to delete: $e');
      }

      // Upload new profile picture
      await storage.from('user-images').uploadBinary(
        fileName,
        fileBytes,
        fileOptions: const FileOptions(cacheControl: '3600', upsert: true),
      );

      // Update in Firestore
      final docRefUsers = FirebaseFirestore.instance.collection("Users").doc(user.uid);
      final docRefSellers = FirebaseFirestore.instance.collection("Sellers").doc(user.uid);
      final userDoc = await docRefUsers.get();
      final sellerDoc = await docRefSellers.get();

      if (userDoc.exists) {
        await docRefUsers.update({'profilePicture': publicUrl});
      } else if (sellerDoc.exists) {
        await docRefSellers.update({'profilePicture': publicUrl});
      } else {
        throw "No user or seller found with this ID.";
      }

      // Done
      BunLoader.stopLoading();
      onSuccess(publicUrl);

      BunSnackBar.bunsuccess(
        title: "Profile Updated!",
        message: "Your profile picture has been successfully updated!",
      );

      print('Uploaded and updated Firestore: $fileName');
    } on StorageException catch (e) {
      BunLoader.stopLoading();
      BunSnackBar.bunerror(
        title: "Upload Error 🐾",
        message: e.toString(),
      );
    } catch (e) {
      BunLoader.stopLoading();
      BunSnackBar.bunerror(
        title: "Yikes! Something went wrong 🐾",
        message: e.toString(),
      );
      print('Unexpected error: $e');
    }
  } else {
    print('No file selected.');
  }
}

//get picture
String getProfileImageUrl() {
  final user = FirebaseAuth.instance.currentUser;
  if (user == null) return ''; // Return empty string if no user is logged in

  final storage = Supabase.instance.client.storage;
  final url = storage
      .from('user-images')
      .getPublicUrl('${user.uid}/profile_picture.png');

  print('Generated profile image URL: $url'); // Debugging line
  return url;
}
