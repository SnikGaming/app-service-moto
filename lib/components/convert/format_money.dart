// ignore_for_file: depend_on_referenced_packages

import 'package:intl/intl.dart';

String formatCurrency({required String amount}) {
  if (amount.isEmpty) return "";

  int? value = int.tryParse(amount);
  if (value == null) return "";

  final format = NumberFormat.currency(locale: "vi_VN", symbol: "");

  if (value >= 1000000) {
    double result = value / 1000000.0;
    return "${format.format(result)} triệu đồng";
  } else if (value >= 1000) {
    return "${format.format(value)} đồng";
  } else {
    return "Hết hàng";
  }
}
