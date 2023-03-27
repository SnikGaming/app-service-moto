import 'package:app/models/products/products_model.dart';
import 'package:flutter/material.dart';

import '../../../components/raiting/raiting.dart';
import '../../../components/slider/slider.dart';
import '../../../components/style/textstyle.dart';
import '../../../constants/colors.dart';
import '../../../preferences/settings/setting_prefer.dart';

class DetailProductScreen extends StatefulWidget {
  final ProductModel data;
  const DetailProductScreen({required this.data, super.key});

  @override
  State<DetailProductScreen> createState() => _DetailProductScreenState();
}

class _DetailProductScreenState extends State<DetailProductScreen> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
        body: Container(
      color:
          SettingPrefer.getLightDark() == null || SettingPrefer.getLightDark()
              ? white
              : black,
      height: MediaQuery.of(context).size.height,
      width: size.width,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: ListView(
          children: [
            MySlider(),
            SizedBox(
              height:
                  MediaQuery.of(context).size.height * 0.75 - size.height * .3,
              // color: Colors.amber,
              child: Column(
                children: [
                  Container(
                    alignment: Alignment.center,
                    width: size.width,
                    child: Text(
                      '${widget.data.productName}',
                      style: MyTextStyle.title.copyWith(
                          color: SettingPrefer.getLightDark() == null ||
                                  SettingPrefer.getLightDark()
                              ? black
                              : white,
                          fontSize: 20),
                    ),
                  ),
                  SizedBox(
                    width: size.width,
                    child: Text('Price: ${widget.data.price}',
                        style: MyTextStyle.title
                            .copyWith(color: Colors.red, fontSize: 20)),
                  ),
                  Text('${widget.data.description}',
                      style: MyTextStyle.title.copyWith(
                          color: SettingPrefer.getLightDark() == null ||
                                  SettingPrefer.getLightDark()
                              ? black
                              : white,
                          fontSize: 16)),
                ],
              ),
            ),
            SizedBox(
              width: size.width,
              height: size.height,
              // color: lsColor[Random().nextInt(lsColor.length)],
              child: RatingWidget(
                rating: 3,
                count: 5,
                reviews: const ['abc', 'abc', 'abc', 'cde', 'efg'],
              ),
            ),
          ],
        ),
      ),
    ));
  }
}
