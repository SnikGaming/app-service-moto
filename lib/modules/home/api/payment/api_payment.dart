import 'dart:convert';

import 'package:app/modules/home/api/payment/payment_model.dart';

import '../APIBASE.dart';

class APIPaymentMethod {
  static List<Data> lsData = [];
  static Future<List<Data>> fetchPayment() async {
    try {
      final response = await ApiBase.get(path: '/api/payment');
      final jsonData = json.decode(response.toString());
      final List<dynamic> dataListJson = jsonData['data'];
      var toTal = jsonData['last_page'];
      final List<Data> data =
          dataListJson.map((dataJson) => Data.fromJson(dataJson)).toList();
      lsData = data;
      print('data payment --> ${dataListJson}');
      return data;
    } catch (e) {
      return [];
    }
  }
}
