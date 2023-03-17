import 'package:app/components/textfield/login/text_field_password.dart';
import 'package:app/constants/const_text.dart';
import 'package:flutter/material.dart';

import '../../button/button.dart';
import '../../style/text_style.dart';
import '../../textfield/login/text_field_email.dart';

class FromLogin extends StatefulWidget {
  const FromLogin({super.key});

  @override
  State<FromLogin> createState() => _FromLoginState();
}

class _FromLoginState extends State<FromLogin> {
  var formkey = GlobalKey<FormState>();
  final _email = TextEditingController();
  final _password = TextEditingController();

  // final Shader linearGradient = LinearGradient(
  //   colors: <Color>[Color(0xffDA44bb), Color(0xff8921aa)],
  // ).createShader(Rect.fromLTWH(0.0, 0.0, 200.0, 70.0));
  @override
  Widget build(BuildContext context) {
    return Form(
        key: formkey,
        child: Column(
          children: [
            //!:Email
            TextFieldEmail(
              controller: _email,
              isSuffIcon: true,
            ),
            const SizedBox(
              height: 16,
            ),
            //!: Password
            TextFieldPassword(
              controller: _password,
            ),
            //!: Checkbox
            // Row(
            //   mainAxisAlignment: MainAxisAlignment.start,
            //   children: [
            //     CheckBoxCustom(
            //         value: _isChecked,
            //         onChanged: (value) {
            //           _isChecked = value!;
            //           setState(() {});
            //         }),
            //     GradientText(
            //       textLogin_remember,
            //       style: buttonSmall_2,
            //       colors: const [Color(0xff5DACFA), Color(0xff9A8DFC)],
            //     ),
            //   ],
            // ),
            const SizedBox(
              height: 16,
            ),
            //!: Button
            ButtonCustom(
              ontap: _btnLogin,
              child: const Center(
                  child: Text(
                textLogin_Login,
                style: h2,
              )),
            )
          ],
        ));
  }

  _btnLogin() {
    if (formkey.currentState!.validate()) {}
  }
}
