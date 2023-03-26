import 'dart:convert';
import 'package:app/models/products/products_model.dart';
import 'package:flutter/services.dart';

class ProductService {
  static Future<List<dynamic>> readJsonData() async {
    var jsonData = await rootBundle.loadString('assets/data/moto.json');
    var data = json.decode(jsonData);

    return data['products'];
  }

  static Future<List<ProductModel>> getAllProduct() async {
    List<ProductModel> lsResult = [];
    List<dynamic> data = await readJsonData();
    // print(data.toString());

    lsResult = data.map((e) => ProductModel.fromJson(e)).toList();
    // print(lsResult);
    return lsResult;
  }
}
