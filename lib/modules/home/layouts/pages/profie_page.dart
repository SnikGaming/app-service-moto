// ignore_for_file: use_key_in_widget_constructors

import 'package:app/components/CusRichText/CusRichText.dart';
import 'package:app/components/mybage/mybage.dart';
import 'package:app/functions/random_color.dart';
import 'package:app/modules/home/api/order/order.dart' as order;
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_paypal/flutter_paypal.dart';
import 'package:ionicons/ionicons.dart';
import '../../../../components/button/mybutton.dart';
import '../../../../components/convert/format_money.dart';
import '../../../../components/districts/a.dart';
import '../../../../components/style/text_style.dart';
import '../../../../network/connect.dart';
import '../../../../preferences/user/user_preferences.dart';
import '../../api/login/api_login.dart';
import '../../api/order/api_order.dart';
import 'dart:convert';

import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:http/http.dart' as http;

class ProFilePage extends StatefulWidget {
  const ProFilePage({super.key});

  @override
  State<ProFilePage> createState() => _ProFilePageState();
}

class _ProFilePageState extends State<ProFilePage> {
  List<order.Data> lsData = [];
  int indexSelect = -1;
  loadData({int? status}) async {
    if (status != null) {
      await APIOrder.fetchOrder(status: status);
    } else {
      await APIOrder.fetchOrder();
    }
    lsData = APIOrder.lsData;

    var dataStatus = await APIOrder.fetchOrderStatus();
    if (dataStatus != []) {
      try {
        MyOrder.lsMyOrder[0].bage =
            dataStatus['status_2'].toString(); //!: Huy doi tra
        MyOrder.lsMyOrder[1].bage =
            dataStatus['status_1'].toString(); //!: Chờ vận chuyển
        MyOrder.lsMyOrder[2].bage =
            dataStatus['status_3'].toString(); //!: Chờ giao hàng

        MyOrder.lsMyOrder[3].bage =
            dataStatus['status_4'].toString(); //!: Chưa đánh giá
        // MyOrder.lsMyOrder[4].bage =
        //     dataStatus['status_2'].toString(); //!: Đổi trả
      } catch (e) {
        print(e);
      }
    }

    setState(() {});
  }

  Map<String, dynamic>? paymentIntent;

  void makePayment() async {
    try {
      paymentIntent = await createPaymentIntent();
      var gpay = const PaymentSheetGooglePay(
          merchantCountryCode: 'US', currencyCode: "US", testEnv: true);
      await Stripe.instance.initPaymentSheet(
        paymentSheetParameters: SetupPaymentSheetParameters(
          paymentIntentClientSecret: paymentIntent!['client_secret'],
          style: ThemeMode.dark,
          merchantDisplayName: "Sabir",
          googlePay: gpay,
        ),
      );
      displayPaymentSheet();
    } catch (e) {
      print(e);
      throw e;
    }
  }

  displayPaymentSheet() async {
    try {
      await Stripe.instance.presentPaymentSheet();
      print('Payment--> Done');
    } catch (e) {
      print(e);
      print('Payment--> Done');
    }
  }

