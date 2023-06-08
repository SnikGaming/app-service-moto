// ignore_for_file: file_names, must_be_immutable

import 'package:flutter/material.dart';

class CusRichText extends StatelessWidget {
  const CusRichText({
    super.key,
    required String selectedAddress,
    Color? color,
    Color? titleColor,
    required String text,
  })  : _selectedAddress = selectedAddress,
        _text = text,
        _color = color,
        _titleColor = titleColor;

  final Color? _color;
  final Color? _titleColor;

  final String _text;
  final String _selectedAddress;

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        text: _text,
        style: DefaultTextStyle.of(context)
            .style
            .copyWith(fontWeight: FontWeight.bold, color: _titleColor),
        children: <TextSpan>[
          TextSpan(
            text: _selectedAddress,
            style: TextStyle(
              fontWeight: FontWeight.normal,
              color: _color,
            ),
          ),
        ],
      ),
    );
  }
}
