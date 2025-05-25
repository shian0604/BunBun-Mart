import 'package:cloud_firestore/cloud_firestore.dart';

class CategoryModel {
  String id;
  String name;
  String image;
  String parentId;
  bool isFeatured;

  CategoryModel({
    required this.id,
    required this.name,
    required this.image,
    this.parentId = '',
    required this.isFeatured,
  });

  //Empty helper function
  static CategoryModel empty() => CategoryModel(
    id: '',
    name: '',
    image: '',
    parentId: '',
    isFeatured: false,
  );

  //Convert model to Json Structure
  Map<String, dynamic> toJson() {
    return {
      'Name': name,
      'Image': image,
      'ParentId': parentId,
      'IsFeatured': isFeatured,
    };
  }

  // Create a ProductModel from a Firestore document snapshot
  factory CategoryModel.fromSnapshot(
    DocumentSnapshot<Map<String, dynamic>> document,
  ) {
    final data = document.data();
    if (data != null) {
      return CategoryModel(
        id: document.id,
        name: data['Name'] ?? '',
        image: data['Image'] ?? '',
        parentId: data['ParentId'] ?? '',
        isFeatured: data['IsFeatured'] == true,
      );
    } else {
      return CategoryModel.empty();
    }
  }
}
