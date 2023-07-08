// ignore_for_file: use_build_context_synchronously

import 'package:app/components/textfield/login/text_field_email.dart';
import 'package:app/components/value_app.dart';
import 'package:app/api/checkMail/checkMain.dart';
import 'package:flutter/material.dart';
import 'package:otp_text_field/otp_field.dart';
import '../../../api/otp/otp_api.dart';
import '../../../api/user/register.dart';
import '../../../network/api/otp.dart';
import '../../button/button.dart';
import '../../message/message.dart';
import '../../textfield/login/text_field_password.dart';
import '../otp/frm_otp.dart';

class FrmRegister extends StatefulWidget {
  const FrmRegister({super.key});

  @override
  State<FrmRegister> createState() => _FrmRegisterState();
}

class _FrmRegisterState extends State<FrmRegister> {
  var formkey = GlobalKey<FormState>();
  final OtpFieldController _otp = OtpFieldController();

  final _email = TextEditingController();
  final _password = TextEditingController();
  final _repassword = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formkey,
      child: Column(
        children: [
          TextFieldEmail(
            controller: _email,
          ),
          const SizedBox(
            height: 10,
          ),
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
            controller: _repassword,
          ),
          const SizedBox(
            height: 10,
          ),
          Container(
            decoration: const BoxDecoration(boxShadow: [
              BoxShadow(
                  color: Colors.black, offset: Offset(3, 5), blurRadius: 12)
            ]),
            child: ButtonCustom(
              ontap: _butRegister,
              width: 160,
              height: 40,
              child: const Center(
                  child: Text(
                register,
                style: TextStyle(
                    fontWeight: FontWeight.w600,
                    letterSpacing: 1,
                    fontSize: 18),
              )),
            ),
          ),
        ],
      ),
    );
  }

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

  _butRegister() async {
    // if (true) Message.error(message: "Login faild", context: context);
    if (formkey.currentState!.validate()) {
      int res = await APICheckValue.checkMail(email: _email.text);
      if (res == 200) {
        // ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        //   content: Text('Email tồn tại.'),
        //   backgroundColor: Colors.red,
        // ));
        Message.error(message: "Email đã được đăng ký.", context: context);
      } else {
        dangGuiMail(context);
        var value = generateRandomNumber();
        sendOTP(email: _email.text, otp: value.toString(), type: eOtp.register)
            .then((sendEmailResult) {
          if (sendEmailResult) {
            return APIOtp.createOtp(email: _email.text, otp: value.toString());
          } else {
            throw Exception('Failed to send email');
          }
        }).then((createOtpResult) {
          Navigator.pop(context);
          if (createOtpResult) {
            Message.success(message: sucSend, context: context);
            // Navigator.pop(context);
            displayTextInputDialog(
                context: context,
                otp: _otp,
                email: _email.text,
                isRegister: true,
                password: _password.text,
                repassword: _repassword.text);
            // _email.clear();
          } else {
            Message.error(message: failSend, context: context);
          }
        }).catchError((error) {
          Navigator.pop(context);
          Message.error(message: failSend, context: context);
        });
      }
    }
  }
}
