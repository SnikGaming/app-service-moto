// ignore_for_file: library_private_types_in_public_api, library_prefixes, file_names, unused_field
import 'dart:convert';

import 'package:app/components/button/mybutton.dart';
import 'package:app/components/style/text_style.dart';
import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import '../../modules/home/api/address/api_address.dart';
import '../../modules/home/api/address/model.dart' as Address;
import '../CusRichText/CusRichText.dart';
import 'AddressListScreen .dart';

class AddressDisplayScreen extends StatefulWidget {
  final Address.Data? selectedAddress;

  const AddressDisplayScreen({super.key, this.selectedAddress});

  @override
  _AddressDisplayScreenState createState() => _AddressDisplayScreenState();
}

enum PaymentMethod {
  cashOnDelivery,
  paypal,
}

class _AddressDisplayScreenState extends State<AddressDisplayScreen> {
  Address.Data? _selectedAddress;
  String? _selectedShippingMethod;
  String? _discountCode;
  String? _note; // New note field
  PaymentMethod _selectedPaymentMethod =
      PaymentMethod.cashOnDelivery; // Giá trị mặc định
  _selectPaymentMethod(PaymentMethod? paymentMethod) {
    setState(() {
      _selectedPaymentMethod = paymentMethod!;
    });
  }

  @override
  void initState() {
    super.initState();
    _selectedAddress = widget.selectedAddress;
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
                            const SizedBox(height: 8),
                            ListTile(
                              title: const Text('Thanh toán khi nhận hàng'),
                              leading: Radio<PaymentMethod>(
                                value: PaymentMethod.cashOnDelivery,
                                groupValue: _selectedPaymentMethod,
                                onChanged: _selectPaymentMethod,
                              ),
                            ),
                            ListTile(
                              title: const Text('Paypal'),
                              leading: Radio<PaymentMethod>(
                                value: PaymentMethod.paypal,
                                groupValue: _selectedPaymentMethod,
                                onChanged: _selectPaymentMethod,
                              ),
                            ),
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
                        const CusRichText(
                          text: 'Tổng tiền : ',
                          selectedAddress: '120000000',
                        ),
                        MyButton(
                          width: 130,
                          backgroundColor: Colors.red,
                          onPressed: () {
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
                              'paymentId': _selectedPaymentMethod.index,
                              'sshipping': 0,
                              'order_details': [
                                {
                                  'product_id':
                                      1, // Replace with the actual product ID
                                  'quantity':
                                      5, // Replace with the actual quantity
                                  'price':
                                      '350000', // Replace with the actual price
                                },
                              ],
                            };

                            // Convert the JSON object to a string
                            final jsonString = jsonEncode(json);

                            // Print the JSON string (for testing purposes)
                            print('location data ${jsonString}');

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
