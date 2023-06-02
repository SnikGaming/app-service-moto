// ignore_for_file: library_private_types_in_public_api, library_prefixes, file_names, unused_field, use_build_context_synchronously
import 'dart:convert';
import 'package:app/components/button/mybutton.dart';
import 'package:app/components/style/text_style.dart';
import 'package:app/modules/home/api/payment/api_payment.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import '../../modules/home/api/address/api_address.dart';
import '../../modules/home/api/address/model.dart' as Address;

import '../../modules/home/api/cart/api_cart.dart';
import '../../modules/home/api/category/api_category.dart';
import '../../modules/home/api/order/api_order.dart';
import '../../modules/home/api/payment/payment_model.dart' as payment;
import '../../network/connect.dart';
import '../CusRichText/CusRichText.dart';
import '../convert/format_money.dart';
import '../message/message.dart';
import 'AddressListScreen .dart';

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
  late List<Address.Data> lsData = [];
  List<int> cartId = [];
  List<payment.Data> lsPayment = [];

  String? _selectedShippingMethod;
  payment.Data? _selectPayment;
  String? _discountCode;
  int total = 0;
  String? _note; // New note field

  Future<int> addOrder(String jsonData) async {
    int res = await APIOrder.addOrder(json: jsonData);
    return res;
  }

  loadData() async {
    await APIPaymentMethod.fetchPayment();
    lsPayment = APIPaymentMethod.lsData;
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
        child: SizedBox(
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
                      // Address
                      Container(
                        constraints: const BoxConstraints(
                          minHeight: 60,
                        ),
                        width: size.width,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(),
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
                                    selectedAddress: _selectedAddress),
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
                                  fontWeight: FontWeight.bold, fontSize: 16),
                            ),
                            //!: Payment
                            DropdownButtonFormField<payment.Data>(
                              value: _selectPayment,
                              onChanged: (value) {
                                setState(() {
                                  _selectPayment = value;
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
                                          errorWidget: (context, url, error) =>
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
                                  fontWeight: FontWeight.bold, fontSize: 16),
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
                                  fontWeight: FontWeight.bold, fontSize: 16),
                            ),
                            const SizedBox(height: 8),
                            DropdownButtonFormField<String>(
                              value: _selectedShippingMethod,
                              onChanged: (value) {
                                setState(() {
                                  _selectedShippingMethod = value;
                                });
                              },
                              decoration: const InputDecoration(
                                border: OutlineInputBorder(),
                              ),
                              items: const [
                                DropdownMenuItem<String>(
                                  value: 'Phương thức 1',
                                  child: Text('Phương thức 1'),
                                ),
                                DropdownMenuItem<String>(
                                  value: 'Phương thức 2',
                                  child: Text('Phương thức 2'),
                                ),
                                // Add more shipping methods as needed
                              ],
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
                          selectedAddress: formatCurrency(amount: '$total'),
                        ),
                        MyButton(
                          width: 130,
                          backgroundColor: Colors.red,
                          onPressed: () async {
                            // Create the JSON object
                            final json = {
                              'name': _selectedAddress!.name,
                              'address':
                                  '${_selectedAddress!.address}, ${_selectedAddress!.ward}, ${_selectedAddress!.district}, ${_selectedAddress!.province}',
                              'idProvince': _selectedAddress!.idProvince,
                              'idDistrict': _selectedAddress!.idDistrict,
                              'idWard': _selectedAddress!.idWard,
                              'ship': 20000.0,
                              'date_order': DateTime.now().toIso8601String(),
                              'delivery_date': DateTime.now()
                                  .add(const Duration(days: 3))
                                  .toIso8601String(),
                              'phone': _selectedAddress!.phoneNumber,
                              'sale': _discountCode,
                              'note': _note,
                              'paymentId': _selectPayment!.name,
                              'shipping': 0,
                              'order_details': widget.json,
                            };

                            // Convert the JSON object to a string
                            final jsonString = jsonEncode(json);

                            // Print the JSON string (for testing purposes)
                            print('location data ${jsonString}');
                            if (widget.isBuy) {
                              var res = await addOrder(jsonString);
                              if (res == 200) {
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
      ),
    );
  }
}

class SelectAddress extends StatelessWidget {
  const SelectAddress({
    super.key,
    required Address.Data? selectedAddress,
  }) : _selectedAddress = selectedAddress;

  final Address.Data? _selectedAddress;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          flex: 9,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CusRichText(
                text: "Người nhận : ",
                selectedAddress: _selectedAddress!.name!,
                color: Colors.blue,
              ),
              const SizedBox(
                height: 8,
              ),
              CusRichText(
                  text: "Số điện thoại : ",
                  selectedAddress: _selectedAddress!.phoneNumber!),
              const SizedBox(
                height: 8,
              ),
              CusRichText(
                  text: "Địa chỉ : ",
                  selectedAddress:
                      '${_selectedAddress!.address!}, ${_selectedAddress!.ward!}, ${_selectedAddress!.district!}, ${_selectedAddress!.province!}.'),
            ],
          ),
        ),
        const Expanded(
          flex: 1,
          child: Icon(Ionicons.chevron_forward_outline),
        ),
      ],
    );
  }
}
