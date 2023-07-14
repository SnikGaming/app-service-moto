import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

import '../../modules/home/layouts/pages/like_page.dart';

enum PaymentMethod { cash, card, mobile }

class Payment extends StatefulWidget {
  const Payment({super.key});

  @override
  State<Payment> createState() => _PaymentState();
}

class _PaymentState extends State<Payment> {
  PaymentMethod _selectedPaymentMethod = PaymentMethod.cash;
  void _handlePaymentMethodChange(PaymentMethod? value) {
    setState(() {
      _selectedPaymentMethod = value!;
    });
  }

  int _currentImageIndex = 0;

  @override
  Widget build(BuildContext context) {
    List<Widget> items = [
      SizedBox(
        height: 200,
        width: 250,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            RadioListTile<PaymentMethod>(
              title: const Text('Cash'),
              value: PaymentMethod.cash,
              groupValue: _selectedPaymentMethod,
              onChanged: _handlePaymentMethodChange,
            ),
            ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: Container(
                height: 100,
                width: 250,
                decoration: const BoxDecoration(
                  color: Color.fromARGB(255, 209, 206, 205),
                ),
                child: Column(
                  children: [
                    Text(
                      'Thanh toán khi nhận hàng',
                      style: h1.copyWith(color: Colors.white),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      SizedBox(
        height: 200,
        width: 250,
        child: Column(
          children: [
            RadioListTile<PaymentMethod>(
              title: const Text('Card'),
              value: PaymentMethod.card,
              groupValue: _selectedPaymentMethod,
              onChanged: _handlePaymentMethodChange,
            ),
            ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: Container(
                height: 100,
                width: 250,
                decoration: const BoxDecoration(
                  color: Color.fromARGB(255, 209, 206, 205),
                ),
                child: Column(
                  children: [
                    Text(
                      'Thanh toán khi nhận hàng',
                      style: h1.copyWith(color: Colors.white),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    ];

    return Container(
      alignment: Alignment.center,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.width / 2.0,
            child: CarouselSlider(
              options: CarouselOptions(
                aspectRatio: 2.0,
                // autoPlay: true,
                enlargeCenterPage: true,
                enlargeStrategy: CenterPageEnlargeStrategy.zoom,
                enlargeFactor: 1,
                onPageChanged: (index, reason) {
                  setState(() {
                    _currentImageIndex = index;
                  });
                },
              ),
              items: items,
            ),
          ),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(
              items.length,
              (index) => Container(
                height: 10,
                width: 10,
                margin: const EdgeInsets.symmetric(horizontal: 4),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color:
                      _currentImageIndex == index ? Colors.green : Colors.grey,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