  createPaymentIntent() async {
    try {
      Map<String, dynamic> body = {"amount": "1000", "currency": "US"};
      http.Response response = await http.post(
          Uri.parse("https://api.stripe.com/v1/payment_intents"),
          body: body,
          headers: {
            "Authorization":
                "Bearer sk_test_51MWx8OAVMyklfe3C3gP4wKOhTsRdF6r1PYhhg1PqupXDITMrV3asj5Mmf0G5F9moPL6zNfG3juK8KHgV9XNzFPlq00wmjWwZYA",
            "Content-Type": "application/x-www-form-urlencoded"
          });
      return json.decode(response.body);
    } catch (e) {
      print(e);
      throw Exception(e.toString());
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loadData();
  }

  bool _isExpanded = false;
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      body: SizedBox(
        height: size.height,
        width: size.width,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            children: [
              const SizedBox(
                height: 24,
              ),
              //!: User
              const UserProfile(),
              const SizedBox(
                height: 16,
              ),
              //!: Đơn hàng của tôi
              SizedBox(
                height: 140,
                width: size.width,
                // color: Colors.green,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Đơn hàng của tôi',
                      style: h2.copyWith(
                        color: Colors.black,
                      ),
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    SizedBox(
                      // color: Colors.green,
                      height: 90,
                      width: size.width,
                      // color: Colors.purple,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: MyOrder.lsMyOrder.length,
                        itemBuilder: (context, i) {
                          var data = MyOrder.lsMyOrder[i];
                          return Padding(
                            padding: const EdgeInsets.all(4.0),
                            child: GestureDetector(
                              onTap: () {
                                indexSelect = i;
                                setState(() {});
                                loadData(status: data.id);
                              },
                              child: Container(
                                height: 50,
                                width: 80,
                                decoration: BoxDecoration(
                                  color: indexSelect == i
                                      ? Colors.red
                                      : Colors.purple.shade400,
                                  borderRadius: BorderRadius.circular(18),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(4.0),
                                  child: Column(
                                    children: [
                                      MyBage(
                                        value: data.bage!,
                                        child: Image.asset(
                                          data.image,
                                          height: 25,
                                          width: 25,
                                          color: Colors.white,
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 4,
                                      ),
                                      Text(
                                        data.name,
                                        style: title1.copyWith(fontSize: 12),
                                        textAlign: TextAlign.center,
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    )
                  ],
                ),
              ),
              //!: Slider Sp đang được giao
              GestureDetector(
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (_) => UsePaypal(
                      sandboxMode: true,
                      clientId:
                          "AQ-z5DPK42W8qrx7VSC2g2aF0PxY_Ko_KUYrNyxi4rlD_q9JY5c1muG1q9fSgRgHyjmc_eqPuGG0wX8S",
                      secretKey:
                          "EKOZxrCebxy9EYW6SzJM6TYBss8rJ1DaaikVSU6F39PKiNxAI9eLdAg0znnm3ku-Swqi3YcUEO8LnyBD",
                      returnURL: "https://samplesite.com/return",
                      cancelURL: "https://samplesite.com/cancel",
                      transactions: const [
                        {
                          "amount": {
                            "total": '0.01',
                            "currency": "USD",
                            "details": {
                              "subtotal": '0.01',
                              "shipping": '0',
                              "shipping_discount": 0
                            }
                          },
                          "description": "The payment transaction description.",
                          // "payment_options": {
                          //   "allowed_payment_method":
                          //       "INSTANT_FUNDING_SOURCE"
                          // },

                          //!:
                          // "item_list": {
                          //   "items": [
                          //     {
                          //       "name": "A demo product",
                          //       "quantity": 1,
                          //       "price": '0.01',
                          //       "currency": "USD"
                          //     }
                          //   ],

                          //   // shipping address is not required though
                          //   // "shipping_address": {
                          //   //   "recipient_name": "Jane Foster",
                          //   //   "line1": "Travis County",
                          //   //   "line2": "",
                          //   //   "city": "Austin",
                          //   //   "country_code": "US",
                          //   //   "postal_code": "73301",
                          //   //   "phone": "+00000000",
                          //   //   "state": "Texas"
                          //   // },
                          // }
                        }
                      ],
                      note: "Contact us for any questions on your order.",
                      onSuccess: (Map params) async {},
                      onError: (error) {},
                      onCancel: (params) {},
                    ),
                  ));
                },
                child: Container(
                  height: 60,
                  width: size.width,
                  color: Colors.blue,
                  child: Row(
                    children: [
                      Expanded(
                        flex: 9,
                        child: Container(),
                      ),
                      const Expanded(
                        flex: 1,
                        child: Icon(Ionicons.chevron_forward_outline),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 16,
              ),
              Expanded(
                  child: ListView.builder(
                      itemCount: lsData.length,
                      itemBuilder: (context, i) {
                        var data = lsData[i];
                        return Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 8, horizontal: 5),
                          child: Container(
                            height: data.status == 1 ? 200 : 170,
                            width: size.width,
                            decoration: BoxDecoration(
                                color: const Color.fromARGB(255, 255, 255, 255),
                                boxShadow: const [
                                  BoxShadow(
                                    color: Color.fromARGB(255, 213, 205, 205),
                                    offset: Offset(5, 9),
                                    blurRadius: 5,
                                  )
                                ],
                                borderRadius: BorderRadius.circular(30)),
                            child: Padding(
                              padding: const EdgeInsets.all(14),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  CusRichText(
                                      selectedAddress: data.name.toString(),
                                      text: 'Tên người nhận : '),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  CusRichText(
                                      selectedAddress: formatCurrency(
                                        amount: data.totalPrice.toString(),
                                      ),
                                      color: Colors.red,
                                      text: 'Giá : '),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  CusRichText(
                                      selectedAddress: data.address.toString(),
                                      text: 'Địa chỉ : '),
                                  data.payment == 1 || data.status == 2
                                      ? Container()
                                      : const Column(
                                          children: [
                                            SizedBox(
                                              height: 10,
                                            ),
                                            CusRichText(
                                              selectedAddress: "Đã thanh toán",
                                              text: 'Đơn hàng : ',
                                              color: Colors.green,
                                            ),
                                          ],
                                        ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  CusRichText(
                                    selectedAddress: data.status == 3
                                        ? "Đang giao, bạn vui lòng chuẩn bị tiền."
                                        : data.status == 4
                                            ? "Giao thành công"
                                            : data.status == 2
                                                ? "Đơn hàng đã hủy, hoặc giao không thành công"
                                                : "Đang đóng gói",
                                    text: 'Trạng thái : ',
                                    color: Colors.blue,
                                  ),
                                  const Spacer(),
                                  data.status == 1
                                      ? SizedBox(
                                          width: size.width,
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Container(),
                                              InkWell(
                                                onTap: () {
                                                  showDialog(
                                                    context: context,
                                                    builder: (context) =>
                                                        AlertDialog(
                                                      title: const Text(
                                                          'Thông báo'),
                                                      content: const Text(
                                                          'Bạn có chắc muốn hủy đơn hàng này ?'),
                                                      actions: <Widget>[
                                                        TextButton(
                                                          onPressed: () =>
                                                              Navigator.of(
                                                                      context)
                                                                  .pop(false),
                                                          child: const Text(
                                                              'Không'),
                                                        ),
                                                        TextButton(
                                                          onPressed: () async {
                                                            await APIOrder.huy(
                                                                id: '${data.id}');
                                                            if (data.payment !=
                                                                1) {
                                                              await APIAuth
                                                                  .getUser();
                                                              print(
                                                                  'score user ${UserPrefer.getScore()}');
                                                            }
                                                            loadData();

                                                            Navigator.of(
                                                                    context)
                                                                .pop(true);
                                                          },
                                                          child:
                                                              const Text('Có'),
                                                        ),
                                                      ],
                                                    ),
                                                  );
                                                },
                                                child: Container(
                                                  height: 30,
                                                  width: 100,
                                                  decoration: BoxDecoration(
                                                    color: const Color.fromARGB(
                                                        255, 195, 183, 183),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            30),
                                                  ),
                                                  child: const Center(
                                                    child: Text('Hủy'),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        )
                                      : Container()
                                ],
                              ),
                            ),
                          ),
                        );
                      }))
            ],
          ),
        ),
      ),
    );
  }
}

class UserProfile extends StatelessWidget {
  const UserProfile({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        //!: Image
        SizedBox(
            height: 80,
            width: 80,
            child: UserPrefer.getImageUser() == 'null' ||
                    UserPrefer.getImageUser() == null
                ? Container()
                : CachedNetworkImage(
                    imageBuilder: (context, imageProvider) => CircleAvatar(
                        backgroundImage: NetworkImage(
                            '${ConnectDb.url}${UserPrefer.getImageUser()}')),
                    fit: BoxFit.cover,
                    placeholder: (context, url) =>
                        const Center(child: CircularProgressIndicator()),
                    errorWidget: (context, url, error) =>
                        const Icon(Icons.error),
                    imageUrl: '${ConnectDb.url}${UserPrefer.getImageUser()}',
                  )),
        const SizedBox(
          width: 8,
        ),
        //!: Name
        Text(
          UserPrefer.getsetUserName() ?? "GUES",
          style: title2.copyWith(
            color: Colors.black,
          ),
        ),
      ],
    );
  }
}

class MyOrder {
  String image;
  String name;
  String? bage;
  int id;
  MyOrder(
      {required this.image, required this.name, this.bage, required this.id});
  static List<MyOrder> lsMyOrder = [
    MyOrder(
        image: 'assets/icons/cart/wallet.png',
        name: 'Hủy, đổi trả',
        bage: '',
        id: 2),
    MyOrder(
        image: 'assets/icons/cart/parcel.png',
        name: 'Chờ vận chuyển',
        bage: '',
        id: 1),
    MyOrder(
        image: 'assets/icons/cart/transportation-truck.png',
        name: 'Chờ giao hàng',
        bage: '',
        id: 3),
    MyOrder(
        image: 'assets/icons/cart/chat.png',
        name: 'Đã hoàn thành',
        bage: '',
        id: 4),
    // MyOrder(
    //     image: 'assets/icons/cart/briefcase.png',
    //     name: 'Đổi trả',
    //     bage: '',
    //     id: 2),
  ];
}
