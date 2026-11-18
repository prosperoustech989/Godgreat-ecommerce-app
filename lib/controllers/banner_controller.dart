import 'dart:convert';
import 'package:godgreat_app/models/banner_model.dart';
import 'package:godgreat_app/global_variables.dart';
import 'package:http/http.dart' as http;

class BannerController {
  //fetch banners
  Future<List<BannerModel>> loadBanners() async {
    try {
      // send an http get request to fetch Banners
      http.Response response = await http.get(
        Uri.parse('$uri/api/banners'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );
      print('RESPONSE BODY: ${response.body}');

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = jsonDecode(response.body);

        List<dynamic> bannersList = data['banners'] ?? [];

        List<BannerModel> banners =
            bannersList.map((banner) => BannerModel.fromJson(banner)).toList();

        return banners;
      } else {
        throw Exception('Failed to load Banners');
      }
    } catch (e) {
      throw Exception("Error loading banners: $e");
    }
  }
}
