import 'package:flutter/material.dart';

class CheckBoxCustom extends StatefulWidget {
  final bool value;
  final bool? isCircleBorder;
  final double? radius;
  final void Function(bool?)? onChanged;
  const CheckBoxCustom(
      {super.key,
      this.isCircleBorder = false,
      this.radius,
      required this.value,
      required this.onChanged});

  @override
  State<CheckBoxCustom> createState() => _CheckBoxCustomState();
}

class _CheckBoxCustomState extends State<CheckBoxCustom> {
  @override
  Widget build(BuildContext context) {
    return Checkbox(
        activeColor: const Color(0xff06bbfb),
        checkColor: Colors.white,
        shape: widget.isCircleBorder!
            ? const CircleBorder()
            : RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(widget.radius ?? 0)),
        // fillColor: MaterialStateProperty.resolveWith(),
        value: widget.value,
        onChanged: widget.onChanged);
  }
}
