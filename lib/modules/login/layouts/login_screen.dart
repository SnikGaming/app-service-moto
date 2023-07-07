// ignore_for_file: use_build_context_synchronously

import 'package:app/components/button/mybutton.dart';
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
import '../../home/api/checkMail/checkMain.dart';
import '../../home/api/otp/otp_api.dart';

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
                                                  'Vui lòng nhập email của bạn vào bên dưới.',
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
                                              MyButton(
                                                  width: 80,
                                                  backgroundColor: Colors.red,
                                                  onPressed:
                                                      _sendEmailForgotPassword,
                                                  child: const Text(
                                                    'Gửi',
                                                    style: TextStyle(
                                                        color: Colors.white),
                                                  )),
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
                              isRegister = !isRegister;
                              setState(() {});
                            },
                            child: Text(
                              isRegister ? register : login,
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
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return const AlertDialog(
          title: Text('Vui lòng đợi'),
          content: Text('Đang gửi email...'),
        );
      },
    );

    var value = generateRandomNumber();
    int checkMail = await APICheckValue.checkMail(email: email.text);

    if (checkMail == 200) {
      sendOTP(email: email.text, otp: value.toString()).then((sendEmailResult) {
        if (sendEmailResult) {
          return APIOtp.createOtp(email: email.text, otp: value.toString());
        } else {
          throw Exception('Failed to send email');
        }
      }).then((createOtpResult) {
        Navigator.pop(context);
        if (createOtpResult) {
          Message.success(message: sucSend, context: context);
          Navigator.pop(context);
          displayTextInputDialog(
              context: context, otp: _otp, email: email.text);
          email.clear();
        } else {
          Message.error(message: failSend, context: context);
        }
      }).catchError((error) {
        Navigator.pop(context);
        Message.error(message: failSend, context: context);
      });
    } else {
      Navigator.pop(context);

      Message.error(message: "Tài khoảng không tồn tại.", context: context);
    }
  }
}
