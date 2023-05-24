import '../APIBASE.dart';

class APIOrder {
  static Future<int> addOrder({required String json}) async {
    try {
      final response =
          await ApiBase.post(path: '/api/orderDetails', data: json);
      if (response.statusCode == 200) {
        return 200;
      } else {
        return 400;
        // throw Exception("Failed to login");
      }
    } catch (e) {
      print('data test $e');
      return 400;
    }
  }
}
