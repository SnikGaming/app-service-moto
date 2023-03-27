import 'dart:convert';

import 'package:app/models/services/service_model.dart';
import 'package:flutter/services.dart';

class ProviderService {
  static Future<List<dynamic>> readJsonData() async {
    var jsonData = await rootBundle.loadString('assets/data/service.json');
    var data = json.decode(jsonData);

    return data['services'];
  }

  static Future<List<ServiceModel>> getAllService() async {
    List<ServiceModel> lsResult = [];
    List<dynamic> data = await readJsonData();
    // print(data.toString());
    lsResult = data.map((e) => ServiceModel.fromJson(e)).toList();
    // print(lsResult);
    return lsResult;
  }
}
