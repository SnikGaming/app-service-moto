import 'package:app/modules/home/api/banner/api_banner.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

import '../../network/connect.dart';

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
                child: SizedBox(
                  height: 200,
                  width: 270,
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
              )),
    );
  }
}
