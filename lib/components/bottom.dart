// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';

Padding bottom_pop_up(BuildContext context) {
  return Padding(
      padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom * .5));
}
