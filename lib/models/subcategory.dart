import 'dart:convert';

class Subcategory {
  final String id;
  final String categoryId;
  final String categoryName;
  final String image;
  final String subCategoryName; 

  Subcategory({
    required this.id,
    required this.categoryId,
    required this.categoryName,
    required this.image,
    required this.subCategoryName,
  });

  // Convert Subcategory instance into a Map Object for JSON transmission
  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'categoryId': categoryId,
      'categoryName': categoryName,
      'image': image,
      'subCategoryName': subCategoryName,
    };
  }

  String toJson() => json.encode(toMap());

  // Factory Constructor to build a clean Subcategory model directly from your Database Map
  factory Subcategory.fromJson(Map<String, dynamic> map) {
    return Subcategory(
      id: (map['_id'] ?? map['id'] ?? '') as String,
      categoryId: (map['categoryId'] ?? '') as String,
      categoryName: (map['categoryName'] ?? '') as String,
      image: (map['image'] ?? '') as String,
      subCategoryName: (map['subcategoryName'] ?? '') as String,
    );
  }
}
