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
          Uri.parse("${ConnectDb.url}/api/bookings/"),
          headers: {'Authorization': 'Bearer ${UserPrefer.getToken()}'});
      final jsonData = json.decode(response.body);
      // print('Booking data');

      final List<dynamic> bookingListJson = jsonData['data'];
      toTal = jsonData['last_page'];
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

  //!: Create booking
  static createBooking({required Map<String, String> data}) async {
    try {
      // data ??
      //     {
      //       "note": "Please change oilsad and check brakes.",
      //       "booking_time": "2023-09-29 14:30:00",
      //       "address": "1227 Huỳnh Tấn Phát, Quận 7, TP.HCM",
      //       "service": "abc",
      //       "mechanic_id": '3'
      //     };
      final response = await http.post(
        Uri.parse("${ConnectDb.url}/api/bookings/"),
        body: json.encode(data),
        headers: {
          'Content-type': 'application/json',
          'Authorization': 'Bearer ${UserPrefer.getToken()}'
        },
      );
      if (response.statusCode == 200) {
        return 200;
      }
    } catch (e) {
      return 400;
    }
  }
}
