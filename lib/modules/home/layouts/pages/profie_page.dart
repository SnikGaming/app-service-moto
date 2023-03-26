import 'package:app/components/style/textstyle.dart';
import 'package:flutter/material.dart';

class ProFilePage extends StatefulWidget {
  const ProFilePage({super.key});

  @override
  State<ProFilePage> createState() => _ProFilePageState();
}

class _ProFilePageState extends State<ProFilePage> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
        width: size.width,
        height: size.height,
        decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage('assets/images/background_image.png'),
              fit: BoxFit.cover),
        ),
        child: Column(
          children: [
            const SizedBox(
              height: 20,
            ),
            Container(
              height: 170,
              width: 170,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.purple,
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Text(
              'Trần Thới Long',
              style: MyTextStyle.title.copyWith(fontSize: 30),
            ),
            TextButton(
              onPressed: () {},
              child: const Text('Update my profile', style: MyTextStyle.normal),
            ),
            Expanded(
                child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Container(
                // color: Colors.red,
                child: ListView(
                  children: [
                    ClipRRect(
                      child: Container(
                        width: size.width,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text('Total spending 2023',
                                style: MyTextStyle.normal),
                            Row(
                              children: [
                                Text(
                                  '0đ',
                                  style:
                                      MyTextStyle.normal.copyWith(fontSize: 30),
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                Image.asset(
                                  'assets/icons/user/money.png',
                                  height: 40,
                                )
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                    const Divider(
                      thickness: 1,
                      color: Colors.white,
                    ),
                    ClipRRect(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          _itemButton(
                              image: 'assets/icons/user/booking.png',
                              text: 'BOOKING'),
                          _itemButton(
                              image: 'assets/icons/user/bill.png',
                              text: 'BILLS'),
                          _itemButton(
                              image: 'assets/icons/user/information.png',
                              text: 'INFORMATION'),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    ClipRRect(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          _itemButton(
                              image: 'assets/icons/user/gift.png',
                              text: 'NEW &\nOFFERS'),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ))
          ],
        ),
      ),
    );
  }

  GestureDetector _itemButton({required String image, required String text}) {
    return GestureDetector(
      onTap: () {},
      child: Column(
        children: [
          Image.asset(
            image,
            height: 60,
          ),
          Text(
            text,
            style: MyTextStyle.normal,
          )
        ],
      ),
    );
  }
}
