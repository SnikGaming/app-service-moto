// ignore_for_file: must_be_immutable, library_private_types_in_public_api

import 'dart:math';

import 'package:flutter/material.dart';

class Skeleton extends StatefulWidget {
  double? height;
  double? width;
  Skeleton({Key? key, this.height, this.width}) : super(key: key);

  @override
  _SkeletonState createState() => _SkeletonState();
}

class _SkeletonState extends State<Skeleton>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    )..repeat(reverse: true);
    _animation = Tween<Offset>(
      begin: Offset.zero,
      end: const Offset(1.0, 0.0),
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    ));
    _animation.addListener(() {
      Future.delayed(const Duration(seconds: 1))
          .then((value) => setStateIfMounted(() {}));
    });
  }

  void setStateIfMounted(VoidCallback fn) {
    if (mounted) {
      setState(fn);
    }
  }

  @override
  void dispose() {
    _controller.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: widget.height,
      width: widget.width,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        gradient: LinearGradient(
          colors: [
            Colors.grey[100]!,
            Colors.black.withOpacity(Random().nextDouble() * 0.7 + 0.2),
            Colors.grey[100]!,
          ],
          stops: const [0.0, 0.5, 1.0],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          tileMode: TileMode.repeated,
          transform: GradientRotation(_animation.value.dx * 3 * pi),
        ),
      ),
    );
  }
}
