class Category {
  final String imagepath, categoryname;
  Category({required this.imagepath, required this.categoryname});
}

List<Category> category = [
  Category(imagepath: "assets/category/category1.jpg", categoryname: "Pet food"),
  Category(imagepath: "assets/category/category2.jpg", categoryname: "Toys"),
  Category(imagepath: "assets/category/category3.jpg", categoryname: "Furniture"),
  Category(imagepath: "assets/category/category4.jpg", categoryname: "Outdoor"),
  Category(imagepath: "assets/category/category5.jpg", categoryname: "Pet Essentials"),
];

String selectedStatus = "Pet Food";

final List<String> categoryList = [
  "Pet Food",
  "Toys",
  "Furniture",
  "Outdoor",
  "Pet Essentials",
];
