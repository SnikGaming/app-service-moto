import 'dart:convert';
import 'package:app/api/booking/model.dart';

import '../APIBASE.dart';

class APIBooking {
  static int toTal = 0;
  static List<Data> lsData = [];

  static Future<List<Data>> fetchBookings({int? type = 1}) async {
    try {
      final response = await ApiBase.get(path: '/api/bookings?order_by=$type');
      final jsonData = json.decode(response.toString());
      final List<dynamic> bookingListJson = jsonData['data'];
      toTal = jsonData['total_items'];
      final List<Data> bookings = bookingListJson
          .map((bookingJson) => Data.fromJson(bookingJson))
          .toList();
      lsData = bookings;
      return bookings;
    } catch (e) {
      return [];
    }
  }

  static createBooking({required Map<String, String> data}) async {
    try {
      final response = await ApiBase.post(path: '/api/bookings/', data: data);
      if (response.statusCode == 200) {
        return 200;
      }
    } catch (e) {
      return 400;
    }
  }

  static updateBooking(
      {required Map<String, String> data, required int id}) async {
    try {
      final response =
          await ApiBase.post(path: '/api/bookings/${id}', data: data);
      if (response.statusCode == 200) {
        return 200;
      }
    } catch (e) {
      return 400;
    }
  }

  static delBooking({required int id}) async {
    try {
      final response = await ApiBase.post(path: '/api/bookings/$id/status');
      if (response.statusCode == 200) {
        return 200;
      }
    } catch (e) {
      return 400;
    }
  }
}
