import 'dart:math';

import 'package:app/constants/constants.dart';
import 'package:app/preferences/settings/setting_prefer.dart';
import 'package:app/preferences/user/user_preferences.dart';
import 'package:flutter/material.dart';

import '../../../../constants/colors.dart';

class ServicesPage extends StatefulWidget {
  const ServicesPage({super.key});

  @override
  State<ServicesPage> createState() => _ServicesPageState();
}

class _ServicesPageState extends State<ServicesPage> {
  List<String> items = ["1", "2", "3", "4", "5", "6", "7", "8"];

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
                      // margin: EdgeInsets.all(8),
                      height: 49,
                      width: 49,
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
                    child: ListView.builder(
                        itemBuilder: (_, i) => Padding(
                              padding: EdgeInsets.only(
                                  top: i == 0 ? 40 : 20, left: 20, right: 20),
                              child: GestureDetector(
                                onTap: () => _addService(i),
                                child: Container(
                                  height: 150,
                                  width: size.width,
                                  decoration: BoxDecoration(
                                    // ignore: prefer_const_literals_to_create_immutables
                                    boxShadow: [
                                      const BoxShadow(
                                          color: Colors.grey,
                                          offset: Offset(4, 4),
                                          blurRadius: 10),
                                      const BoxShadow(
                                          color: Colors.grey,
                                          offset: Offset(4, 4),
                                          blurRadius: 10)
                                    ],
                                    color: lsColor[
                                        Random().nextInt(lsColor.length)],
                                    borderRadius: BorderRadius.circular(30),
                                  ),
                                ),
                              ),
                            ))),
              ),
            )
          ],
        ),
      ),
    );
  }

  _addService(data) {
    showModalBottomSheet(
        context: context,
        builder: (context) {
          return StatefulBuilder(builder: (BuildContext context,
              StateSetter setState /*You can rename this!*/) {
            return Container(
              height: 400,
            );
          });
        });
  }
}

List<Color> lsColor = [
  Colors.green.shade300,
  Colors.yellow.shade300,
  Colors.blue.shade300,
  Colors.pink.shade300,
  const Color.fromARGB(166, 98, 235, 240),
  Colors.purple.shade300,
  Colors.blueAccent,
  const Color.fromARGB(195, 129, 33, 218),
  const Color.fromARGB(186, 240, 174, 98),
];
