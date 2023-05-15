// ignore_for_file: depend_on_referenced_packages

import 'package:intl/intl.dart';

String formatCurrency({required String amount}) {
  if (amount.isEmpty) return "";

  int? value = int.tryParse(amount);
  if (value == null) return "";

  return "${value.toString().replaceAllMapped(
        RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
        (Match m) => '${m[1]}.',
      )}đ";
}
