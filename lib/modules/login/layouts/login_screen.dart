import 'package:app/components/from/login/frm_login.dart';
import 'package:app/constants/const_text.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import '../../../components/style/text_style.dart';
import '../../../constants/colors.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
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
              physics: const NeverScrollableScrollPhysics(),
              child: Stack(
                alignment: Alignment.topCenter,
                children: [
                  SizedBox(
                      height: 300,
                      child: Lottie.asset('assets/banners/EdVYWph2lc.json')),
                  SizedBox(
                    height: size.height,
                    width: size.width,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Column(
                        // mainAxisAlignment: MainAxisAlignment.center,
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
                          const FromLogin(),
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
}
