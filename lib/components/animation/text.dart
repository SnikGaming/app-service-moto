import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';

import '../../constants/colors.dart';
import '../../preferences/settings/setting_prefer.dart';

class MyTextAnimated {
  static const colorizeColors = [
    Colors.purple,
    Colors.blue,
    Colors.yellow,
    Colors.red,
  ];

  static const colorizeTextStyle = TextStyle(
    fontSize: 30.0,
    fontFamily: 'Sono', //'Horizon',
  );
  static itemColorize(text, {TextStyle? textStyle, List<Color>? colors}) {
    return ColorizeAnimatedText(
      text,
      textStyle: textStyle ?? colorizeTextStyle,
      colors: colors ?? colorizeColors,
    );
  }

  static Widget Colorize({required List<AnimatedText> animatedTexts}) {
    return SizedBox(
      // width: 250.0,
      child: AnimatedTextKit(
        animatedTexts: animatedTexts,
        isRepeatingAnimation: true,
        onTap: () {
          print("Tap Event");
        },
      ),
    );
  }

  static Widget Wavy() => DefaultTextStyle(
        style: TextStyle(
          fontSize: 20.0,
          color: SettingPrefer.getLightDark() == null ||
                  SettingPrefer.getLightDark()
              ? black
              : white,
        ),
        child: AnimatedTextKit(
          animatedTexts: [
            WavyAnimatedText('Hello World'),
            WavyAnimatedText('Above is the reference price from SNIK',
                textAlign: TextAlign.center,
                speed: const Duration(milliseconds: 100)),
          ],
          isRepeatingAnimation: true,
          onTap: () {
            print("Tap Event");
          },
        ),
      );
}
