import 'package:app/api/banner/api_banner.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../network/connect.dart';

class MySlider extends StatefulWidget {
  const MySlider({super.key});

  @override
  State<MySlider> createState() => _MySliderState();
}

class _MySliderState extends State<MySlider> {
  int _currentImageIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            width: 330, height: 200,
            // width: MediaQuery.of(context).size.width,
            // height: MediaQuery.of(context).size.width / 2.0,
            child: CarouselSlider(
              options: CarouselOptions(
                aspectRatio: 2.0,
                autoPlay: true,
                enlargeCenterPage: true,
                enlargeStrategy: CenterPageEnlargeStrategy.zoom,
                enlargeFactor: 0.4,
                onPageChanged: (index, reason) {
                  setState(() {
                    _currentImageIndex = index;
                  });
                },
              ),
              items: List.generate(
                APIBanner.apiBanner.length,
                (index) => GestureDetector(
                  onTap: () async {
                    // final Uri url = Uri(
                    //   scheme: 'https',
                    //   host: 'www.facebook.com',
                    //   path: '/messages/t/100025852802716',
                    // );

                    final Uri url = Uri(
                      scheme: 'https',
                      host: '123website.com.vn',
                      path:
                          '/danh-muc-san-pham/mau-website-dich-vu/mau-website-dich-vu-sua-xe/',
                    );
                    if (!await launchUrl(url)) {
                      throw Exception('Could not launch $url');
                    }
                  },
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(18),
                    child: SizedBox(
                      child: CachedNetworkImage(
                        imageUrl:
                            '${ConnectDb.url}${APIBanner.apiBanner[index].image}',
                        fit: BoxFit.cover,
                        placeholder: (context, url) =>
                            const Center(child: CircularProgressIndicator()),
                        errorWidget: (context, url, error) =>
                            const Icon(Icons.error),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(
              APIBanner.apiBanner.length,
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
