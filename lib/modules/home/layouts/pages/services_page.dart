import 'dart:async';

import 'package:app/constants/constants.dart';
import 'package:app/preferences/settings/setting_prefer.dart';
import 'package:app/preferences/user/user_preferences.dart';
import 'package:custom_refresh_indicator/custom_refresh_indicator.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import '../../../../constants/colors.dart';

class ServicesPage extends StatefulWidget {
  const ServicesPage({super.key});

  @override
  State<ServicesPage> createState() => _ServicesPageState();
}

class _ServicesPageState extends State<ServicesPage> {
  List<String> items = ["1", "2", "3", "4", "5", "6", "7", "8"];



  final _offsetToArmed = 220.0;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: SizedBox(
        height: size.height,
        width: size.width,
        child: Stack(
          children: [
            Container(
              height: size.height,
              width: size.width,
              color: Colors.green,
              child: Row(
                // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  //!: Image User
                  Padding(
                    padding: const EdgeInsets.only(top: 8.0, left: 20),
                    child: Container(
                      height: 60,
                      width: 60,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        image: UserPrefer.getToken() == null
                            ? const DecorationImage(
                                image: AssetImage(
                                    'assets/icons/user/user_profile.png'),
                                fit: BoxFit.cover)
                            : DecorationImage(
                                image: NetworkImage(
                                  UserPrefer.getImageUser(),
                                ),
                              ),
                      ),
                    ),
                  ),
                  //!: NameUser
                  Padding(
                    padding: const EdgeInsets.only(top: 8.0, left: 10),
                    child: Container(
                        height: 60,
                        width: 170,
                        alignment: Alignment.centerLeft,
                        child: Text('No Name',
                            // softWrap: true,
                            overflow: TextOverflow.ellipsis,
                            style: SettingApp.fontSignNegative.copyWith(
                                fontSize: 18, fontWeight: FontWeight.w600))),
                  ),
                  const Spacer(),

                  //!: Contact
                  Padding(
                    padding: const EdgeInsets.only(top: 8.0, left: 10),
                    child: Container(
                        height: 60,
                        width: 60,
                        alignment: Alignment.center,
                        child: IconButton(
                            onPressed: () {},
                            icon: const Icon(
                              Icons.phone_android_outlined,
                              color: Colors.yellow,
                            ))),
                  )
                ],
              ),
            ),
            Positioned(
              bottom: 0,
              child: ClipRRect(
                borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(40),
                    topRight: Radius.circular(40)),
                child: Container(
                  height: size.height - size.height * .23,
                  width: size.width,
                  decoration: BoxDecoration(
                    color: SettingPrefer.getLightDark() == null ||
                            SettingPrefer.getLightDark()
                        ? white
                        : black,
                  ),
                  child: CustomRefreshIndicator(
                      offsetToArmed: _offsetToArmed,
                      onRefresh: () => Future.delayed(const Duration(seconds: 3)),
                      // ignore: sort_child_properties_last
                      child: ListView.builder(
                          itemCount: 20,
                          itemBuilder: (_, index) => Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Container(
                                  height: 30,
                                  color: Colors.red,
                                ),
                              )),
                      builder: ((context, child, controller) => AnimatedBuilder(
                          animation: controller,
                          builder: (_, index) => ListView.builder(
                              itemCount: 20,
                              itemBuilder: (_, index) => Stack(
                                    children: [
                                      SizedBox(
                                        width: 100,
                                        height: 220 * controller.value,
                                        child: Lottie.network(
                                            'https://assets3.lottiefiles.com/packages/lf20_usmfx6bp.json',
                                            fit: BoxFit.cover),
                                      ),
                                      // Padding(
                                      //   padding: const EdgeInsets.all(8.0),
                                      //   child: Container(
                                      //     height: 30,
                                      //     color: Colors.red,
                                      //   ),
                                      // ),
                                    ],
                                  ))))),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
