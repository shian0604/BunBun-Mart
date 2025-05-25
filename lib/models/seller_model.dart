import 'package:cloud_firestore/cloud_firestore.dart';

class SellerModel {
  final String id;
  String userRole;
  String fullName;
  String storeName;
  String email;
  String contactNumber;
  String businessType; 
  String pickupAddress;
  String productCategory;
  String shippingCourier;
  String profilePicture;

  SellerModel({
    required this.id,
    required this.userRole,
    required this.fullName,
    required this.storeName,
    required this.email,
    required this.contactNumber,
    required this.businessType,
    required this.pickupAddress,
    required this.productCategory,
    required this.shippingCourier,
    required this.profilePicture,
  });

  static SellerModel empty() => SellerModel(
    id: '',
    userRole: '',
    fullName: '',
    storeName: '',
    email: '',
    contactNumber: '',
    businessType: '',
    pickupAddress: '',
    productCategory: '',
    shippingCourier: '',
    profilePicture: '',
  );

  // Convert a SellerModel into a map (for Firestore)
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'userRole': userRole,
      'fullName': fullName,
      'storeName': storeName,
      'email': email,
      'contactNumber': contactNumber,
      'businessType': businessType,
      'pickupAddress': pickupAddress,
      'productCategory': productCategory,
      'shippingCourier': shippingCourier,
      'profilePicture': profilePicture,
    };
  }

  // Create a SellerModel from a Firestore document snapshot
  factory SellerModel.fromSnapshot(
    DocumentSnapshot<Map<String, dynamic>> document,
  ) {
    final data = document.data();
    if (data != null) {
      return SellerModel(
        id: document.id,
         userRole: data['userRole'] ?? '',
        fullName: data['fullName'] ?? '',
        storeName: data['storeName'] ?? '',
        email: data['email'] ?? '',
        contactNumber: data['contactNumber'] ?? '',
        businessType: data['businessType'] ?? '',
        pickupAddress: data['pickupAddress'] ?? '',
        productCategory: data['productCategory'] ?? '',
        shippingCourier: data['shipping Courier'] ?? '',
        profilePicture: data['profilePicture'] ?? '',
      );
    } else {
      return SellerModel.empty();
    }
  }
}
