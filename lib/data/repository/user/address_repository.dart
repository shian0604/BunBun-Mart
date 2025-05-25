import 'package:bunbunmart/data/repository/authentication_repository.dart';
import 'package:bunbunmart/models/address_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class AddressRepository extends GetxController {
  static AddressRepository get instance => Get.find();

  final _db = FirebaseFirestore.instance;

  Future<String> addAddress(AddressModel address) async {
    try {
      final userId = AuthenticationRepository.instance.authUser!.uid;
      if (userId.isEmpty) {
        throw 'Unable to find user information, try again later';
      }

      final currentAddress = await _db
          .collection('Users')
          .doc(userId)
          .collection('Addresses')
          .add(address.toJson());
      return currentAddress.id;
    } catch (e) {
      throw "Something went wrong while fetching Address Information. Try again later";
    }
  }

  Future<List<AddressModel>> fetchUserAddress() async {
    try {
      final userId = AuthenticationRepository.instance.authUser!.uid;
      if (userId.isEmpty) {
        throw 'Unable to find user information, try again later';
      }

      final result =
          await _db
              .collection('Users')
              .doc(userId)
              .collection('Addresses')
              .get();
      return result.docs
          .map(
            (documentSnapshot) =>
                AddressModel.fromDocumentSnapshot(documentSnapshot),
          )
          .toList();
    } catch (e) {
      throw "Something went wrong while fetching Address Information. Try again later";
    }
  }

  Future<void> updateSelectedField(String addressId, bool selected) async {
    try {
      final userId = AuthenticationRepository.instance.authUser!.uid;
      await _db
          .collection('Users')
          .doc(userId)
          .collection('Addresses')
          .doc(addressId)
          .update({'selectedAddress': selected});
    } catch (e) {
      throw "Unable to update your address selection. Try again later";
    }
  }

  Future<void> deleteAddress(String addressId) async {
    try {
      final userId = AuthenticationRepository.instance.authUser!.uid;
      if (userId.isEmpty) {
        throw 'Unable to find user information, try again later';
      }

      await _db
          .collection('Users')
          .doc(userId)
          .collection('Addresses')
          .doc(addressId)
          .delete();
    } catch (e) {
      throw "Something went wrong while deleting the address. Try again later.";
    }
  }
}
