import 'dart:convert';

import 'package:app/modules/home/api/booking/model.dart';
import 'package:app/preferences/user/user_preferences.dart';
import 'package:http/http.dart' as http;

import '../../../../network/connect.dart';

class APIBooking {
  static int toTal = 0;
  static List<Data> lsData = [];
  static Future<List<Data>> fetchBookings() async {
    try {
      final response = await http.get(
          Uri.parse("http://${ConnectDb.ip}/api/bookings/"),
          headers: {'Authorization': 'Bearer ${UserPrefer.getToken()}'});
      final jsonData = json.decode(response.body);
      // print('Booking data');

      final List<dynamic> bookingListJson = jsonData['data'];
      toTal = jsonData['last_page'];
      // print('Booking data: $bookingListJson');
      // print('Booking data: ${APIBooking.toTal}');

      final List<Data> bookings = bookingListJson
          .map((bookingJson) => Data.fromJson(bookingJson))
          .toList();
      lsData = bookings;
      return bookings;
    } catch (e) {
      // print('Error getting bookings: $e');
      return [];
    }
  }
}
