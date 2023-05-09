// ignore_for_file: camel_case_types

import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';

// ignore: must_be_immutable
class zoomImage extends StatelessWidget {
  ImageProvider<Object>? imageProvider;
  Widget? child;
  zoomImage({super.key, required this.imageProvider, this.child});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: child,
      onTap: () {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return Dialog(
              backgroundColor: Colors.transparent,
              child: GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                },
                child: PhotoView(
                  imageProvider: imageProvider,
                  minScale: PhotoViewComputedScale.contained * 0.8,
                  maxScale: PhotoViewComputedScale.covered * 2,
                  backgroundDecoration: const BoxDecoration(
                    color: Colors.transparent,
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }
}
