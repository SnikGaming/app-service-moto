// ignore_for_file: must_be_immutable, use_build_context_synchronously, library_private_types_in_public_api

import 'package:app/components/message/message.dart';
import 'package:app/constants/style.dart';
import 'package:app/modules/home/api/address/model.dart' as address;
import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import '../../../components/districts/AddressDisplayScreen .dart';
import '../../../components/value_app.dart';
import '../../home/api/address/api_address.dart';
import '../../home/api/products/models/products.dart' as products;

import '../../../components/button/mybutton.dart';
import '../../../components/convert/format_money.dart';
import '../../../components/style/text_style.dart';
import '../../../preferences/user/user_preferences.dart';
import '../../home/api/cart/api_cart.dart';

class Cart extends StatefulWidget {
  const Cart({
    Key? key,
    required this.data,
    required this.size,
  }) : super(key: key);

  final products.Data? data;
  final Size size;

  @override
  _CartState createState() => _CartState();
}

class _CartState extends State<Cart> {
  address.Data? _address;
  loadData() async {
    await APIAddress.fetchAddress();
    if (mounted) {
      setState(() {
        _number.text = enteredValue.toString();
        if (APIAddress.lsData.isNotEmpty) {
          _address = APIAddress.lsData[0];
        } else {
          _address = null;
        }
      });
    }
  }

  final _number = TextEditingController();
  int enteredValue = 1;

  List<Map<String, dynamic>> createOrder() {
    List<Map<String, dynamic>> orderDetails = [];
    Map<String, dynamic> order = {
      "product_id": widget.data!.id,
      "quantity": _number.text,
      "price": widget.data!.price,
      'total': int.parse('${_number.text}') * widget.data!.price!,
    };
    orderDetails.add(order);
    return orderDetails;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loadData();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _number.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: () {
        showModalBottomSheet(
          context: context,
          isScrollControlled: true,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
            ),
          ),
          builder: (BuildContext context) => StatefulBuilder(
            builder: (BuildContext context, setState) {
              return GestureDetector(
                onTap: () => FocusScope.of(context).unfocus(),
                child: ClipRRect(
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20),
                  ),
                  child: SizedBox(
                    height: 200 + MediaQuery.of(context).viewInsets.bottom,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 16),
                      child: Column(
                        children: [
                          const SizedBox(height: 20),
                          Row(
                            children: [
                              IconButton(
                                // onPressed: quantity > 1
                                //     ? () => setState(() => quantity--)
                                //     : null,
                                onPressed: () {
                                  setState(() {
                                    int temp = int.parse(_number.text);
                                    if (temp > 1) {
                                      temp--;
                                    }
                                    _number.text = temp.toString();
                                  });
                                },
                                icon: const Icon(Icons.remove),
                              ),
                              // Container(
                              //   width: 120,
                              //   child: TextFormField(
                              //     controller: _number,
                              //     onSaved: (String? value) {
                              //       debugPrint(
                              //           'Value for field  saved as "$value"');
                              //     },
                              //   ),
                              // ),
                              const SizedBox(width: 16),
                              SizedBox(
                                height: 45,
                                width: 100,
                                child: TextFormField(
                                  keyboardType: TextInputType.number,
                                  textAlign: TextAlign.center,
                                  controller: _number,
                                  decoration: const InputDecoration(
                                    border: OutlineInputBorder(),
                                  ),
                                  onChanged: (value) {
                                    try {
                                      final parsedValue = int.tryParse(value);
                                      final maxSize =
                                          int.parse('${widget.data!.number!}');

                                      if (parsedValue != null) {
                                        if (parsedValue < 1) {
                                          enteredValue = 1;
                                        } else if (parsedValue > maxSize) {
                                          enteredValue = maxSize;
                                        } else {
                                          enteredValue = parsedValue;
                                        }
                                      } else {
                                        enteredValue = 1;
                                      }
                                    } catch (e) {
                                      enteredValue = 1;
                                    }
                                    _number.text = enteredValue.toString();
                                    setState(() {});
                                  },
                                ),
                              ),
                              const SizedBox(width: 16),
                              IconButton(
                                // onPressed: () => setState(() {
                                //   if (quantity < 99) {
                                //     quantity++;
                                //   }
                                // }),
                                onPressed: () {
                                  setState(() {
                                    int temp = int.parse(_number.text);
                                    final maxSize =
                                        int.parse('${widget.data!.number!}');
                                    if (temp < maxSize) {
                                      temp++;
                                    }
                                    _number.text = temp.toString();
                                  });
                                },
                                icon: const Icon(Icons.add),
                              ),
                            ],
                          ),
                          const SizedBox(height: 10),
                          SizedBox(
                            height: 20,
                            width: widget.size.width,
                            child: Text(
                              'Tổng tiền : ${formatCurrency(amount: '${widget.data!.price! * int.parse(_number.text)}')}',
                              style: styleH3,
                            ),
                          ),
                          const Spacer(),
                          // const SizedBox(height: 40),
                          SizedBox(
                            width: widget.size.width,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                MyButton(
                                  backgroundColor: Colors.white,
                                  borderColor: Colors.blue,
                                  icons: const Icon(Ionicons.cart),
                                  width: widget.size.width * .55,
                                  onPressed: () {
                                    check(false);
                                  },
                                  child: Text(
                                    txtAddCart,
                                    style: title1.copyWith(color: Colors.blue),
                                  ),
                                ),
                                const SizedBox(
                                  width: 8,
                                ),
                                MyButton(
                                  backgroundColor: Colors.red,
                                  width: widget.size.width * .3,
                                  onPressed: () async {
                                    List<Map<String, dynamic>> json =
                                        createOrder();
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (_) => AddressDisplayScreen(
                                            selectedAddress: _address,
                                            isBuy: true,
                                            json: json,
                                          ),
                                        )).then((value) {
                                      loadData();
                                    });
                                  },
                                  child: const Text(
                                    'Mua',
                                    style: title1,
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(
                                    bottom: MediaQuery.of(context)
                                            .viewInsets
                                            .bottom *
                                        .5,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        );
      },
      child: const Icon(Icons.shopping_bag),
    );
  }

  void _showProductDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Thông tin sản phẩm'),
          content: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Tên sản phẩm: ${widget.data!.name}'),
              Text('Giá: ${formatCurrency(amount: '${widget.data!.price}')}'),
              Text('Số lượng: ${widget.data!.number}'),
              // Add other product information here
            ],
          ),
          actions: [
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).popUntil((route) => route.isFirst);
              },
              child: const Text('Đóng'),
            ),
          ],
        );
      },
    );
  }

  void check(bool isBuy) async {
    if (UserPrefer.getToken() == null || UserPrefer.getToken() == 'null') {
      Message.error(
          message: 'Vui lòng đăng nhập vào hệ thống.', context: context);
    } else {
      if (int.parse('${_number.text}') <= widget.data!.number!) {
        if (isBuy) {
          Message.success(message: 'Mua thành công.', context: context);
          Navigator.pop(context);
          _showProductDialog(context); // Show product information dialog
        } else {
          var value = await ApiCart.apiCart(
            id: widget.data!.id!,
            quantity: int.parse('${_number.text}'),
          );
          if (value == 200) {
            Message.success(
                message: 'Thêm giỏ hàng thành công.', context: context);
          } else {
            Message.error(message: 'Thêm giỏ hàng thất bại.', context: context);
          }
          Navigator.pop(context);
        }
      } else {
        Message.error(
            message: 'Vui lòng kiểm tra lại số lượng', context: context);
      }
    }
  }
}
