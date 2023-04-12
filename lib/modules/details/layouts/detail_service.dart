import 'package:app/components/style/textstyle.dart';
import 'package:app/constants/colors.dart';
import 'package:app/models/services/service_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_stars/flutter_rating_stars.dart';
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
            // MySlider(),
            Container(height: 250, color: Colors.red),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(
                      top: 20,
                    ),
                    child: Container(
                      alignment: Alignment.center,
                      width: size.width,
                      child: Text(
                        widget.data.name,
                        style: title.copyWith(
                          color: SettingPrefer.getLightDark() == null ||
                                  SettingPrefer.getLightDark()
                              ? black
                              : white,
                        ),
                      ),
                    ),
                  ),
                  //?: Ratings
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 20),
                    child: RatingStars(
                      value: value,
                      onValueChanged: (v) {
                        //
                        setState(() {
                          value = v;
                        });
                      },
                      starBuilder: (index, color) => Icon(
                        Icons.ac_unit_outlined,
                        color: color,
                      ),
                      starCount: 5,
                      starSize: 20,
                      valueLabelColor: const Color(0xff9b9b9b),
                      valueLabelTextStyle: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w400,
                          fontStyle: FontStyle.normal,
                          fontSize: 12.0),
                      valueLabelRadius: 10,
                      maxValue: 5,
                      starSpacing: 2,
                      maxValueVisibility: true,
                      valueLabelVisibility: true,
                      animationDuration: const Duration(milliseconds: 1000),
                      valueLabelPadding: const EdgeInsets.symmetric(
                          vertical: 1, horizontal: 8),
                      valueLabelMargin: const EdgeInsets.only(right: 8),
                      starOffColor: const Color(0xffe7e8ea),
                      starColor: Colors.yellow,
                    ),
                  ),
                  InkWell(
                    onTap: () {},
                    child: Text(
                      '5 Assess',
                      style: subTitle.copyWith(color: Colors.grey),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                      top: 10,
                      bottom: 10,
                    ),
                    child: SizedBox(
                      width: size.width,
                      child: Text('Price: ${widget.data.price}',
                          style:
                              title.copyWith(color: Colors.red, fontSize: 20)),
                    ),
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
          ],
        ),
      ),
    ));
  }
}
