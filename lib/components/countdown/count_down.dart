import 'package:flutter/material.dart';
import 'package:timer_count_down/timer_count_down.dart';

countdown(context, contdown) {
  return Countdown(
    controller: contdown,
    seconds: 180,
    build: (_, double time) {
      String value = settime(time);
      return Text(
        value.toString(),
        style: const TextStyle(
            fontSize: 18, fontFamily: 'time', color: Colors.green),
      );
    },
    interval: const Duration(milliseconds: 100),
    onFinished: () {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Timer is done!'),
        ),
      );
    },
  );
}

String settime(double time) {
  var data = time.toString().split('.');
  return data[0];
}
