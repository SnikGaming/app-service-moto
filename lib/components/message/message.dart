import 'package:app/components/button/mybutton.dart';
import 'package:app/components/message/style.dart';
import 'package:flash/flash.dart';
import 'package:flutter/material.dart';


import '../style/text_style.dart';

class Message {
  static void error(
      {required String message,
      required BuildContext context,
      Duration? duration,
      FlashPosition? flashPosition,
      FlashBehavior style = FlashBehavior.floating}) {
    showFlash(
      context: context,
      duration: duration ?? const Duration(seconds: timeMessage),
      persistent: true,
      builder: (_, controller) {
        return Flash(
          controller: controller,
          margin: const EdgeInsets.only(top: 25, left: 16, right: 16),
          borderRadius: BorderRadius.circular(6),
          backgroundColor: MyColors.lightRed,
          barrierDismissible: true,
          behavior: style,
          position: flashPosition ?? FlashPosition.top,
          child: FlashBar(
            content: Text(
              message,
              style: buttonSmall_1.copyWith(color: MyColors.error),
            ),
          ),
        );
      },
    );
  }

  static void success(
      {required String message,
      required BuildContext context,
      FlashPosition? flashPosition,
      FlashBehavior style = FlashBehavior.floating}) {
    showFlash(
      context: context,
      duration: const Duration(seconds: timeMessage),
      persistent: true,
      builder: (_, controller) {
        return Flash(
          controller: controller,
          margin: const EdgeInsets.only(top: 25, left: 16, right: 16),
          borderRadius: BorderRadius.circular(6),
          backgroundColor: MyColors.lightGreen,
          barrierDismissible: true,
          behavior: style,
          position: flashPosition ?? FlashPosition.top,
          child: FlashBar(
            content: Text(
              message,
              style: buttonSmall_1.copyWith(color: MyColors.success),
            ),
          ),
        );
      },
    );
  }

  static void warning(
      {required String message,
      required BuildContext context,
      FlashPosition? flashPosition,
      FlashBehavior style = FlashBehavior.floating}) {
    showFlash(
      context: context,
      duration: const Duration(seconds: timeMessage),
      persistent: true,
      builder: (_, controller) {
        return Flash(
          controller: controller,
          margin: const EdgeInsets.only(top: 25, left: 16, right: 16),
          borderRadius: BorderRadius.circular(6),
          backgroundColor: MyColors.lightYellow,
          barrierDismissible: true,
          behavior: style,
          position: flashPosition ?? FlashPosition.top,
          child: FlashBar(
            content: Text(
              message,
              style: buttonSmall_1.copyWith(color: MyColors.warning),
            ),
          ),
        );
      },
    );
  }
}
