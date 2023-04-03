// ignore_for_file: depend_on_referenced_packages

import 'package:intl/intl.dart';

extension DateTimeExt on DateTime {
  String format(String formatPattern) => DateFormat(formatPattern).format(this);
}
