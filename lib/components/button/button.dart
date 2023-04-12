import 'package:flutter/material.dart';

class ButtonCustom extends StatefulWidget {
  final double? height;
  final double? width;
  final Gradient? gradient;
  final Widget? child;
  final Color? color;
  final void Function()? ontap;
  const ButtonCustom(
      {this.ontap,
      this.child,
      this.gradient,
      this.height = 48,
      this.width = 1000,
      this.color,
      super.key});

  @override
  State<ButtonCustom> createState() => _ButtonCustomState();
}

class _ButtonCustomState extends State<ButtonCustom> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: widget.ontap,
      child: Container(
        height: widget.height,
        width: widget.width,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          gradient: widget.color == null
              ? widget.gradient ??
                  const LinearGradient(
                      colors: [Color(0xff5DACFA), Color(0xff9A8DFC)])
              : null,
          color: widget.color,
        ),
        child: widget.child,
      ),
    );
  }
}
