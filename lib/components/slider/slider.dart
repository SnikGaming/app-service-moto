import 'package:app/modules/home/api/banner/api_banner.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

import '../../models/slider/slider_model.dart';
import '../../network/connect.dart';
import 'item.dart';

class MySlider extends StatefulWidget {
  const MySlider({super.key});

  @override
  State<MySlider> createState() => _MySliderState();
}

class _MySliderState extends State<MySlider> {
  @override
  Widget build(BuildContext context) {
    return CarouselSlider(
      options: CarouselOptions(
        aspectRatio: 2.0,
        autoPlay: true,
        enlargeCenterPage: true,
        enlargeStrategy: CenterPageEnlargeStrategy.zoom,
        enlargeFactor: 0.4,
      ),
      items: List.generate(
          APIBanner.apiCategory.length,
          (index) => Container(
                height: 250,
                width: 330,
                decoration: BoxDecoration(
                  // color: Colors.red,
                  image: DecorationImage(
                      image: NetworkImage(
                          '${ConnectDb.url}${APIBanner.apiCategory[index].image}'),
                      fit: BoxFit.cover),
                ),
              )),
    );
  }
}
// ignore: non_constant_identifier_names
// MySlider() => CarouselSlider(
//       options: CarouselOptions(
//         aspectRatio: 2.0,
//         autoPlay: true,
//         enlargeCenterPage: true,
//         enlargeStrategy: CenterPageEnlargeStrategy.zoom,
//         enlargeFactor: 0.4,
//       ),
//       items: List.generate(
//           APIBanner.apiCategory.length,
//           (index) => Container(
//                 height: 250,
//                 width: 330,
//                 color: Colors.red,
//                 decoration: BoxDecoration(
//                     image: DecorationImage(
//                         image: NetworkImage(
//                             'http://${ConnectDb.ip}${APIBanner.apiCategory[index].image}'))),
//               )),
//     );
// items: List.generate(lsSliver.length,
//     (index) => iteamSlider(data: lsSliver[index])) //imageSliders,
// );

List<SliderModel> lsSliver = [
  SliderModel(id: '1', name: 'Khuyến mãi 10%'),
  SliderModel(id: '2', name: 'Khuyến mãi 20%'),
  SliderModel(id: '3', name: 'Khuyến mãi 30%'),
  SliderModel(id: '4', name: 'Khuyến mãi 40%'),
  SliderModel(id: '5', name: 'Khuyến mãi 50%'),
  SliderModel(id: '6', name: 'Khuyến mãi 60%'),
];
