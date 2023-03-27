import 'package:app/models/services/service_model.dart';
import 'package:flutter/material.dart';

class DetailsServiceScreen extends StatefulWidget {
  final List<ServiceModel> data;
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
        height: size.height,
        width: size.width,
      ),
    );
  }
}
