// ignore_for_file: no_leading_underscores_for_local_identifiers

import 'dart:convert';

import 'package:app/components/message/message.dart';
import 'package:app/components/zoom/image.dart';
import 'package:app/modules/home/layouts/pages/services_page.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:rating_dialog/rating_dialog.dart';
import '../../../components/convert/calculate_time.dart';
import '../../../components/convert/format_money.dart';
import '../../../constants/style.dart';
import '../../../network/connect.dart';
import '../../home/api/products/models/products.dart' as products;
import 'package:in_app_review/in_app_review.dart';

import '../../home/api/review/api_review.dart';
import '../../home/api/review/models/review.dart' as review;
import '../api/product.dart';
import '../module/cart.dart';

class DetailsServiceScreen extends StatefulWidget {
  final int id;
  const DetailsServiceScreen({super.key, required this.id});

  @override
  State<DetailsServiceScreen> createState() => _DetailsServiceScreenState();
}

class _DetailsServiceScreenState extends State<DetailsServiceScreen> {
  late Future<products.Data> dataFuture;
  List<review.Data> lsReview = [];
  products.Data? data;

  @override
  void initState() {
    super.initState();
    loadData();
  }

  String submitRatingAndComment(double rating, String? comment) {
    // create a map with the necessary data
    int ratingInt = rating.toInt();
    Map<String, dynamic> jsonData = {
      "product_id": widget.id.toString(),
      "comment": comment,
      "rating": ratingInt.toString(),
      "time": DateTime.now().toString()
    };

    // convert the map to a JSON string
    String jsonString = jsonEncode(jsonData);

    print('JSON data: $jsonString');
    return jsonString;
  }

  Future<int> sendReview(String json) async {
    print('review data send  $json');
    var res = await APIReview.add(json: json);
    loadData();
    return res;
  }

  Future<void> loadData() async {
    data = await getProductDetail(id: widget.id);
    var a = await APIReview.getData(id: widget.id);
    print('review data send $a');
    lsReview = APIReview.apiData;
    setState(() {});
  }

  void _showRatingDialog() {
    // actual store listing review & rating
    void _rateAndReviewApp() async {
      // refer to: https://pub.dev/packages/in_app_review
      final inAppReview = InAppReview.instance;

      if (await inAppReview.isAvailable()) {
        print('request actual review from store');
        inAppReview.requestReview();
      } else {
        print('open actual store listing');
        // TODO: use your own store ids
        inAppReview.openStoreListing(
          appStoreId: '<your app store id>',
          microsoftStoreId: '<your microsoft store id>',
        );
      }
    }

    final dialog = RatingDialog(
      initialRating: 1.0,
      // your app's name?
      title: const Text(
        'Rating Dialog',
        textAlign: TextAlign.center,
        style: TextStyle(
          fontSize: 25,
          fontWeight: FontWeight.bold,
        ),
      ),
      // encourage your user to leave a high rating?
      message: const Text(
        'Tap a star to set your rating. Add more description here if you want.',
        textAlign: TextAlign.center,
        style: TextStyle(fontSize: 15),
      ),
      // your app's logo?
      image: const FlutterLogo(size: 100),
      submitButtonText: 'Submit',
      commentHint: 'Set your custom comment hint',
      onCancelled: () => print('submit cancelled'),
      onSubmitted: (response) async {
        print(
            'submit rating: ${response.rating}, comment: ${response.comment}');
//! add comment
        String jsonData =
            submitRatingAndComment(response.rating, response.comment);
        int res = await sendReview(jsonData);
        if (res == 201) {
          Message.success(
              message: 'Cảm ơn đã đánh giá sản phẩm >_< ', context: context);
        } else {
          Message.error(message: 'Đã có vấn đề gì đó', context: context);
        }
        // TODO: add your own logic
        if (response.rating < 3.0) {
          // send their comments to your email or anywhere you wish
          // ask the user to contact you instead of leaving a bad review
        } else {
          _rateAndReviewApp();
        }
      },
    );

    // show the dialog
    showDialog(
      context: context,
      barrierDismissible: true, // set to false if you want to force a rating
      builder: (context) => dialog,
    );
  }

