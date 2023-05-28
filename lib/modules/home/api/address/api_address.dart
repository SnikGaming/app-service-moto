import 'dart:convert';

import 'package:dio/dio.dart';

import '../APIBASE.dart';
import 'model.dart';

class APIAddress {
  static List<Data> lsData = [];
  static Future<Response> addAddress(Map<String, dynamic> addressData) async {
    try {
      final response = await ApiBase.post(
        path: '/api/address',
        data: addressData,
      );
      return response;
    } catch (error) {
      rethrow;
    }
  }

  static Future<Response> updateAddress(
      Map<String, dynamic> addressData, int id) async {
    try {
      final response = await ApiBase.post(
        path: '/api/address/$id',
        data: addressData,
      );
      return response;
    } catch (error) {
      rethrow;
    }
  }

  static Future<List<Data>> fetchAddress() async {
    try {
      final response = await ApiBase.get(path: '/api/address/');
      final jsonData = json.decode(response.toString());
      final List<dynamic> dataListJson = jsonData['data'];
      final List<Data> data =
          dataListJson.map((dataJson) => Data.fromJson(dataJson)).toList();
      lsData = data;
      return data;
    } catch (e) {
      return [];
    }
  }

  static Future<void> deleteAddress(int id) async {
    try {
      final response = await ApiBase.post(path: '/api/address_del/$id');
      // Xử lý kết quả nếu cần thiết
    } catch (error) {
      rethrow;
    }
  }
}
