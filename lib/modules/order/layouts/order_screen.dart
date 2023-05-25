// ignore_for_file: public_member_api_docs, sort_constructors_first, must_be_immutable
import 'package:app/components/message/message.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:intl/intl.dart';
import 'package:app/functions/random_color.dart';
import 'package:app/modules/home/api/address/model.dart' as address;

import '../../../components/districts/location.dart';
import '../../../components/slider/payment.dart';
import '../../../functions/hideExcessCharacters.dart';
import '../../home/api/address/api_address.dart';
import '../../home/api/order/api_order.dart';

class OrderScreen extends StatefulWidget {
  final List<Map<String, dynamic>> json;

  const OrderScreen({Key? key, required this.json}) : super(key: key);

  @override
  _OrderScreenState createState() => _OrderScreenState();
}

class _OrderScreenState extends State<OrderScreen> {
  List<address.Data> lsData = [];
  String _address = '';
  String _phone = '';
  String _note = '';

  String selectedAddress = '';
  String selectedPaymentMethod = '';
  double shippingFee = 20000;
  String discountCode = '';
  double totalPrice = 500000;
  int selectedAddressIndex = -1;

  @override
  void initState() {
    super.initState();
    loadData();
  }

  Future<int> addOrder(String jsonData) async {
    int res = await APIOrder.addOrder(json: jsonData);
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
      "Ship": "20000",
      "date_order": DateFormat('yyyy-MM-dd HH:mm:ss').format(DateTime.now()),
      "phone": phone,
      "sale": "",
      "order_details": widget.json,
    };

    String json = jsonEncode(jsonData);
    return json;
  }

  Future<void> loadData() async {
    await APIAddress.fetchBookings();
    lsData = APIAddress.lsData;
    if (lsData.isEmpty) {
      selectedAddressIndex = -1;
    } else {
      selectedAddressIndex = 0;
    }
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
    await APIAddress.addAddress(
        {"name": name, "address": address, "phone_number": phone});
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
        child: Column(
          children: [
            Expanded(
              child: lsData.isEmpty
                  ? Container(color: randomColor())
                  : ListView.builder(
                      itemCount: lsData.length,
                      itemBuilder: (context, index) => Column(
                        children: [
                          ListTile(
                            leading: Radio(
                              value: index,
                              groupValue: selectedAddressIndex,
                              onChanged: (value) {
                                setState(() {
                                  selectedAddressIndex = value as int;
                                });
                              },
                            ),
                            title: Text(
                              'Số điện thoại ${lsData[index].phoneNumber}',
                            ),
                            subtitle: Text(
                              hideExcessCharacters(lsData[index].address!),
                            ),
                            trailing: IconButton(
                              onPressed: () async {
                                await deleteData(lsData[index].id!);
                              },
                              icon: Icon(Icons.delete),
                            ),
                          ),
                          Divider(),
                        ],
                      ),
                    ),
            ),
            Expanded(
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: 5,
                itemBuilder: (context, index) => Payment(),
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
                  // TODO: Áp dụng mã giảm giá và cập nhật totalPrice
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
                    'Tổng cộng: ${totalPrice - shippingFee} đ',
                    style: const TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 16.0),
                  ElevatedButton(
                    onPressed: () async {
                      // Xử lý sự kiện khi người dùng bấm nút thanh toán
                      if (selectedAddressIndex == -1) {
                        Message.error(message: '-1', context: context);
                      } else {
                        String jsonData = createJson(
                          name: lsData[selectedAddressIndex].name!,
                          address: lsData[selectedAddressIndex].address!,
                          phone: lsData[selectedAddressIndex].phoneNumber!,
                          idAddress: lsData[selectedAddressIndex].id!,
                        );

                        print('data test ${jsonData} ');
                        var res = await addOrder(jsonData);
                        if (res == 200) {
                          Message.success(
                              message: 'Thành Công', context: context);
                        } else {
                          Message.error(
                              message: 'Thất bại $res', context: context);
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
    );
  }
}
