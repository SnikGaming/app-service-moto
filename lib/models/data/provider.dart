import 'dart:convert';

import 'package:flutter/services.dart';

import 'model_data.dart';

class ProviderServices {
  static Future<List<dynamic>> readJsonData() async {
    var jsonData = await rootBundle.loadString('assets/data/data.json');
    var data = json.decode(jsonData);

    return data;
  }

  static Future<List<ProductData>> getAllProduct() async {
    List<ProductData> lsResult = [];
    List<dynamic> data = await readJsonData();
    // print(data.toString());

    lsResult = data.map((e) => ProductData.fromJson(e)).toList();
    print(lsResult[0].title);
    return lsResult;
  }
}
