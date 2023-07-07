// ignore_for_file: library_prefixes

import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import '../../api/address/model.dart' as Address;

import '../CusRichText/CusRichText.dart';

class SelectAddress extends StatelessWidget {
  const SelectAddress({
    super.key,
    required Address.Data? selectedAddress,
    Color? colorUser,
    Color? colorText,
    Color? titleColor,
  })  : _selectedAddress = selectedAddress,
        _colorUser = colorUser,
        _colorText = colorText,
        _titleColor = titleColor;

  final Address.Data? _selectedAddress;
  final Color? _colorUser;
  final Color? _colorText;
  final Color? _titleColor;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          flex: 9,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CusRichText(
                text: "Người nhận : ",
                titleColor: _titleColor,
                selectedAddress: _selectedAddress!.name!,
                color: _colorUser ?? Colors.blue,
              ),
              const SizedBox(
                height: 8,
              ),
              CusRichText(
                text: "Số điện thoại : ",
                titleColor: _titleColor,
                selectedAddress: _selectedAddress!.phoneNumber!,
                color: _colorText ?? Colors.black,
              ),
              const SizedBox(
                height: 8,
              ),
              CusRichText(
                text: "Địa chỉ : ",
                titleColor: _titleColor,
                selectedAddress:
                    '${_selectedAddress!.address!}, ${_selectedAddress!.ward!}, ${_selectedAddress!.district!}, ${_selectedAddress!.province!}.',
                color: _colorText ?? Colors.black,
              ),
            ],
          ),
        ),
        const Expanded(
          flex: 1,
          child: Icon(Ionicons.chevron_forward_outline),
        ),
      ],
    );
  }
}