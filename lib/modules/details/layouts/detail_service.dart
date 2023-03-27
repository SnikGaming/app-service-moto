import 'package:app/components/style/textstyle.dart';
import 'package:app/constants/colors.dart';
import 'package:app/models/services/service_model.dart';
import 'package:flutter/material.dart';
import '../../../components/raiting/raiting.dart';
import '../../../components/slider/slider.dart';
import '../../../preferences/settings/setting_prefer.dart';

class DetailsServiceScreen extends StatefulWidget {
  final ServiceModel data;
  const DetailsServiceScreen({super.key, required this.data});

  @override
  State<DetailsServiceScreen> createState() => _DetailsServiceScreenState();
}

class _DetailsServiceScreenState extends State<DetailsServiceScreen> {
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
            Expanded(
              child: Column(
                children: [
                  Container(
                    alignment: Alignment.center,
                    width: size.width,
                    child: Text(
                      widget.data.name,
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
                  Text(widget.data.detailDescription,
                      style: MyTextStyle.title.copyWith(
                          color: SettingPrefer.getLightDark() == null ||
                                  SettingPrefer.getLightDark()
                              ? black
                              : white,
                          fontSize: 16)),
                  Text(widget.data.benefit,
                      style: MyTextStyle.title.copyWith(
                          color: SettingPrefer.getLightDark() == null ||
                                  SettingPrefer.getLightDark()
                              ? black
                              : white,
                          fontSize: 16)),
                ],
              ),
            ),
            const SizedBox(
              height: 16,
            ),
            SizedBox(
              width: size.width,
              height: size.height,
              // color: lsColor[Random().nextInt(lsColor.length)],
              child: const RatingWidget(
                rating: 3,
                count: 5,
                reviews: ['abc', 'abc', 'abc', 'cde', 'efg'],
              ),
            ),
          ],
        ),
      ),
    ));
  }
}
