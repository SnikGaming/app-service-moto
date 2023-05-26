// ignore_for_file: non_constant_identifier_names

import 'package:app/modules/home/api/APIBASE.dart';

import 'models/review.dart';

class APIReview {
  static List<Data> apiData = [];
  static int totals = 0;
  static Future<int> add({required String json}) async {
    try {
      final response = await ApiBase.post(path: '/api/reviews', data: json);
      return response.statusCode!;
    } catch (e) {
      return 400;
    }
  }

  static Future<List<Data>> getData({
    int? id,
    int page = 1,
  }) async {
    try {
      final response =
          await ApiBase.get(path: '/api/reviews/$id', queryParameters: {
        "page": page,
      });
      final jsonData = response.data;

      final List<dynamic> dataJson = jsonData['data'];
      final total = jsonData['total_pages'];
      totals = total;
      final List<Data> data =
          dataJson.map((projectJson) => Data.fromJson(projectJson)).toList();
      print('review data send -> data a ');

      apiData = data;
      print('review data send -> data $jsonData');
      return data;
    } catch (e) {
      return [];
    }
  }
}
