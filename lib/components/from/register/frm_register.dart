import 'package:app/components/textfield/login/text_field_email.dart';
import 'package:flutter/material.dart';
import '../../button/button.dart';
import '../../textfield/login/text_field_password.dart';

class FrmRegister extends StatefulWidget {
  const FrmRegister({super.key});

  @override
  State<FrmRegister> createState() => _FrmRegisterState();
}

class _FrmRegisterState extends State<FrmRegister> {
  var formkey = GlobalKey<FormState>();

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
            controller: _password,
          ),
          const SizedBox(
            height: 10,
          ),
          TextFieldPassword(
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
                'Register',
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

  _butRegister() async {
    // if (true) Message.error(message: "Login faild", context: context);
    if (formkey.currentState!.validate()) {}
  }
}
