import 'package:app/api/APIBASE.dart';
import 'models/category.dart';

class APICategory {
  static List<Data> apiCategory = [];

  static Future<List<Data>> getData() async {
    try {
      final response = await ApiBase.get(path: '/api/categories');
      final jsonData = response.data;
      final List<dynamic> projectListJson = jsonData['data'];
      final List<Data> data = projectListJson
          .map((projectJson) => Data.fromJson(projectJson))
          .toList();
      apiCategory = data;

      return data;
    } catch (e) {
      apiCategory = [];
      return [];
    }
  }
}
