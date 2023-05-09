import 'package:dio/dio.dart';
import '../../../../network/connect.dart';
import 'models/category.dart';

class APICategory {
  static List<Data> apiCategory = [];

  static Future<List<Data>> getData() async {
    try {
      final dio = Dio();
      final response = await dio.get(
        "${ConnectDb.url}/api/categories/",
        // options: Options(headers: {'Authorization': 'Bearer $token'}),
      );
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
