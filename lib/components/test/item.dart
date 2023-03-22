import 'package:app/modules/home/layouts/pages/home_page.dart';
import 'package:app/modules/home/layouts/pages/services_page.dart';
import 'package:flutter/material.dart';

import '../../modules/home/layouts/pages/test.dart';

// ignore: must_be_immutable
class ItemTest extends StatefulWidget {
  Color? color;
  ItemTest({super.key, this.color});

  @override
  State<ItemTest> createState() => _ItemTestState();
}

class _ItemTestState extends State<ItemTest> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
        height: size.height,
        width: size.width,
        color: widget.color ?? Colors.purple,
      ),
    );
  }
}

// ignore: non_constant_identifier_names
List<Widget> TestScreen = [
  const HomePage(),
  const ServicesPage(),
  const CupertinoCalendar(),
  ItemTest(
    color: Colors.red,
  ),
  ItemTest(
    color: Colors.white,
  ),
  ItemTest(
    color: Colors.black,
  ),
  ItemTest(),
];
