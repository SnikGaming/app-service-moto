// ignore_for_file: depend_on_referenced_packages

import 'package:intl/intl.dart';

DateTime stringToDateTime(String str) {
  final DateFormat format = DateFormat('yyyy-MM-dd HH:mm:ss');
  return format.parse(str);
}

String dateTimeToString(DateTime dateTime) {
  final DateFormat formatter = DateFormat('yyyy-MM-dd HH:mm:ss');
  final String formatted = formatter.format(dateTime);
  return formatted;
}
