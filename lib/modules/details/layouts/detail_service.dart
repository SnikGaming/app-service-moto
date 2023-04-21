import 'dart:ui';

import 'package:app/components/style/textstyle.dart';
import 'package:app/constants/colors.dart';
import 'package:app/models/services/service_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_stars/flutter_rating_stars.dart';
import '../../../constants/style.dart';
import '../../../functions/random_color.dart';
import '../../../preferences/settings/setting_prefer.dart';
import '../../home/layouts/pages/services_page.dart';

class DetailsServiceScreen extends StatefulWidget {
  final ServiceModel data;
  const DetailsServiceScreen({super.key, required this.data});

  @override
  State<DetailsServiceScreen> createState() => _DetailsServiceScreenState();
}

class _DetailsServiceScreenState extends State<DetailsServiceScreen> {
  static var value = 5.0;
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: () {},
          child: Icon(Icons.calendar_month_outlined),
        ),
        body: Container(
          color: const Color(0xffF0F0F0),
          height: MediaQuery.of(context).size.height,
          width: size.width,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: ListView(
              children: [
                SizedBox(
                  height: size.height * .6,
                  width: size.width,
                  // color: randomColor(),
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      Positioned(
                          top: 0,
                          child: Container(
                            height: 60,
                            // color: Color.fromARGB(188, 120, 54, 244),
                            width: size.width,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    IconButton(
                                        onPressed: () {
                                          Navigator.pop(context);
                                        },
                                        icon: const Icon(
                                            Icons.arrow_back_ios_outlined)),
                                    const Text(
                                      'Thông tin sản phẩm',
                                      style: styleH1,
                                    )
                                  ],
                                ),
                                IconButton(
                                  onPressed: () {},
                                  icon: const Icon(
                                    Icons.shopping_bag_outlined,
                                  ),
                                )
                              ],
                            ),
                          )),
                      Positioned(
                        top: 170,
                        child: Container(
                          height: size.height * .37,
                          width: size.width * .7,
                          decoration: BoxDecoration(
                            color: const Color(0xffFFFFFF),
                            borderRadius: BorderRadius.circular(18),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(1),
                                spreadRadius: 2,
                                blurRadius: 10,
                                offset: const Offset(0, 3),
                              ),
                            ],
                          ),
                          child: Stack(
                            children: [
                              Positioned(
                                bottom: 0,
                                child: Container(
                                  height: size.height * .18,
                                  width: size.width,
                                  decoration: const BoxDecoration(
                                      // color: Colors.blue,
                                      borderRadius: BorderRadius.only(
                                          bottomLeft: Radius.circular(18),
                                          bottomRight: Radius.circular(18))),
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 10),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Container(
                                          width: size.width,
                                          child: Text(
                                            '${widget.data.name}',
                                            style: styleH2,
                                            softWrap: true,
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        Container(
                                          width: 160,
                                          alignment: Alignment.center,
                                          child: Row(
                                            children: List.generate(
                                              5,
                                              (i) => const Icon(Icons.star),
                                            ),
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        Container(
                                            child: Row(
                                          children: [
                                            Text('50 Comments',
                                                style: styleNormal.copyWith(
                                                  color: Colors.grey,
                                                  fontStyle: FontStyle.italic,
                                                )),
                                            GestureDetector(
                                              onTap: () {},
                                              child: Text(' (Click here)',
                                                  style: styleNormal.copyWith(
                                                      color: Colors.blue,
                                                      fontSize: 18,
                                                      fontStyle:
                                                          FontStyle.italic,
                                                      fontWeight:
                                                          FontWeight.bold)),
                                            ),
                                          ],
                                        )),
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        Container(
                                          padding: const EdgeInsets.all(12),
                                          decoration: BoxDecoration(
                                            color: Colors.black,
                                            borderRadius:
                                                BorderRadius.circular(18),
                                          ),
                                          child: Text(
                                            '${widget.data.price}',
                                            style: styleH3.copyWith(
                                                color: Colors.red),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                      Positioned(
                        top: 80,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(18),
                          child: Container(
                            height: size.height * .27,
                            width: size.width * .6,
                            decoration: BoxDecoration(
                              color: const Color.fromARGB(255, 128, 47, 235)
                                  .withOpacity(0.5),
                            ),
                            child: BackdropFilter(
                              filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
                              child: Container(
                                decoration: const BoxDecoration(
                                  color: Colors.transparent,
                                ),
                                child: Expanded(
                                  child: Container(
                                    child: Stack(
                                      alignment: Alignment.center,
                                      children: [
                                        Positioned(
                                          right: 10,
                                          top: 10,
                                          child: IconButton(
                                              onPressed: () {},
                                              icon: const Icon(
                                                Icons.favorite,
                                                color: Colors.red,
                                              )),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                Expanded(
                  child: Container(
                    constraints:
                        BoxConstraints(minHeight: 100, minWidth: size.width),
                    decoration: BoxDecoration(
                        // color: Colors.grey, //randomColor(),
                        borderRadius: BorderRadius.circular(30)),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(
                          height: 20,
                        ),
                        const Text(
                          'Desciption',
                          style: styleH1,
                        ),
                        const SizedBox(
                          height: 16,
                        ),
                        Text(
                          '${widget.data.shortDescription}',
                          style: styleTitle,
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        Text(
                          '${widget.data.detailDescription}',
                          style: styleTitle,
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        Text(
                          '${widget.data.benefit}',
                          style: styleTitle,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}
