import 'dart:convert';
import 'package:godgreat_app/global_variables.dart';
import 'package:godgreat_app/models/category.dart';
import 'package:http/http.dart' as http;

class CategoryController {
  //load the uploaded category
  Future<List<Category>> loadCategories() async {
    try {
      //send an http get request to load the categories
      http.Response response = await http.get(
        Uri.parse('$uri/api/categories'),
        headers: <String, String>{
          "Content-Type": "application/json; charset=UTF-8",
        },
      );

      print(response.body); // Print response body to check its structure

      if (response.statusCode == 200) {
        final List<dynamic> data = jsonDecode(response.body);
        List<Category> categories =
            data.map((category) => Category.fromJson(category)).toList();
        return categories;
      } else {
        throw Exception('Failed to load categories');
      }
    } catch (e) {
      print(e);
      throw Exception('Error loading Categories: $e');
    }
  }
}
