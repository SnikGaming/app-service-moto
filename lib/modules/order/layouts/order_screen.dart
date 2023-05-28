// ignore_for_file: use_build_context_synchronously

import 'dart:convert';
import 'package:app/components/convert/format_money.dart';
import 'package:app/components/districts/location.dart';
import 'package:app/components/message/message.dart';
import 'package:app/components/slider/payment.dart';
import 'package:app/functions/hideExcessCharacters.dart';
import 'package:app/modules/home/api/address/model.dart' as address;
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:app/modules/home/api/address/api_address.dart';
import 'package:app/modules/home/api/cart/api_cart.dart' as cart;
import 'package:app/modules/home/api/order/api_order.dart' as order;

class OrderScreen extends StatefulWidget {
  final List<Map<String, dynamic>> json;

  const OrderScreen({Key? key, required this.json}) : super(key: key);

  @override
  _OrderScreenState createState() => _OrderScreenState();
}

class _OrderScreenState extends State<OrderScreen> {
  late List<address.Data> lsData = [];
  String _address = '';
  String _phone = '';
  String _note = '';
  List<int> cartId = [];
  String selectedAddress = '';
  String selectedPaymentMethod = '';
  double shippingFee = 20000;
  String discountCode = '';
  double totalPrice = 500000;
  int selectedAddressIndex = -1;
  int total = 0;
  bool showScrollMessage = true;

  @override
  void initState() {
    super.initState();
    loadData();
  }

  Future<int> addOrder(String jsonData) async {
    int res = await order.APIOrder.addOrder(json: jsonData);
    return res;
  }

  String createJson({
    required String name,
    required String address,
    required String phone,
    required int idAddress,
  }) {
    Map<String, dynamic> jsonData = {
      "name": name,
      "address": address,
      'idAddress': idAddress,
      "ship": shippingFee,
      "date_order": DateFormat('yyyy-MM-dd HH:mm:ss').format(DateTime.now()),
      "delivery_date": DateFormat('yyyy-MM-dd HH:mm:ss')
          .format(DateTime.now().add(const Duration(days: 3))),
      "phone": phone,
      "sale": "",
      "order_details": widget.json,
    };

    String json = jsonEncode(jsonData);
    return json;
  }

  Future<void> loadData() async {
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

    selectedAddressIndex = lsData.isEmpty ? -1 : 0;
    setState(() {});
  }

  void handleLocationSelected(
      String name, String address, String phone, String note) async {
    setState(() {
      selectedAddress = '$address, $phone,$note';
      _address = address;
      _phone = phone;
      _note = note;
    });
    await addData(name, address, phone);
    await loadData();
  }

  Future<void> addData(String name, String address, String phone) async {
    await APIAddress.addAddress({
      "name": name,
      "address": address,
      "phone_number": phone,
    });
  }

  Future<void> deleteData(int id) async {
    await APIAddress.deleteAddress(id);
    await loadData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Thanh toán'),
        actions: [
          IconButton(
            onPressed: () {
              showModalBottomSheet(
                context: context,
                builder: (BuildContext context) => LocationSelectionScreen(
                  onLocationSelected: handleLocationSelected,
                ),
              );
            },
            icon: const Icon(Icons.add),
          ),
        ],
      ),
      body: Container(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          physics: const NeverScrollableScrollPhysics(),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(
                height: 290,
                child: NotificationListener<ScrollEndNotification>(
                  onNotification: (notification) {
                    if (notification.metrics.atEdge &&
                        notification.metrics.pixels != 0) {
                      setState(() {
                        showScrollMessage = false;
                      });
                    } else {
                      setState(() {
                        showScrollMessage = true;
                      });
                    }
                    return true;
                  },
                  child: ListView.separated(
                    itemCount: lsData.length,
                    separatorBuilder: (context, index) => const Divider(),
                    itemBuilder: (context, index) => ListTile(
                      leading: Radio(
                        value: index,
                        groupValue: selectedAddressIndex,
                        onChanged: (value) {
                          setState(() {
                            selectedAddressIndex = value as int;
                          });
                        },
                      ),
                      title: Text('Số điện thoại ${lsData[index].phoneNumber}'),
                      subtitle: Text(
                        hideExcessCharacters(lsData[index].address!),
                      ),
                      trailing: IconButton(
                        onPressed: () async {
                          await deleteData(lsData[index].id!);
                        },
                        icon: const Icon(Icons.delete),
                      ),
                    ),
                  ),
                ),
              ),
              if (lsData.length > 3 && showScrollMessage)
                const SizedBox(
                  height: 18,
                  child: Text(
                    'Cuộn xuống dưới để xem thêm địa chỉ',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                )
              else
                Container(height: 18),
              SizedBox(
                height: 200,
                child: ListView.builder(
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  itemCount: 5,
                  itemBuilder: (context, index) => const Payment(),
                ),
              ),
              ListTile(
                title: const Text('Phí ship'),
                trailing: Text('$shippingFee đ'),
              ),
              TextFormField(
                onChanged: (value) {
                  setState(() {
                    discountCode = value;
                  });
                },
                decoration: const InputDecoration(
                  labelText: 'Nhập mã giảm giá (nếu có)',
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(vertical: 16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(
                      'Tổng cộng: ${formatCurrency(amount: '$total')}',
                      style: const TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 16.0),
                    ElevatedButton(
                      onPressed: () async {
                        if (selectedAddressIndex == -1) {
                          Message.error(message: '-1', context: context);
                        } else {
                          String jsonData = createJson(
                            name: lsData[selectedAddressIndex].name!,
                            address: lsData[selectedAddressIndex].address!,
                            phone: lsData[selectedAddressIndex].phoneNumber!,
                            idAddress: lsData[selectedAddressIndex].id!,
                          );

                          print('data test $jsonData');
                          var res = await addOrder(jsonData);
                          if (res == 200) {
                            cart.ApiCart.apiDeleteCarts(cartIds: cartId);
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
                      },
                      child: const Text('Thanh toán'),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
