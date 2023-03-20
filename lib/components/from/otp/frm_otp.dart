import 'package:flutter/material.dart';
import 'package:otp_text_field/otp_field.dart';
import 'package:otp_text_field/style.dart';
import 'package:timer_count_down/timer_controller.dart';

import '../../countdown/count_down.dart';

Future<void> displayTextInputDialog(BuildContext context, otp) async {
  final controller_ = CountdownController(autoStart: true);
  return showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) {
        return AlertDialog(
            actions: [
              IconButton(
                onPressed: () {
                  controller_.restart();
                },
                icon: Icon(
                  Icons.refresh,
                  color: Colors.green,
                ),
              ),
              IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: Icon(
                  Icons.close,
                  color: Colors.red,
                ),
              )
            ],
            title: const Text('Please input OTP code'),
            content: Container(
              height: 100,
              child: Column(
                children: [
                  OTPTextField(
                    controller: otp,
                    length: 5,
                    width: MediaQuery.of(context).size.width,
                    textFieldAlignment: MainAxisAlignment.spaceAround,
                    fieldWidth: 45,
                    fieldStyle: FieldStyle.box,
                    outlineBorderRadius: 15,
                    style: const TextStyle(fontSize: 17),
                    onChanged: (pin) {
                      print("Changed: $pin");
                    },
                    onCompleted: (pin) {
                      print("Completed: $pin");
                      Navigator.pop(context);
                      otp.clear();
                    },
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  countdown(context, controller_),
                ],
              ),
            ));
      });
}
