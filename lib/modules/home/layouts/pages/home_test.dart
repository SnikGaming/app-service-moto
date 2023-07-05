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
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(16),
      child: Container(
        decoration: const BoxDecoration(
          // color: const Color.fromARGB(57, 120, 52, 239),
          color: Colors.white,
        ),
        child: SkeletonItem(
            child: Column(
          children: [
            SkeletonAvatar(
              style: SkeletonAvatarStyle(
                width: 150,
                height: 200,
                borderRadius: BorderRadius.circular(16),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Expanded(
                child: SkeletonParagraph(
                  style: SkeletonParagraphStyle(
                    lines: 3,
                    spacing: 6,
                    lineStyle: SkeletonLineStyle(
                      randomLength: true,
                      height: 10,
                      borderRadius: BorderRadius.circular(8),
                      minLength: MediaQuery.of(context).size.width / 6,
                      maxLength: MediaQuery.of(context).size.width / 3,
                    ),
                  ),
                ),
              ),
            ),
            const Spacer(),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Expanded(
                    child: SkeletonParagraph(
                      style: SkeletonParagraphStyle(
                        lines: 1,
                        spacing: 6,
                        lineStyle: SkeletonLineStyle(
                          randomLength: true,
                          height: 10,
                          borderRadius: BorderRadius.circular(8),
                          minLength: MediaQuery.of(context).size.width / 5,
                          maxLength: MediaQuery.of(context).size.width / 3,
                        ),
                      ),
                    ),
                  ),
                  const SkeletonAvatar(
                    style: SkeletonAvatarStyle(
                      width: 30,
                      height: 30,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 10,
            )
          ],
        )),
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
      width: 90,
      height: 70,
      decoration: BoxDecoration(
        color: const Color.fromARGB(57, 120, 52, 239),
        borderRadius: BorderRadius.circular(16),
      ),
      child: SkeletonItem(
          child: Column(
        children: [
          const SizedBox(
            height: 10,
          ),
          const SkeletonAvatar(
            style: SkeletonAvatarStyle(
              width: 40,
              height: 30,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 5),
            child: Expanded(
              child: SkeletonParagraph(
                style: SkeletonParagraphStyle(
                  lines: 1,
                  spacing: 6,
                  lineStyle: SkeletonLineStyle(
                    randomLength: true,
                    height: 10,
                    borderRadius: BorderRadius.circular(8),
                    minLength: MediaQuery.of(context).size.width / 5,
                    maxLength: MediaQuery.of(context).size.width / 3,
                  ),
                ),
              ),
            ),
          )
        ],
      )),
    );
  }
}
