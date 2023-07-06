// ignore_for_file: file_names

import 'package:flutter/material.dart';

Future<bool> onWillPop(
    BuildContext context, int index, Function(int) setIndex) async {
  if (index == 0) {
    return (await showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text('Bạn có chắc không?'),
            content: const Text('Bạn có muốn thoát ứng dụng không?'),
            actions: <Widget>[
              TextButton(
                onPressed: () => Navigator.of(context).pop(false),
                child: const Text('Không'),
              ),
              TextButton(
                onPressed: () => Navigator.of(context).pop(true),
                child: const Text('Có'),
              ),
            ],
          ),
        )) ??
        false;
  } else {
    setIndex(0);
    return false;
  }
}
