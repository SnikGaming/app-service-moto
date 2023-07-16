import '../APIBASE.dart';
import 'model.dart';

class APIFavorites {
  static List<Data> data = [];
  static int total = 0;
  static Future<List<Data>> getData({
    int page = 1,
  }) async {
    try {
      data = [];
      final response =
          await ApiBase.get(path: '/api/favorites/', queryParameters: {
        "page": page,
      });
      final jsonData = response.data;
      final List<dynamic> projectListJson = jsonData['data'];

      total = jsonData['total_pages'];

      final List<Data> projectList = projectListJson
          .map((projectJson) => Data.fromJson(projectJson))
          .toList();
      data = projectList;

      return projectList;
    } catch (e) {
      return [];
    }
  }
}
