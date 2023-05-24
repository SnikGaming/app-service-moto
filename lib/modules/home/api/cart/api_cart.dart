import 'package:app/modules/home/api/cart/model.dart';

import '../APIBASE.dart';
import '../login/api_login.dart';

class ApiCart {
  static List<Data> lsCart = [];
  static Future<int> apiCart({required int id, required int quantity}) async {
    try {
      final response = await ApiBase.post(
          path: '/api/carts', data: {"product_id": id, "quantity": quantity});
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

  static Future<int> apiDeleteCarts({required List<int> cartIds}) async {
    try {
      final data = {"cart": []};

      // Add cart IDs to the data
      cartIds.forEach((id) {
        data["cart"]?.add({"id": id});
      });

      final response = await ApiBase.post(path: '/api/carts_del', data: data);
      if (response.statusCode == 200) {
        return 200;
      } else {
        return 400;
      }
    } catch (e) {
      print('Error: $e');
      return 400;
    }
  }

  static Future<List<Data>> getData() async {
    try {
      final response = await ApiBase.get(path: '/api/carts/');
      final jsonData = response.data;
      final List<dynamic> dataCartJson = jsonData['data'];
      final total = jsonData['total_pages'];
      final List<Data> dataCart = dataCartJson
          .map((projectJson) => Data.fromJson(projectJson))
          .toList();
      print('data test $dataCartJson');
      lsCart = dataCart;
      return dataCart;
    } catch (e) {
      lsCart = [];
      return [];
    }
  }
}
