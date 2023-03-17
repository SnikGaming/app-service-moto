import 'package:flutter/material.dart';

import 'package:validators/validators.dart';

import '../../../constants/const_text.dart';

class TextFieldEmail extends StatefulWidget {
  final TextEditingController? controller;
  final void Function(String)? onChanged;
  final String? Function(String?)? validator;
  final bool? isSuffIcon;
  final Widget? prefixIcon;
  final bool? isPrefix;
  final TextInputAction? textInputAction;
  final String? text;
  const TextFieldEmail(
      {this.controller,
      this.textInputAction,
      this.text,
      this.isPrefix = false,
      this.prefixIcon,
      this.validator,
      this.isSuffIcon,
      this.onChanged,
      super.key});

  @override
  State<TextFieldEmail> createState() => _TextFieldEmailState();
}

class _TextFieldEmailState extends State<TextFieldEmail> {
  bool _isEmail = false;
  bool _isHiden = false;
  String? _checkEmail(value) {
    if (value == null || value.isEmpty) {
      return textIsRequired;
    }

    if (!isEmail(value!)) {
      return textEmailFormat;
    }

    return null;
  }

  void _onChange(value) {
    setState(() {
      if (value.length > 0) {
        _isHiden = true;
      } else {
        _isHiden = false;
      }
      _isEmail = isEmail(value);
    });
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      style: const TextStyle(
          fontWeight: FontWeight.w400, fontSize: 16, letterSpacing: 1),
      validator: widget.validator ?? _checkEmail,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      textInputAction: widget.textInputAction ?? TextInputAction.next,
      keyboardAppearance: Brightness.dark,
      autocorrect: true,
      onChanged: widget.onChanged ?? _onChange,
      controller: widget.controller,
      decoration: InputDecoration(
        hintText: widget.text ?? textEmail,
        hintStyle: const TextStyle(
            fontWeight: FontWeight.w400,
            color: Color(0xffC6CCD3),
            fontSize: 16,
            letterSpacing: 1),
        fillColor: const Color(0xffFFFFFF),
        filled: true,
        prefixIcon: widget.isPrefix!
            ? null
            : widget.prefixIcon ??
                const Icon(Icons.email_outlined,
                    size: 20, color: Color(0xff3169B3)),
        suffixIcon: _suffixIcon(),
        contentPadding: const EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
        enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(6),
            borderSide: const BorderSide(color: Color(0xffC6CCD3), width: 1)),
        focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(6),
            borderSide: const BorderSide(color: Color(0xff858A90), width: 1)),
        focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(6),
            borderSide: const BorderSide(color: Color(0xffD92128), width: 1)),
        errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(6),
            borderSide: const BorderSide(color: Color(0xffD92128), width: 1)),
      ),
    );
  }

  _suffixIcon() => widget.isSuffIcon != null && widget.isSuffIcon != false
      ? _isHiden == true
          ? _isEmail
              ? const Icon(
                  Icons.done,
                  color: Colors.green,
                )
              : const Icon(
                  Icons.close_sharp,
                  color: Colors.red,
                )
          : null
      : null;
}
