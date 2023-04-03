import 'dart:math';

import 'package:app/components/message/message.dart';
import 'package:flutter/material.dart';
import 'package:searchbar_animation/searchbar_animation.dart';

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
      appBar: AppBar(
        centerTitle: true,
        title: const Text('BOOKING'),
      ),
      body: SingleChildScrollView(
        physics: const NeverScrollableScrollPhysics(),
        child: SizedBox(
          height: size.height,
          width: size.width,
          child: Stack(
            children: [
              SingleChildScrollView(
                physics: const NeverScrollableScrollPhysics(),
                child: Container(
                  height: size.height,
                  width: size.width,
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage('assets/images/bgbooking.png'),
                        fit: BoxFit.cover),
                  ),
                ),
              ),
              Column(
                children: [
                  SearchBarAnimation(
                    textEditingController: TextEditingController(),
                    isOriginalAnimation: true,
                    enableKeyboardFocus: true,
                    onExpansionComplete: () {
                      Message.success(
                          context: context, message: 'on onExpansionComplete');

                      debugPrint(
                          'do something just after searchbox is opened.');
                    },
                    onCollapseComplete: () {
                      Message.success(context: context, message: 'on collapse');
                      debugPrint(
                          'do something just after searchbox is closed.');
                    },
                    onPressButton: (isSearchBarOpens) {
                      print(isSearchBarOpens);
                      Message.success(
                          context: context, message: 'on isSearchBarOpens');

                      // debugPrint(
                      //     'do something before animation started. It\'s the ${isSearchBarOpens ? 'opening' : 'closing'} animation');
                    },
                    trailingWidget: const Icon(
                      Icons.search,
                      size: 20,
                      color: Colors.black,
                    ),
                    secondaryButtonWidget: const Icon(
                      Icons.close,
                      size: 20,
                      color: Colors.black,
                    ),
                    buttonWidget: const Icon(
                      Icons.search,
                      size: 20,
                      color: Colors.black,
                    ),
                  ),
                  Container(
                    height: 100,
                    color: Colors.red,
                  ),
                  Expanded(
                    // height: size.height - 330,
                    child: ListView.builder(
                      itemBuilder: (context, i) => Padding(
                        padding: EdgeInsets.only(
                            left: 20, right: 20, top: i == 0 ? 0 : 20),
                        child: Container(
                          height: 230,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(30),
                            border: Border.all(
                              color: Colors.grey.withOpacity(0.5),
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.5),
                                spreadRadius: 5,
                                blurRadius: 7,
                                offset: const Offset(
                                    0, 3), // changes position of shadow
                              ),
                            ],
                          ),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 20, vertical: 16),
                            child: Column(
                              children: [
                                //!: Order Today
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      'Order #$i',
                                      style: title,
                                    ),
                                    Row(
                                      // ignore: prefer_const_literals_to_create_immutables
                                      children: [
                                        const Text(
                                          'Today',
                                          style: subTitle,
                                        ),
                                        const Icon(
                                          Icons.today,
                                          color: Colors.blue,
                                        )
                                      ],
                                    )
                                  ],
                                ),
                                //!:
                                //!: content
                                Row(
                                  children: [
                                    Expanded(
                                      flex: 2,
                                      child: SizedBox(
                                        width: size.width,
                                        child: Icon(
                                          Icons.diamond,
                                          color: lsColor[
                                              Random().nextInt(lsColor.length)],
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      flex: 8,
                                      child: SizedBox(
                                        width: size.width,
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              'Customer info',
                                              style: h1.copyWith(
                                                color: Colors.blue,
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                    )
                                  ],
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ],
          ),
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
  // Colors.yellow.shade300,
  Colors.blue.shade300,
  Colors.pink.shade300,
  const Color.fromARGB(166, 98, 235, 240),
  Colors.purple.shade300,
  Colors.blueAccent,
  const Color.fromARGB(195, 129, 33, 218),
  // const Color.fromARGB(186, 240, 174, 98),
];

const title = TextStyle(
  fontWeight: FontWeight.w700,
  fontSize: 20,
  letterSpacing: 1,
);

const subTitle = TextStyle(
  fontWeight: FontWeight.w400,
  fontSize: 14,
  letterSpacing: 1,
);
const h1 = TextStyle(
  fontWeight: FontWeight.w700,
  fontSize: 18,
  letterSpacing: 1,
);
