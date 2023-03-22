import 'package:app/components/message/message.dart';
import 'package:app/components/textfield/login/text_field_password.dart';
import 'package:app/constants/const_text.dart';
import 'package:app/modules/app_constants.dart';
import 'package:app/preferences/user/user_preferences.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../../network/api/google/google.dart';
import '../../../network/api/user/user_api.dart';
import '../../button/button.dart';
import '../../functions/logout.dart';
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
  late FocusNode myFocusNode;
  @override
  void initState() {
    super.initState();

    myFocusNode = FocusNode();
  }

  @override
  void dispose() {
    // Clean up the focus node when the Form is disposed.
    myFocusNode.dispose();

    super.dispose();
  }

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
              focusNode: myFocusNode,
              controller: _email,
              isSuffIcon: true,
            ),
            const SizedBox(
              height: 10,
            ),
            //!: Password
            TextFieldPassword(
              controller: _password,
            ),
            //!: Checkbox
            const SizedBox(
              height: 10,
            ),
            //!: Button
            Container(
              decoration: const BoxDecoration(boxShadow: [
                BoxShadow(
                    color: Colors.black, offset: Offset(3, 5), blurRadius: 12)
              ]),
              child: ButtonCustom(
                ontap: _btnLogin,
                width: 160,
                height: 40,
                child: const Center(
                    child: Text(
                  textLogin_Login,
                  style: TextStyle(
                      fontWeight: FontWeight.w600,
                      letterSpacing: 1,
                      fontSize: 18),
                )),
              ),
            ),

            const SizedBox(
              height: 16,
            ),

            SizedBox(
              height: 58,
              // color: Colors.red,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(
                      onPressed: () {
                        AuthWithGoogle()
                            .googleSignInMethod(context)
                            .then((value) {
                          Modular.to.navigate(Routes.home);
                          setState(() {});
                        });
                        if (UserPrefer.getEmail() != null) {
                          Message.success(
                              message: "Hello ${UserPrefer.getEmail()}",
                              context: context);
                        }
                      },
                      icon: Image.asset('assets/icons/login/google.png')),
                  const SizedBox(
                    width: 20,
                  ),
                  IconButton(
                      // onPressed: () {},
                      onPressed: () {
                        AuthWithGoogle.googleSignOutMethod(context)
                            .then((value) => Modular.to.navigate(Routes.home));
                        setState(() {
                          LogoutApp.Logout();
                        });
                      },
                      icon: Image.asset('assets/icons/login/facebook.png')),
                ],
              ),
            ),
          ],
        ));
  }

  _btnLogin() async {
    if (true) Message.error(message: "Login faild", context: context);
    if (formkey.currentState!.validate()) {
      await UserAPI.Login(username: _email.text, password: _password.text);
      // ignore: use_build_context_synchronously
      Message.success(message: "Hello ${_email.text}", context: context);

      // Modular.to.navigate(Routes.home);
    }
  }
}
