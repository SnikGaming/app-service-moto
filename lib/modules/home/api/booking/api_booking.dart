import 'dart:convert';
import 'package:app/modules/home/api/booking/model.dart';

import '../APIBASE.dart';

class APIBooking {
  static int toTal = 0;
  static List<Data> lsData = [];

  static Future<List<Data>> fetchBookings() async {
    try {
      final response = await ApiBase.get(path: '/api/bookings/');
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
}
