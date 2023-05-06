import 'package:app/functions/random_color.dart';
import 'package:app/modules/home/api/banner/api_banner.dart';
import 'package:cached_network_image/cached_network_image.dart';
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
          APIBanner.apiBanner.length,
          (index) => ClipRRect(
                borderRadius: BorderRadius.circular(18),
                child: Container(
                  height: 250,
                  width: 300,
                  decoration: BoxDecoration(
                    color: randomColor(),
                  ),
                  child: Expanded(
                    child: CachedNetworkImage(
                      imageUrl:
                          '${ConnectDb.url}${APIBanner.apiBanner[index].image}',
                      fit: BoxFit.cover,
                      placeholder: (context, url) =>
                          const Center(child: CircularProgressIndicator()),
                      errorWidget: (context, url, error) =>
                          const Icon(Icons.error),
                    ),
                  ),
                ),
              )),
    );
  }
}

List<SliderModel> lsSliver = [
  SliderModel(id: '1', name: 'Khuyến mãi 10%'),
  SliderModel(id: '2', name: 'Khuyến mãi 20%'),
  SliderModel(id: '3', name: 'Khuyến mãi 30%'),
  SliderModel(id: '4', name: 'Khuyến mãi 40%'),
  SliderModel(id: '5', name: 'Khuyến mãi 50%'),
  SliderModel(id: '6', name: 'Khuyến mãi 60%'),
];
