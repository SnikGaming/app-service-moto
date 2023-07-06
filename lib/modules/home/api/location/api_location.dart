import 'dart:convert';

import 'package:app/modules/home/api/location/model.dart';

import '../APIBASE.dart';

class APILocation {
  static List<Data> dataLocation = [];
  static Future<List<Data>> fetchLocation() async {
    final response = await ApiBase.get(path: '/api/location');
    final jsonData = json.decode(response.toString());
    final List<dynamic> bookingListJson = jsonData['data'];
    // toTal = jsonData['last_page'];
    final List<Data> dataJson = bookingListJson
        .map((bookingJson) => Data.fromJson(bookingJson))
        .toList();
    // lsData = dataJson;
    dataLocation = dataJson;
    return dataLocation;
  }
}
