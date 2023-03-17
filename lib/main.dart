import 'package:app/modules/app_module.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

void main(List<String> args) {
  runApp(ModularApp(module: AppModule(), child: const MyApp()));
}
