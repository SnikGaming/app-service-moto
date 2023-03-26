import 'dart:math';

import 'package:app/models/slider/slider_model.dart';
import 'package:flutter/material.dart';

import '../../modules/home/layouts/pages/services_page.dart';

iteamSlider({void Function()? onTap, SliderModel? data}) => GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: Container(
            color: lsColor[Random().nextInt(lsColor.length)],
            child: Text('${data?.name}'),
          ),
        ),
      ),
    );
