import 'package:app/api/APIBASE.dart';
import 'package:app/api/banner/model.dart';

class APIBanner {
  static List<Data> apiBanner = [];
  static Future<List<Data>> getData() async {
    try {
      final response = await ApiBase.get(path: '/api/banners');
      final jsonData = response.data;
      final List<dynamic> projectListJson = jsonData['data'];
      final List<Data> data = projectListJson
          .map((projectJson) => Data.fromJson(projectJson))
          .toList();
      apiBanner = data;

      return data;
    } catch (e) {
      // print('data $e');
      return [];
    }
  }
}