  int i = 0;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return data == null
        ? Scaffold(
            body: Container(
            height: size.height,
            width: size.width,
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/loading.gif'),
              ),
            ),
          ))
        : Scaffold(
            appBar: AppBar(
              title: Text('Purchase ${data!.name}'),
            ),
            floatingActionButton: Cart(data: data!, size: size),
            body: Container(
              color: const Color(0xffF0F0F0),
              height: MediaQuery.of(context).size.height,
              width: size.width,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: ListView(
                  children: [
                    SizedBox(
                      height: size.height * .6,
                      width: size.width,
                      // color: randomColor(),
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          Positioned(
                            top: 150,
                            child: Container(
                              height: size.height * .4,
                              width: size.width * .7,
                              decoration: BoxDecoration(
                                color: const Color(0xffFFFFFF),
                                borderRadius: BorderRadius.circular(18),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.withOpacity(1),
                                    spreadRadius: 2,
                                    blurRadius: 10,
                                    offset: const Offset(0, 3),
                                  ),
                                ],
                              ),
                              child: Stack(
                                children: [
                                  //!: Content
                                  Positioned(
                                    bottom: 0,
                                    child: Container(
                                      height: size.height * .26,
                                      width: size.width * .7,
                                      decoration: const BoxDecoration(
                                          // color: Colors.blue,
                                          borderRadius: BorderRadius.only(
                                              bottomLeft: Radius.circular(18),
                                              bottomRight:
                                                  Radius.circular(18))),
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: 16,
                                        ),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            // const SizedBox(
                                            //   height: 14,
                                            // ),
                                            SizedBox(
                                              width: size.width,
                                              child: Text(
                                                '${data!.name}',
                                                style: styleH2,
                                                softWrap: true,
                                              ),
                                            ),
                                            const SizedBox(
                                              height: 10,
                                            ),
                                            SizedBox(
                                              width: size.width,
                                              child: Text(
                                                'Số lượng ${data!.number}',
                                                style: styleH3,
                                                softWrap: true,
                                              ),
                                            ),
                                            const SizedBox(
                                              height: 10,
                                            ),
                                            Container(
                                              width: 160,
                                              alignment: Alignment.center,
                                              child: Row(
                                                children: List.generate(
                                                  5,
                                                  (i) => const Icon(Icons.star),
                                                ),
                                              ),
                                            ),
                                            const SizedBox(
                                              height: 10,
                                            ),
                                            Container(
                                              padding: const EdgeInsets.all(12),
                                              decoration: BoxDecoration(
                                                color: Colors.black,
                                                borderRadius:
                                                    BorderRadius.circular(18),
                                              ),
                                              child: Text(
                                                formatCurrency(
                                                    amount: '${data!.price}'),
                                                style: styleH3.copyWith(
                                                    color: Colors.red),
                                              ),
                                            ),
                                            const SizedBox(
                                              height: 10,
                                            ),
                                            Text(
                                              'Số lượng : ${data!.number}',
                                              style: styleTitle.copyWith(
                                                  color: Colors.grey),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                          //!: Image
                          Positioned(
                            top: 30,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(18),
                              child: SizedBox(
                                height: size.height * .27,
                                width: size.width * .6,
                                child: Stack(
                                  alignment: Alignment.center,
                                  children: [
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(16),
                                      child: zoomImage(
                                        imageProvider: NetworkImage(
                                            '${ConnectDb.url}${data!.image}'),
                                        child: Image.network(
                                            '${ConnectDb.url}${data!.image}'),
                                      ),
                                    ),
                                    Positioned(
                                      right: 10,
                                      top: 10,
                                      child: IconButton(
                                        onPressed: () {},
                                        icon: const Icon(
                                          Icons.favorite,
                                          color: Colors.red,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    // Trong widget build, sau phần hiển thị thông tin sản phẩm, thêm đoạn code sau

                    Container(
                      constraints:
                          BoxConstraints(minHeight: 100, minWidth: size.width),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: 20),
                          const Text('Thông tin sản phẩm', style: styleH1),
                          const SizedBox(height: 16),
                          Row(
                            children: [
                              Text(
                                'Nhấn vào đây để ',
                                style: styleNormal.copyWith(
                                  color: Colors.grey,
                                  fontStyle: FontStyle.italic,
                                ),
                              ),
                              GestureDetector(
                                onTap: _showRatingDialog,
                                child: Text(
                                  '(Đánh giá sản phẩm này)',
                                  style: styleNormal.copyWith(
                                    color: Colors.blue,
                                    fontSize: 18,
                                    fontStyle: FontStyle.italic,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 10),
                          Row(
                            children: [
                              Text(
                                'Số lượt yêu thích : ',
                                style: styleNormal.copyWith(color: Colors.grey),
                              ),
                              Text(
                                '${data!.like}',
                                style: styleNormal.copyWith(
                                  color: Colors.red,
                                  fontSize: 18,
                                ),
                              ),
                              const SizedBox(width: 8),
                              const Icon(
                                Icons.favorite,
                                color: Colors.red,
                              ),
                            ],
                          ),
                          const SizedBox(height: 8),
                          Text(
                            '${data!.description}',
                            style: styleTitle,
                          ),
                          const SizedBox(height: 16),
                          Text(
                            'Các đánh giá khách hàng:',
                            style: styleNormal.copyWith(
                                fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(height: 8),
                          ListView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: lsReview.length,
                            itemBuilder: (context, index) {
                              return Padding(
                                padding:
                                    const EdgeInsets.only(top: 10, bottom: 10),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        CachedNetworkImage(
                                          imageUrl:
                                              '${ConnectDb.url}${lsReview[index].user!.imageUrl}',
                                          height: 45,
                                          width: 45,
                                          placeholder: (context, url) =>
                                              const CircularProgressIndicator(),
                                          errorWidget: (context, url, error) =>
                                              const Icon(Icons.error),
                                          imageBuilder:
                                              (context, imageProvider) =>
                                                  ClipOval(
                                            child: Image(
                                              image: imageProvider,
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                        ),
                                        const SizedBox(
                                          width: 8,
                                        ),
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(lsReview[index].user!.name!,
                                                style: subTitle.copyWith()),
                                            Text(
                                                calculateTimeDifference(
                                                    DateTime.parse(
                                                        lsReview[index].time!)),
                                                style: subTitle.copyWith(
                                                    color: Colors.grey)),
                                          ],
                                        )
                                      ],
                                    ),
                                    SizedBox(
                                      height: 30,
                                      child: Row(
                                        children: List.generate(
                                          lsReview[index].rating!,
                                          (index) => const Icon(
                                            Icons.star,
                                            size: 16,
                                          ),
                                        ),
                                      ),
                                    ),
                                    Text(
                                      lsReview[index].comment ??
                                          "Không có bình luận.",
                                      style: lsReview[index].comment != null
                                          ? styleNormal
                                          : styleNormal.copyWith(
                                              color: Colors.grey,
                                            ),
                                    ),
                                  ],
                                ),
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ));
  }
}
