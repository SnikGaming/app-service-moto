
import 'package:app/components/skeleton/skeleton.dart';
import 'package:flutter/material.dart';


class ItemSkeleton extends StatelessWidget {
  const ItemSkeleton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: SizedBox(
      height: 280,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
                child: Skeleton(
              height: 120,
            )),
            const SizedBox(
              height: 8,
            ),
            Skeleton(
              height: 16,
            ),
            const SizedBox(
              height: 8,
            ),
            Skeleton(
              height: 16,
              width: 80,
            ),
            const SizedBox(
              height: 8,
            ),
            Skeleton(
              height: 16,
              width: 40,
            ),
            const SizedBox(
              height: 8,
            ),
            Row(
              children: [
                Expanded(
                  flex: 1,
                  child: Skeleton(
                    height: 16,
                  ),
                ),
                const SizedBox(
                  width: 8,
                ),
                Expanded(
                  flex: 2,
                  child: Skeleton(
                    height: 16,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    ));
  }
}

