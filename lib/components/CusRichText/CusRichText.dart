import 'package:flutter/material.dart';

import '../../modules/home/api/address/model.dart' as Address;

class CusRichText extends StatelessWidget {
  CusRichText({
    super.key,
    required String selectedAddress,
    Color? color,
    required String text,
  })  : _selectedAddress = selectedAddress,
        _text = text,
        _color = color;

  Color? _color;
  final String _text;
  final String _selectedAddress;

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        text: _text,
        style: DefaultTextStyle.of(context)
            .style
            .copyWith(fontWeight: FontWeight.bold),
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
