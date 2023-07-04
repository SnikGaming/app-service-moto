import 'package:app/components/from/login/frm_login.dart';
import 'package:app/components/from/register/frm_register.dart';
import 'package:app/components/textfield/login/text_field_email.dart';
import 'package:app/components/value_app.dart';

import 'package:app/constants/constants.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:otp_text_field/otp_field.dart';
import '../../../components/from/otp/frm_otp.dart';
import '../../../components/message/message.dart';
import '../../../components/style/text_style.dart';
import '../../../constants/colors.dart';
import '../../../network/api/otp.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen>
    with SingleTickerProviderStateMixin {
  final OtpFieldController _otp = OtpFieldController();
  bool isRegister = true;
  bool isSendEmailSuccess = false;
  late AnimationController _animation;
  var email = TextEditingController();

  @override
  void dispose() {
    _animation.dispose();
    // ignore: todo
    // TODO: implement dispose
    super.dispose();
  }

  @override
  void initState() {
    // ignore: todo
    // TODO: implement initState
    super.initState();
    _animation = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600),
    );
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return SafeArea(
      child: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Scaffold(
          body: SizedBox(
            height: size.height,
            width: size.width,
            child: SingleChildScrollView(
              physics: isRegister ? const NeverScrollableScrollPhysics() : null,
              child: Stack(
                alignment: Alignment.topCenter,
                children: [
                  Positioned(
                    bottom: -39,
                    left: -100,
                    child: SizedBox(
                      height: 400,
                      width: 400,
                      // color: Colors.red,
                      child:
                          Lottie.asset('assets/login/background_lotie_2.json'),
                    ),
                  ),
                  SizedBox(
                    height: size.height,
                    width: size.width,
                    // color: Colors.red,
                    child: Lottie.asset('assets/login/background_lotie_1.json'),
                  ),
                  SizedBox(
                      height: 300,
                      child: Lottie.asset('assets/banners/EdVYWph2lc.json')),
                  SizedBox(
                    height: size.height,
                    width: size.width,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Column(
                        children: [
                          // Spacer(),
                          SizedBox(
                            height: size.height * .32,
                          ),
                          //!:
                          SizedBox(
                              width: size.width,
                              child: Text(
                                textLogin_Title,
                                style: h1.copyWith(color: black),
                              )),
                          const SizedBox(
                            height: 10,
                          ),
                          SizedBox(
                              width: size.width,
                              child: Text(
                                textLogin_subTitle,
                                style: buttonSmall_1.copyWith(color: grey),
                              )),
                          const SizedBox(
                            height: 10,
                          ),

                          isRegister ? const FromLogin() : const FrmRegister(),
                        ],
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 60,
                    child: SizedBox(
                      height: 30,
                      width: size.width,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,

                        // ignore: prefer_const_literals_to_create_immutables
                        children: [
                          // ignore: prefer_const_constructors
                          GestureDetector(
                            onTap: () {
                              Message.success(
                                  message: forgotPassword, context: context);
                              showModalBottomSheet<void>(
                                  transitionAnimationController: _animation,
                                  context: context,
                                  builder: (BuildContext context) {
                                    return SizedBox(
                                      height: 600,
                                      child: Center(
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 20),
                                          child: Column(
                                            // mainAxisAlignment:
                                            //     MainAxisAlignment.center,
                                            mainAxisSize: MainAxisSize.max,
                                            children: <Widget>[
                                              const SizedBox(
                                                height: 30,
                                              ),
                                              Text(
                                                forgotPassword,
                                                style: SettingApp
                                                    .fontSignNegative
                                                    .copyWith(
                                                        fontWeight:
                                                            FontWeight.w800),
                                              ),
                                              const SizedBox(
                                                height: 10,
                                              ),
                                              SizedBox(
                                                width: size.width,
                                                child: const Text(
                                                  'Please enter your email below.',
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.w400,
                                                      color: Colors.grey,
                                                      fontSize: 14),
                                                ),
                                              ),
                                              // ignore: prefer_const_constructors
                                              SizedBox(
                                                height: 10,
                                              ),
                                              TextFieldEmail(
                                                controller: email,
                                              ),
                                              // ignore: prefer_const_constructors
                                              SizedBox(
                                                height: 10,
                                              ),
                                              ElevatedButton(
                                                  onPressed:
                                                      _sendEmailForgotPassword,
                                                  child: const Text('SEND')),
                                            ],
                                          ),
                                        ),
                                      ),
                                    );
                                  });
                            },
                            child: const Text(
                              forgotPassword,
                              style: TextStyle(
                                  color: Colors.red,
                                  fontWeight: FontWeight.w400,
                                  fontSize: 18),
                            ),
                          ),
                          // ignore: prefer_const_constructors
                          Text(
                            ' $or ',
                            style: const TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 18),
                          ),
                          // ignore: prefer_const_constructors
                          GestureDetector(
                            onTap: () {
                              Message.success(
                                  message: register, context: context);
                              isRegister = !isRegister;
                              setState(() {});
                            },
                            child: Text(
                              isRegister ? '$register ?' : login,
                              style: const TextStyle(
                                  color: Colors.green,
                                  fontWeight: FontWeight.w400,
                                  fontSize: 18),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  _sendEmailForgotPassword() async {
    var value = generateRandomNumber();
    bool res = await sendOTP(email: email.text, otp: value.toString());
    if (res) {
      Message.success(message: sucSend, context: context);
      Navigator.pop(context);
      displayTextInputDialog(context, _otp);
    } else {
      Message.error(message: failSend, context: context);
    }
  }
}
