import 'package:carousel_slider/carousel_slider.dart';

import '../../models/slider/slider_model.dart';
import 'item.dart';

// ignore: non_constant_identifier_names
MySlider() => CarouselSlider(
    options: CarouselOptions(
      aspectRatio: 2.0,
      autoPlay: true,
      enlargeCenterPage: true,
      enlargeStrategy: CenterPageEnlargeStrategy.zoom,
      enlargeFactor: 0.4,
    ),
    items: List.generate(lsSliver.length,
        (index) => iteamSlider(data: lsSliver[index])) //imageSliders,
    );

List<SliderModel> lsSliver = [
  SliderModel(id: '1', name: 'Khuyến mãi 10%'),
  SliderModel(id: '2', name: 'Khuyến mãi 20%'),
  SliderModel(id: '3', name: 'Khuyến mãi 30%'),
  SliderModel(id: '4', name: 'Khuyến mãi 40%'),
  SliderModel(id: '5', name: 'Khuyến mãi 50%'),
  SliderModel(id: '6', name: 'Khuyến mãi 60%'),
];
