// ignore_for_file: use_build_context_synchronously

import 'package:app/components/from/forgotpassword/frm_forgotpassword.dart';
import 'package:app/constants/constants.dart';

import 'package:app/modules/home/api/otp/otp_api.dart';
import 'package:flutter/material.dart';
import 'package:otp_text_field/otp_field.dart';
import 'package:otp_text_field/style.dart';
import 'package:timer_count_down/timer_controller.dart';

import '../../countdown/count_down.dart';

Future<void> displayTextInputDialog(BuildContext context, otp, email) async {
  final controller_ = CountdownController(autoStart: true);

  showDialog(
    barrierDismissible: false,
    context: context,
    builder: (context) {
      return Builder(
        builder: (BuildContext dialogContext) {
          return AlertDialog(
            actions: [
              IconButton(
                onPressed: () {
                  controller_.restart();
                },
                icon: const Icon(
                  Icons.refresh,
                  color: Colors.green,
                ),
              ),
              IconButton(
                onPressed: () {
                  Navigator.pop(dialogContext);
                },
                icon: const Icon(
                  Icons.close,
                  color: Colors.red,
                ),
              ),
            ],
            title: Text(
              'Please input OTP code',
              style: SettingApp.fontSignNegative.copyWith(
                fontSize: 18,
                letterSpacing: 1.2,
              ),
            ),
            content: SizedBox(
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
                      print('pin----> $pin');
                    },
                    onCompleted: (pin) async {
                      var res = await APIOtp.checkOtp(email: email, otp: pin);
                      if (res == 200) {
                        Navigator.pop(dialogContext);
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (_) =>
                                    PasswordInputDialog(email: email)));
                      } else {
                        otp.clear();
                      }
                    },
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  countdown(context, controller_),
                ],
              ),
            ),
          );
        },
      );
    },
  );
}
