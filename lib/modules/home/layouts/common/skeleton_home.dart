import 'package:flutter/material.dart';

import '../../../../components/skeleton/product_skeleton.dart';
import '../../../../components/skeleton/skeleton.dart';

class SkelatonHome extends StatelessWidget {
  const SkelatonHome({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8),
          child: SizedBox(
            height: 120,
            child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: 4,
                itemBuilder: (context, index) => SizedBox(
                      height: 84,
                      width: 84,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: [
                            Skeleton(
                              height: 60,
                            ),
                            const SizedBox(
                              height: 8,
                            ),
                            Skeleton(
                              height: 20,
                            ),
                          ],
                        ),
                      ),
                    )),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            children: [
              Row(
                children: const [
                  ItemSkeleton(),
                  SizedBox(
                    width: 16,
                  ),
                  ItemSkeleton(),
                ],
              ),
              const SizedBox(
                height: 16,
              ),
              Row(
                children: const [
                  ItemSkeleton(),
                  SizedBox(
                    width: 16,
                  ),
                  ItemSkeleton(),
                ],
              ),
              const SizedBox(
                height: 16,
              ),
              Row(
                children: const [
                  ItemSkeleton(),
                  SizedBox(
                    width: 16,
                  ),
                  ItemSkeleton(),
                ],
              ),
              const SizedBox(
                height: 16,
              ),
              Row(
                children: const [
                  ItemSkeleton(),
                  SizedBox(
                    width: 16,
                  ),
                  ItemSkeleton(),
                ],
              ),
              const SizedBox(
                height: 16,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
