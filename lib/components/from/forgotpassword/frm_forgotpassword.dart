// ignore_for_file: library_private_types_in_public_api, use_build_context_synchronously

import 'package:flutter/material.dart';

import '../../../constants/constants.dart';
import '../../../api/forgotpassword/api_forgot.dart';
import '../../textfield/login/text_field_password.dart';
import '../../value_app.dart';

class PasswordInputDialog extends StatefulWidget {
  final String email;

  const PasswordInputDialog({super.key, required this.email});

  @override
  _PasswordInputDialogState createState() => _PasswordInputDialogState();
}

class _PasswordInputDialogState extends State<PasswordInputDialog> {
  final _password = TextEditingController();
  final _cPassword = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  String? validateConfirmPassword(String? value) {
    if (value!.isEmpty) {
      return textIsRequired;
    }
    if (value != _password.text) {
      return 'Mật khẩu và Xác nhận mật khẩu không trùng khớp';
    }
    return null;
  }

  String? validatePassword(String? value) {
    // Ít nhất 8 ký tự
    if (value!.isEmpty) {
      return textIsRequired;
    }
    if (value.length < 8) {
      return 'Mật khẩu cần ít nhất 8 ký tự';
    }

    // Ít nhất một chữ cái thường
    if (!value.contains(RegExp(r'[a-z]'))) {
      return 'Mật khẩu cần ít nhất một chữ cái thường';
    }

    // Ít nhất một chữ cái in hoa
    if (!value.contains(RegExp(r'[A-Z]'))) {
      return 'Mật khẩu cần ít nhất một chữ cái in hoa';
    }

    // Ít nhất một chữ số
    if (!value.contains(RegExp(r'[0-9]'))) {
      return 'Mật khẩu cần ít nhất một chữ số';
    }

    // Ít nhất một ký tự đặc biệt (trong danh sách @$!%*#?&)
    if (!value.contains(RegExp(r'[@\$!%*#?&]'))) {
      return 'Mật khẩu cần ít nhất một ký tự đặc biệt';
    }

    return null; // Mật khẩu hợp lệ
  }

  Future<void> _butRegister() async {
    if (_formKey.currentState!.validate()) {
      var res = await APIForgotPassword.forgotPassword(
        email: widget.email,
        password: _password.text,
        c_password: _cPassword.text,
      );

      if (res == 200) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text(registerSuc),
            backgroundColor: Colors.green,
          ),
        );
        Navigator.pop(context);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text(registerFail),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(
        'Quên mật khẩu',
        style: SettingApp.fontSignNegative.copyWith(
          fontSize: 18,
          letterSpacing: 1.2,
        ),
      ),
      content: SizedBox(
        height: 140,
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFieldPassword(
                validator: validatePassword,
                controller: _password,
              ),
              const SizedBox(
                height: 10,
              ),
              TextFieldPassword(
                validator: validateConfirmPassword,
                isCPassword: false,
                controller: _cPassword,
              ),
              const SizedBox(
                height: 10,
              ),
            ],
          ),
        ),
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: const Text('Thoát'),
        ),
        TextButton(onPressed: _butRegister, child: const Text('Lưu'))
      ],
    );
  }
}
