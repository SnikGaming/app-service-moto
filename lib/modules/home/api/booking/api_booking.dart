import 'dart:convert';
import 'package:app/components/message/message.dart';
import 'package:app/modules/home/api/booking/model.dart';
import 'package:app/network/connect.dart';
import 'package:app/preferences/user/user_preferences.dart';
import 'package:dio/dio.dart';

class APIBooking {
  static int toTal = 0;
  static List<Data> lsData = [];

  static Future<List<Data>> fetchBookings() async {
    try {
      final response = await Dio().get("${ConnectDb.url}/api/bookings/",
          options: Options(
              headers: {'Authorization': 'Bearer ${UserPrefer.getToken()}'}));
      final jsonData = json.decode(response.toString());
      final List<dynamic> bookingListJson = jsonData['data'];
      toTal = jsonData['last_page'];
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
      final response = await Dio().post(
        "${ConnectDb.url}/api/bookings/",
        data: data,
        options: Options(headers: {
          'Content-type': 'application/json',
          'Authorization': 'Bearer ${UserPrefer.getToken()}'
        }),
      );

      if (response.statusCode == 200) {
        return 200;
      }
    } catch (e) {
      return 400;
    }
  }
}
