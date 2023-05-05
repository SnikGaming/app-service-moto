import 'package:flutter/material.dart';

import '../../../../components/message/message.dart';
import '../booking/api_booking.dart';

class CreateData {
  static createBooking(
      {required BuildContext context,
      required Map<String, String> data}) async {
    var response = await APIBooking.createBooking(data: data);
    if (response == 200)
      return Message.success(
          message: "Đặt lịch thành công...!", context: context);
    return Message.success(message: "Đặt lịch thất bại...!", context: context);
  }
}
