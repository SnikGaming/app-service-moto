import 'package:flutter/material.dart';

class MyTextStyle {
  static const normal = TextStyle(
      color: Colors.white,
      fontWeight: FontWeight.w600,
      fontSize: 16,
      letterSpacing: 1);

  static final title =
      MyTextStyle.normal.copyWith(fontWeight: FontWeight.w700, fontSize: 18);
}
