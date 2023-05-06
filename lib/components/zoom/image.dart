// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';

class ImageZoom extends StatefulWidget {
  final String imageUrl;

  const ImageZoom({super.key, required this.imageUrl});

  @override
  _ImageZoomState createState() => _ImageZoomState();
}

class _ImageZoomState extends State<ImageZoom> {
  late double _scale;
  late double _previousScale;
  late double _initialScale;

  @override
  void initState() {
    super.initState();
    _scale = 1.0;
    _previousScale = 1.0;
    _initialScale = 1.0;
  }

  void _onScaleStart(ScaleStartDetails details) {
    setState(() {
      _previousScale = _scale;
      _initialScale = _scale;
    });
  }

  void _onScaleUpdate(ScaleUpdateDetails details) {
    setState(() {
      _scale = _previousScale * details.scale;
    });
  }

  void _onScaleEnd(ScaleEndDetails details) {
    setState(() {
      _previousScale = _scale;
      if (_scale < _initialScale) {
        _scale = _initialScale;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onScaleStart: _onScaleStart,
      onScaleUpdate: _onScaleUpdate,
      onScaleEnd: _onScaleEnd,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10.0),
        child: Image.network(
          widget.imageUrl,
          fit: BoxFit.cover,
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          alignment: Alignment.center,
          filterQuality: FilterQuality.high,
          loadingBuilder: (BuildContext context, Widget child,
              ImageChunkEvent? loadingProgress) {
            if (loadingProgress == null) {
              return child;
            }
            return Center(
              child: CircularProgressIndicator(
                value: loadingProgress.expectedTotalBytes != null
                    ? loadingProgress.cumulativeBytesLoaded /
                        loadingProgress.expectedTotalBytes!
                    : null,
              ),
            );
          },
        ),
      ),
    );
  }
}
