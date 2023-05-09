import 'package:app/modules/home/api/banner/model.dart';
import 'package:dio/dio.dart';
import '../../../../network/connect.dart';

class APIBanner {
  static List<Data> apiBanner = [];
  static Future<List<Data>> getData() async {
    try {

      final response = await Dio().get("${ConnectDb.url}/api/banners/");
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
