// ignore_for_file: library_private_types_in_public_api, library_prefixes, file_names, unused_field, use_build_context_synchronously, non_constant_identifier_names, must_be_immutable, equal_keys_in_map
import 'dart:convert';
import 'package:app/components/button/mybutton.dart';
import 'package:app/components/style/text_style.dart';
import 'package:app/api/payment/api_payment.dart';
import 'package:app/preferences/user/user_preferences.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import '../../models/shipcode_model.dart';
import '../../api/address/api_address.dart';
import '../../api/address/model.dart' as Address;
import '../../api/cart/api_cart.dart';
import '../../api/order/api_order.dart';
import '../../api/payment/payment_model.dart' as payment;
import '../../network/connect.dart';
import '../../components/CusRichText/CusRichText.dart';
import '../../components/convert/format_money.dart';
import '../../components/message/message.dart';
import '../../components/districts/addressList.dart';
import 'package:http/http.dart' as http;

import '../../components/districts/address_select.dart';

class AddressDisplayScreen extends StatefulWidget {
  final Address.Data? selectedAddress;
  final List<Map<String, dynamic>> json;
  final bool isBuy;
  const AddressDisplayScreen(
      {super.key,
      this.selectedAddress,
      required this.json,
      required this.isBuy});

  @override
  _AddressDisplayScreenState createState() => _AddressDisplayScreenState();
}

class _AddressDisplayScreenState extends State<AddressDisplayScreen> {
  Address.Data? _selectedAddress;
  int lastTotal = 0;

  Map<String, dynamic>? paymentIntern;
  String returnJson() {
    final json = {
      'name': _selectedAddress!.name,
      'address':
          '${_selectedAddress!.address}, ${_selectedAddress!.ward}, ${_selectedAddress!.district}, ${_selectedAddress!.province}',
      'idProvince': _selectedAddress!.idProvince,
      'idDistrict': _selectedAddress!.idDistrict,
      'idWard': _selectedAddress!.idWard,
      'date_order': DateTime.now().toIso8601String(),
      'delivery_date':
          DateTime.now().add(const Duration(days: 3)).toIso8601String(),
      'phone': _selectedAddress!.phoneNumber,
      'sale': _discountCode,
      'note': _note,
      'paymentId': _selectPayment!.id,
      'ship': _ship!.price,
      'order_details': widget.json,
      'payment': _selectPayment!.id
    };

    // Convert the JSON object to a string
    final jsonString = jsonEncode(json);

    // Print the JSON string (for testing purposes)
    print('location data ${jsonString}');
    return jsonString;
  }

  displayPaymentSheet() async {
    try {
      String jsonString = returnJson();
      await Stripe.instance.presentPaymentSheet().then(
        (value) async {
          var res = await addOrder(jsonString);
          if (res == 200) {
            if (!widget.isBuy) {
              ApiCart.apiDeleteCarts(cartIds: cartId);
            }
            print('test logs --> ${widget.json}');
            Message.success(
              message: 'Thành Công',
              context: context,
            );
            Navigator.of(context).popUntil((route) => route.isFirst);
          } else {
            Message.error(
              message: 'Thất bại',
              context: context,
            );
          }
        },
      );
      print('done --> ');
    } catch (e) {
      print('abc--> faild $e');
      // throw Exception(e);
    }
  }

  void makePayment() async {
    try {
      paymentIntern = await createPaymentIntern();

      var gpay = const PaymentSheetGooglePay(
        merchantCountryCode: "US",
        currencyCode: "VND",
        testEnv: true,
      );

      await Stripe.instance.initPaymentSheet(
          paymentSheetParameters: SetupPaymentSheetParameters(
        paymentIntentClientSecret: paymentIntern!["client_secret"],
        style: ThemeMode.dark,
        merchantDisplayName: "Sabir",
        googlePay: gpay,
      ));
      displayPaymentSheet();
    } catch (e) {
      throw Exception(e);
    }
  }

