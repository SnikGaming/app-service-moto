// ignore_for_file: no_leading_underscores_for_local_identifiers, use_build_context_synchronously

import 'dart:convert';

import 'package:app/components/message/message.dart';
import 'package:app/components/zoom/image.dart';
import 'package:app/functions/random_color.dart';
import 'package:app/modules/home/layouts/pages/like_page.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:lottie/lottie.dart';
import 'package:rating_dialog/rating_dialog.dart';
import '../../../components/calendar/res/colors.dart';
import '../../../components/convert/calculate_time.dart';
import '../../../components/convert/format_money.dart';
import '../../../components/value_app.dart';
import '../../../constants/style.dart';
import '../../../network/connect.dart';
import '../../../preferences/user/user_preferences.dart';
import '../../../api/products/models/products.dart' as products;
import 'package:in_app_review/in_app_review.dart';

import '../../../api/review/api_review.dart';
import '../../../api/review/models/review.dart' as review;
import '../api/product.dart';
import '../module/cart.dart';

class DetailsServiceScreen extends StatefulWidget {
  final String id;
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
    await APIReview.getData(id: widget.id);
    // print('review data send $a');
    lsReview = APIReview.apiData;
    // print('abc------->>>>>>>>>>>>>>>> ');
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
        productReviews,
        textAlign: TextAlign.center,
        style: TextStyle(
          fontSize: 25,
          fontWeight: FontWeight.bold,
        ),
      ),
      // encourage your user to leave a high rating?
      message: const Text(
        txtRateReview,
        textAlign: TextAlign.center,
        style: TextStyle(fontSize: 15),
      ),
      // your app's logo?
      image: Image.asset(
        txtLogon,
        height: 100,
      ), // const FlutterLogo(size: 100),
      submitButtonText: txtSend,
      commentHint: txtReviewProduct,
      onCancelled: () => print('submit cancelled'),
      onSubmitted: (response) async {
        print(
            'submit rating: ${response.rating}, comment: ${response.comment}');
//! add comment
        String jsonData =
            submitRatingAndComment(response.rating, response.comment);
        int res = await sendReview(jsonData);
        if (res == 201) {
          Message.success(message: successfulProductReview, context: context);
        } else {
          Message.error(message: errorProductReview, context: context);
        }
        // TODO: add your own logic
        if (response.rating < 3.0) {
          Message.success(
              message: 'Có vẻ sản phẩm không làm hài lòng bạn lắm.',
              context: context);
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
  void updateCartData() {
    loadData();
  }

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
                image: AssetImage(loadingImage),
              ),
            ),
          ))
        : Scaffold(
            appBar: AppBar(
              title: Text('${data!.name}'),
              backgroundColor: const Color.fromARGB(255, 113, 66, 223),
            ),
            floatingActionButton:
                UserPrefer.getToken() == null || UserPrefer.getToken() == 'null'
                    ? null
                    : data!.number! > 0
                        ? Cart(
                            data: data!,
                            size: size,
                            updateCartData: updateCartData,
                          )
                        : null,
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
                                      // height: size.height * .26,
                                      constraints: BoxConstraints(
                                          minHeight: size.height * .18),
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
                                              height: 16,
                                            ),
                                            Text(
                                              'Số lượng : ${data!.number}',
                                              style: styleTitle.copyWith(
                                                  color: Colors.grey),
                                            ),
                                            const SizedBox(
                                              height: 16,
                                            ),
                                            // Container(
                                            //   width: 160,
                                            //   alignment: Alignment.center,
                                            //   child: Row(
                                            //     children: List.generate(
                                            //       5,
                                            //       (i) => const Icon(Icons.star),
                                            //     ),
                                            //   ),
                                            // ),
                                            // const SizedBox(
                                            //   height: 16,
                                            // ),
                                            Container(
                                              padding: const EdgeInsets.all(12),
                                              decoration: BoxDecoration(
                                                color: Colors.black,
                                                borderRadius:
                                                    BorderRadius.circular(18),
                                              ),
                                              child: Text(
                                                data!.number! > 0
                                                    ? formatCurrency(
                                                        amount:
                                                            '${data!.price}')
                                                    : outOfStock,
                                                style: styleH3.copyWith(
                                                  color: Colors.red,
                                                ),
                                              ),
                                            ),
                                            const SizedBox(
                                              height: 10,
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
                                onTap: UserPrefer.getToken() == null && false
                                    ? () {
                                        Message.warning(
                                            message:
                                                'Vui lòng đăng nhập vào hệ thống để sử dụng chức năng này.',
                                            context: context);
                                      }
                                    : _showRatingDialog,
                                child: Text(
                                  '(Bấm vào đây để đánh giá)',
                                  style: styleNormal.copyWith(
                                    color: Colors.blue,
                                    fontSize: 16,
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
                                'Đã bán : ',
                                style: styleNormal.copyWith(color: Colors.grey),
                              ),
                              Text(
                                '${data!.like}',
                                style: styleNormal.copyWith(
                                  color: Colors.blue,
                                  fontSize: 18,
                                ),
                              ),
                              const SizedBox(width: 8),
                              const Icon(
                                Ionicons.cart_outline,
                                color: Colors.blue,
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
                                        lsReview[index].user!.imageUrl ==
                                                "/storage/user/Null"
                                            ? Container(
                                                height: 45,
                                                width: 45,
                                                decoration: const BoxDecoration(
                                                  color: violet,
                                                  shape: BoxShape.circle,
                                                ),
                                                child: Lottie.network(
                                                    'https://assets10.lottiefiles.com/packages/lf20_1mvhccet.json'),
                                              )
                                            : CachedNetworkImage(
                                                imageUrl:
                                                    '${ConnectDb.url}${lsReview[index].user!.imageUrl}',
                                                height: 45,
                                                width: 45,
                                                placeholder: (context, url) =>
                                                    const CircularProgressIndicator(),
                                                errorWidget:
                                                    (context, url, error) =>
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
