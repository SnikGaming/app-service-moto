import 'dart:math';

import 'package:app/models/services/service_model.dart';
import 'package:app/modules/home/layouts/pages/services_page.dart';
import 'package:flutter/material.dart';

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
    return SingleChildScrollView(
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: SizedBox(
          height: size.height,
          width: size.width,
          child: Column(
            children: [
              Container(
                height: size.height * .3,
                width: size.width,
                color: lsColor[Random().nextInt(lsColor.length)],
              ),
              Container(
                height: size.height * .3,
                width: size.width,
                color: lsColor[Random().nextInt(lsColor.length)],
              ),
              Container(
                height: size.height * .3,
                width: size.width,
                color: lsColor[Random().nextInt(lsColor.length)],
              ),
              Container(
                height: size.height * .3,
                width: size.width,
                color: lsColor[Random().nextInt(lsColor.length)],
              )
            ],
          ),
        ),
      ),
    );
  }
}
