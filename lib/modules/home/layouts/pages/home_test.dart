import 'dart:math';

import 'package:flutter/material.dart';
import 'package:skeletons/skeletons.dart';

class CusThemeSkeletonProducts extends StatelessWidget {
  const CusThemeSkeletonProducts({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const SkeletonTheme(
      themeMode: ThemeMode.light,
      shimmerGradient: LinearGradient(
        colors: [
          // Color(0xFFD8E3E7),
          // Color(0xFFC8D5DA),
          // Color(0xFFD8E3E7),
          Color.fromARGB(255, 174, 171, 230),
          Color.fromARGB(255, 179, 131, 246),
          Color.fromARGB(255, 129, 83, 248),
        ],
        stops: [
          0.1,
          0.5,
          0.9,
        ],
      ),
      darkShimmerGradient: LinearGradient(
        colors: [
          Color(0xFF222222),
          Color(0xFF242424),
          Color(0xFF2B2B2B),
          Color(0xFF242424),
          Color(0xFF222222),
        ],
        stops: [
          0.0,
          0.2,
          0.5,
          0.8,
          1,
        ],
        begin: Alignment(-2.4, -0.2),
        end: Alignment(2.4, 0.2),
        tileMode: TileMode.clamp,
      ),
      child: CusSkeletonProduct(),
    );
  }
}

class CusSkeletonProduct extends StatelessWidget {
  const CusSkeletonProduct({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(16),
      child: Container(
        decoration: const BoxDecoration(
          color: Colors.white,
        ),
        child: SkeletonItem(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SkeletonAvatar(
                style: SkeletonAvatarStyle(
                  width: 150,
                  height: 200,
                  borderRadius: BorderRadius.circular(16),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              SkeletonAvatar(
                style: SkeletonAvatarStyle(
                  width: 40 + Random().nextDouble() * 80,
                  height: 10,
                  borderRadius: BorderRadius.circular(16),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              SkeletonAvatar(
                style: SkeletonAvatarStyle(
                  width: 40 + Random().nextDouble() * 80,
                  height: 10,
                  borderRadius: BorderRadius.circular(16),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              SkeletonAvatar(
                style: SkeletonAvatarStyle(
                  width: 40 + Random().nextDouble() * 70,
                  height: 10,
                  borderRadius: BorderRadius.circular(16),
                ),
              ),
              // const Spacer(),
              Row(
                children: [
                  SkeletonAvatar(
                    style: SkeletonAvatarStyle(
                      width: 40 + Random().nextDouble() * 60,
                      height: 10,
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                  Spacer(),
                  SkeletonAvatar(
                    style: SkeletonAvatarStyle(
                      width: 30,
                      height: 30,
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  )
                ],
              ),
              // const SizedBox(
              //   height: 10,
              // )
            ],
          ),
        ),
      ),
    );
  }
}

class CusThemeSkeletonCategories extends StatelessWidget {
  const CusThemeSkeletonCategories({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const SkeletonTheme(
      themeMode: ThemeMode.light,
      shimmerGradient: LinearGradient(
        colors: [
          // Color(0xFFD8E3E7),
          // Color(0xFFC8D5DA),
          // Color(0xFFD8E3E7),
          Color.fromARGB(255, 174, 171, 230),
          Color.fromARGB(255, 179, 131, 246),
          Color.fromARGB(255, 129, 83, 248),
        ],
        stops: [
          0.1,
          0.5,
          0.9,
        ],
      ),
      darkShimmerGradient: LinearGradient(
        colors: [
          Color(0xFF222222),
          Color(0xFF242424),
          Color(0xFF2B2B2B),
          Color(0xFF242424),
          Color(0xFF222222),
        ],
        stops: [
          0.0,
          0.2,
          0.5,
          0.8,
          1,
        ],
        begin: Alignment(-2.4, -0.2),
        end: Alignment(2.4, 0.2),
        tileMode: TileMode.clamp,
      ),
      child: CusSkeletonCategory(),
    );
  }
}

class CusSkeletonCategory extends StatelessWidget {
  const CusSkeletonCategory({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 80,
      height: 60,
      decoration: BoxDecoration(
        color: const Color.fromARGB(57, 120, 52, 239),
        borderRadius: BorderRadius.circular(16),
      ),
      child: const SkeletonItem(
          child: Column(
        children: [
          SizedBox(
            height: 10,
          ),
          SkeletonAvatar(
            style: SkeletonAvatarStyle(
              width: 40,
              height: 30,
            ),
          ),
          SizedBox(
            height: 10,
          ),
          SkeletonAvatar(
            style: SkeletonAvatarStyle(
              width: 40,
              height: 10,
            ),
          ),
        ],
      )),
    );
  }
}
