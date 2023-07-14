// ignore_for_file: non_constant_identifier_names

import 'dart:convert';

import 'package:app/api/order/order_details.dart';

import '../APIBASE.dart';

class APIOrderDetails {
  static List<Data> data = [];
  static Future<List<Data>> fetchOrder({required  id}) async {
    try {
      final response = await ApiBase.get(path: '/api/orderDetails/$id');
      final jsonData = json.decode(response.toString());
      final List<dynamic> dataListJson = jsonData['data'];

      final List<Data> Order =
          dataListJson.map((dataJson) => Data.fromJson(dataJson)).toList();
      data = Order;
      return Order;
    } catch (e) {
      return [];
    }
  }
}
