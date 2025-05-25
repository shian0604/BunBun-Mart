import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  final String id;
  String userName;
  final String email;
  String phoneNumber;
  String profilePicture;
  String userRole;

  UserModel({
    required this.id,
    required this.userName,
    required this.email,
    required this.phoneNumber,
    required this.profilePicture,
    required this.userRole,
  });

  static UserModel empty() => UserModel(
    id: '',
    userName: '',
    email: '',
    phoneNumber: '',
    profilePicture: '',
    userRole: '',
  );

  // Convert a UserModel into a map (for Firestore)
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'userName': userName,
      'email': email,
      'phoneNumber': phoneNumber,
      'profilePicture': profilePicture,
      'userRole': userRole,
    };
  }

  // Create a UserModel from a Firestore document snapshot
  factory UserModel.fromSnapshot(
    DocumentSnapshot<Map<String, dynamic>> document,
  ) {
    final data = document.data();
    if (data != null) {
      return UserModel(
        id: document.id,
        userName: data['userName'] ?? '',
        email: data['email'] ?? '',
        phoneNumber: data['phoneNumber'] ?? '',
        profilePicture: data['profilePicture'] ?? '',
        userRole: data['userRole'] ?? '',
      );
    } else {
      return UserModel.empty();
    }
  }
}

