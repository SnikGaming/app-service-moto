import 'package:app/components/button/style_mybutton.dart';
import 'package:flutter/material.dart';

class MyButton extends StatefulWidget {
  final Widget? icons;

  final Function()? onPressed;
  final double? borderSideWidth;
  final Color? borderColor;
  final Widget child;

  final bool? disable;

  final CustomSize? size;

  final double? height;

  final double? width;

  final Color? backgroundColor;

  final CustomColor? primaryColor;

  final BorderSide? borderside;

  final double? radius;

  const MyButton({
    this.borderColor,
    this.borderSideWidth,
    required this.onPressed,
    this.disable = false,
    this.backgroundColor = const Color(0xff3169B3),
    this.borderside,
    required this.child,
    this.height,
    this.icons,
    this.primaryColor = CustomColor.defaults,
    this.size,
    this.radius = 6.0,
    this.width,
    super.key,
  });

  @override
  State<MyButton> createState() => _MyButtonState();

  // ignore: non_constant_identifier_names
}

class _MyButtonState extends State<MyButton> {
  @override
  Widget build(BuildContext context) {
    return widget.icons == null
        ? TextButton(
            onPressed: widget.disable! ? () {} : widget.onPressed,
            style: TextButton.styleFrom(
                backgroundColor:
                    !widget.disable! ? _backgoundColor() : Colors.grey,
                foregroundColor:
                    widget.disable! ? Colors.grey : Colors.transparent,
                minimumSize: Size(_sizeButton(isHeight: false), _sizeButton()),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(_radius()),
                ),
                side: _borderside()),
            child: widget.child,
          )
        : TextButton.icon(
            onPressed: widget.onPressed,
            icon: widget.icons!,
            label: widget.child,
            style: TextButton.styleFrom(
              backgroundColor: _backgoundColor(),
              minimumSize: Size(_sizeButton(isHeight: false), _sizeButton()),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(_radius()),
                  side: _borderside()),
            ),
          );
  }

  double _sizeButton({bool? isHeight = true}) {
    double height = 48;
    double width = 1000;
    if (isHeight!) {
      if ((widget.size == null || widget.size == CustomSize.defaults) &&
          widget.height == null) {
        height = 48;
      } else if (widget.size != null && widget.height == null) {
        switch (widget.size) {
          case CustomSize.defaults:
            {
              height = 48;
            }
            break;
          case CustomSize.small:
            {
              height = 36;
            }
            break;
          default:
            height = 36;
        }
      } else {
        height = widget.height!;
      }
      return height;
    } else {
      if ((widget.size == null || widget.size == CustomSize.defaults) &&
          widget.width == null) {
        width = 1000;
      } else if (widget.size != null && widget.width == null) {
        switch (widget.size) {
          case CustomSize.defaults:
            {
              width = 1000;
            }
            break;
          case CustomSize.small:
            {
              width = 163;
            }
            break;
          case CustomSize.fit:
            {
              width = 0;
            }
            break;
          default:
            width = 215;
        }
      } else {
        width = widget.width!;
      }
      return width;
    }
  }

  double _radius() {
    double radius = 6;
    if (widget.radius == null &&
        (widget.size == null ||
            widget.size == CustomSize.defaults ||
            widget.size == CustomSize.fit)) {
      radius = 6;
    } else if (widget.radius != null) {
      radius = widget.radius!;
    } else {
      radius = 30;
    }

    return radius;
  }

  Color _backgoundColor() {
    Color primaryColor;
    if (widget.backgroundColor == null &&
        (widget.primaryColor == null ||
            widget.primaryColor == CustomColor.defaults)) {
      primaryColor = const Color(0xff3169B3);
    } else if (widget.backgroundColor != null) {
      primaryColor = widget.backgroundColor!;
    } else {
      switch (widget.primaryColor) {
        case CustomColor.error:
          {
            primaryColor = const Color(0xffD92128);
          }

          break;
        case CustomColor.warning:
          {
            primaryColor = const Color(0xffFAAD14);
          }

          break;
        case CustomColor.success:
          {
            primaryColor = const Color(0xff18951E);
          }

          break;
        default:
          primaryColor = const Color(0xff3169B3);
      }
    }

    return primaryColor;
  }

  BorderSide _borderside() {
    return widget.borderside ??
        BorderSide(
            width: widget.borderSideWidth ?? 0,
            color: widget.borderColor ?? Colors.transparent);
  }
}

class MyColors {}
