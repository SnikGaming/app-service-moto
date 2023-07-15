// ignore_for_file: use_key_in_widget_constructors

import 'package:badges/badges.dart' as badges;
import 'package:flutter/material.dart';

import '../style/text_style.dart';

class MyBage extends StatelessWidget {
  const MyBage({
    required Widget child,
    required String value,
    Key? key,
  })  : _child = child,
        _value = value;

  final Widget _child;
  final String _value;

  @override
  Widget build(BuildContext context) {
    return badges.Badge(
      position: badges.BadgePosition.topEnd(top: -10, end: -12),
      showBadge: true,
      ignorePointer: false,
      onTap: () {},
      badgeContent: Text(_value, style: title1),
      badgeAnimation: const badges.BadgeAnimation.rotation(
        animationDuration: Duration(seconds: 1),
        colorChangeAnimationDuration: Duration(seconds: 1),
        loopAnimation: false,
        curve: Curves.fastOutSlowIn,
        colorChangeAnimationCurve: Curves.easeInCubic,
      ),
      badgeStyle: badges.BadgeStyle(
        shape: badges.BadgeShape.circle,
        badgeColor: _value == '' ? Colors.transparent : Colors.blue,
        padding: const EdgeInsets.all(5),
        borderRadius: const BorderRadius.all(Radius.circular(4)),
        elevation: 0,
      ),
      child: _child,
    );
  }
}
