import '../../../../preferences/user/user_preferences.dart';
import '../APIBASE.dart';
import 'model.dart';

class APIFavorites {
  static List<Data> data = [];
  static int total = 0;
  static Future<List<Data>> getData({
    int page = 1,
  }) async {
    String link = '/api/products/';
    try {
      final response = await ApiBase.get(path: link, queryParameters: {
        "page": page,
      });
      final jsonData = response.data;
      final List<dynamic> projectListJson = jsonData['data'];

      total = jsonData['total_pages'];

      final List<Data> projectList = projectListJson
          .map((projectJson) => Data.fromJson(projectJson))
          .toList();
      data = projectList;
      print('data products $jsonData');
      return projectList;
    } catch (e) {
      return [];
    }
  }
}