  createPaymentIntern() async {
    try {
      Map<String, dynamic> body = {
        "amount": lastTotal.toString(),
        "currency": "VND",
      };

      http.Response response = await http.post(
          Uri.parse("https://api.stripe.com/v1/payment_intents"),
          body: body,
          headers: {
            "Authorization":
                "Bearer sk_test_51NGFj9Kl8H5lkAhSt9tOnFlXKvDnv3Jz2nFviGxq67oY9GeaVoVXiebA76nDAyj2gdKVSaYPyhgNHfHEZGI0SmbK00FBuWKQUf",
            "Content-Type": "application/x-www-form-urlencoded",
          });
      return json.decode(response.body);
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  late List<Address.Data> lsData = [];
  List<int> cartId = [];
  List<payment.Data> lsPayment = [];

  String? _selectedShippingMethod;
  payment.Data? _selectPayment;
  String? _discountCode;
  int total = 0;
  String? _note; // New note field
  ShipCode? _ship;
  Future<int> addOrder(String jsonData) async {
    int res = await APIOrder.addOrder(json: jsonData);
    return res;
  }

  loadData() async {
    _ship = ShipCode.lsShipCode[0];
    await APIPaymentMethod.fetchPayment();
    lsPayment = APIPaymentMethod.lsData;
    _selectPayment = lsPayment[0];
    _selectedAddress = widget.selectedAddress;
    if (widget.isBuy) {
      List<List<dynamic>> convertedList = widget.json.map((item) {
        return [item['total']];
      }).toList();
      total = convertedList[0][0];
      print('location data --> ${total}');
    } else {
      await APIAddress.fetchAddress();
      lsData = APIAddress.lsData;

      List<List<dynamic>> convertedList = widget.json.map((item) {
        return [
          item['product_id'],
          item['quantity'],
          item['price'],
          item['cartId']
        ];
      }).toList();

      convertedList.forEach((e) {
        int a = e[1];
        int b = int.parse(e[2]);
        cartId.add(e[3]);
        total += a * b;
      });
    }
    lastTotal = total + int.parse(_ship!.price);

    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    loadData();
  }

  @override
  void dispose() {
    // TODO: implement dispose

    super.dispose();
  }

  void _openAddressListScreen() async {
    final selectedAddress = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const AddressListScreen()),
    );
    if (APIAddress.lsData.isEmpty) {
      _selectedAddress = null;

      return;
    }
    if (selectedAddress != null) {
      setState(() {
        _selectedAddress = selectedAddress;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: SingleChildScrollView(
        physics: const NeverScrollableScrollPhysics(),
        child: Stack(
          children: [
            Container(
              height: size.height,
              width: size.width,
              decoration: const BoxDecoration(
                image: DecorationImage(
                    image: AssetImage('assets/images/bg_booking.png'),
                    fit: BoxFit.cover),
              ),
            ),
            SizedBox(
              height: size.height,
              width: size.width,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Stack(
                  children: [
                    SizedBox(
                      height: size.height * .9,
                      // color: Colors.red,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const SizedBox(
                            height: 40,
                          ),
                          // Address
                          Container(
                            constraints: const BoxConstraints(
                              minHeight: 80,
                            ),
                            width: size.width,
                            decoration: BoxDecoration(
                              color: const Color.fromARGB(255, 104, 58, 213),
                              borderRadius: BorderRadius.circular(16),
                              // border: Border.all(),
                            ),
                            child: GestureDetector(
                              onTap: _openAddressListScreen,
                              child: Padding(
                                padding: const EdgeInsets.all(16),
                                child: _selectedAddress == null
                                    ? SizedBox(
                                        width: size.width,
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Text(
                                              'Thêm địa chỉ mới',
                                              style: title1.copyWith(
                                                  color: Colors.blue),
                                            ),
                                            const Icon(Icons.add,
                                                color: Colors.blue),
                                          ],
                                        ),
                                      )
                                    : SelectAddress(
                                        selectedAddress: _selectedAddress,
                                        colorText: Colors.white,
                                        titleColor: Colors.white,
                                      ),
                              ),
                            ),
                          ),
                          // List sản phẩm được truyền vào

                          // Payment
                          Container(
                            width: size.width,
                            padding: const EdgeInsets.symmetric(vertical: 16),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  'Phương thức thanh toán',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16),
                                ),
                                //!: Payment
                                DropdownButtonFormField<payment.Data>(
                                  value: _selectPayment,
                                  onChanged: (value) {
                                    setState(() {
                                      _selectPayment = value;
                                      print('abc->> ${_selectPayment!.name!}');
                                    });
                                  },
                                  decoration: const InputDecoration(
                                    border: OutlineInputBorder(),
                                  ),
                                  items: List.generate(
                                    lsPayment.length,
                                    (index) => DropdownMenuItem(
                                      value: lsPayment[index],
                                      child: SizedBox(
                                        height: 90,
                                        width: 260,
                                        child: Row(
                                          children: [
                                            CachedNetworkImage(
                                              imageUrl:
                                                  '${ConnectDb.url}${lsPayment[index].image}',
                                              height: 45,
                                              placeholder: (context, url) =>
                                                  const CircularProgressIndicator(),
                                              errorWidget:
                                                  (context, url, error) =>
                                                      const Icon(Icons.error),
                                            ),
                                            const SizedBox(
                                              width: 20,
                                            ),
                                            Text(lsPayment[index].name!),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 8),
                              ],
                            ),
                          ),
                          // Ô nhập mã giảm giá
                          Container(
                            width: size.width,
                            padding: const EdgeInsets.symmetric(vertical: 16),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  'Mã giảm giá',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16),
                                ),
                                const SizedBox(height: 8),
                                TextField(
                                  onChanged: (value) {
                                    setState(() {
                                      _discountCode = value;
                                    });
                                  },
                                  decoration: const InputDecoration(
                                    hintText: 'Nhập mã giảm giá',
                                    border: OutlineInputBorder(),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          // Note
                          Container(
                            width: size.width,
                            padding: const EdgeInsets.symmetric(vertical: 16),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  'Ghi chú',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                  ),
                                ),
                                const SizedBox(height: 8),
                                TextField(
                                  onChanged: (value) {
                                    setState(() {
                                      _note = value;
                                    });
                                  },
                                  decoration: const InputDecoration(
                                    hintText: 'Nhập ghi chú',
                                    border: OutlineInputBorder(),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          // Phí ship
                          Container(
                            width: size.width,
                            padding: const EdgeInsets.symmetric(vertical: 16),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  'Hình thức vận chuyển',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16),
                                ),
                                const SizedBox(height: 8),
                                DropdownButtonFormField<ShipCode>(
                                  onChanged: (value) {
                                    setState(() {
                                      _ship = value;
                                      lastTotal =
                                          total + int.parse(_ship!.price);
                                    });
                                  },
                                  value: _ship,
                                  items: List.generate(
                                      ShipCode.lsShipCode.length,
                                      (index) => DropdownMenuItem(
                                            value: ShipCode.lsShipCode[index],
                                            child: Container(
                                              child: Text(
                                                '${ShipCode.lsShipCode[index].name} - ${formatCurrency(amount: ' ${ShipCode.lsShipCode[index].price}')}',
                                              ),
                                            ),
                                          )),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    Positioned(
                      bottom: 0,
                      child: SizedBox(
                        height: size.height * .1,
                        width: size.width,
                        // color: Colors.green,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            CusRichText(
                              text: 'Tổng tiền : ',
                              selectedAddress:
                                  formatCurrency(amount: '$lastTotal'),
                            ),
                            MyButton(
                              width: 130,
                              backgroundColor: Colors.red,
                              onPressed: () async {
                                if (_selectedAddress != null) {
                                  String jsonString = returnJson();
                                  print('data test $jsonString');
                                  if (widget.isBuy) {
                                    if (_selectPayment!.name != null &&
                                        _selectPayment!.id == 2) {
                                      makePayment();
                                    } else {
                                      if (_selectPayment!.id! == 3 &&
                                          lastTotal >
                                              int.parse(
                                                  UserPrefer.getScore())) {
                                        Message.error(
                                            message:
                                                'Bạn không đủ tiền trong ví của mình',
                                            context: context);
                                        // return;
                                      } else {
                                        var res = await addOrder(jsonString);
                                        if (res == 200) {
                                          Message.success(
                                            message: 'Thành Công',
                                            context: context,
                                          );

                                          Navigator.of(context).popUntil(
                                              (route) => route.isFirst);
                                        } else {
                                          Message.error(
                                            message: 'Thất bại',
                                            context: context,
                                          );
                                        }
                                      }
                                    }
                                  } else {
                                    if (_selectPayment!.name != null &&
                                        _selectPayment!.id == 2) {
                                      makePayment();
                                    } else {
                                      var res = await addOrder(jsonString);
                                      if (res == 200) {
                                        ApiCart.apiDeleteCarts(cartIds: cartId);

                                        Message.success(
                                          message: 'Thành Công',
                                          context: context,
                                        );
                                        Navigator.of(context)
                                            .popUntil((route) => route.isFirst);
                                      } else {
                                        Message.error(
                                          message: 'Thất bại $res',
                                          context: context,
                                        );
                                      }
                                    }
                                  }
                                } else {
                                  Message.warning(
                                      message: 'Thiếu thông tin gì đó.',
                                      context: context);
                                }
                                // Perform further actions with the JSON string (e.g., send it to an API)
                              },
                              child: const Text(
                                'Thanh toán',
                                style: title1,
                              ),
                            )
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// class ProductOTP {
//   String? productId;
//   int? quantity;
//   int? price;
//   int? cartId;
//   ProductOTP({this.productId, this.quantity, this.price, this.cartId});
//   factory ProductOTP.fromJson(Map<String, dynamic> json) {
//     return ProductOTP(
//       productId: json['product_id'],
//       quantity: json['quantity'],
//       price: json['price'],
//       cartId: json['cartId'],
//     );
//   }
// }
