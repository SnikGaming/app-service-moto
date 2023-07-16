// ignore_for_file: must_be_immutable, use_build_context_synchronously, library_private_types_in_public_api

import 'package:app/components/message/message.dart';
import 'package:app/constants/style.dart';
import 'package:app/api/address/model.dart' as address;
import 'package:flutter/material.dart';
import 'package:input_quantity/input_quantity.dart';
import 'package:ionicons/ionicons.dart';
import '../../order/order_screen.dart';
import '../../../components/value_app.dart';
import '../../../api/address/api_address.dart';
import '../../../api/products/models/products.dart' as products;

import '../../../components/button/mybutton.dart';
import '../../../components/convert/format_money.dart';
import '../../../components/style/text_style.dart';
import '../../../preferences/user/user_preferences.dart';
import '../../../api/cart/api_cart.dart';

class Cart extends StatefulWidget {
  final VoidCallback updateCartData;
  const Cart({
    Key? key,
    required this.data,
    required this.size,
    required this.updateCartData,
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
        enteredValue = 1;
        if (APIAddress.lsData.isNotEmpty) {
          _address = APIAddress.lsData[0];
        } else {
          _address = null;
        }
      });
    }
  }

  int enteredValue = 1;

  List<Map<String, dynamic>> createOrder() {
    List<Map<String, dynamic>> orderDetails = [];
    Map<String, dynamic> order = {
      "product_id": widget.data!.id,
      "quantity": enteredValue,
      "price": widget.data!.price,
      'total': enteredValue * widget.data!.price!,
      'name': widget.data!.name,
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
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: 20),
                          InputQty(
                              maxVal: widget.data!.number!,
                              initVal: 1,
                              minVal: 1,
                              steps: 1,
                              showMessageLimit: false,
                              borderShape: BorderShapeBtn.none,
                              plusBtn: const Icon(Icons.add_box),
                              minusBtn:
                                  const Icon(Icons.indeterminate_check_box),
                              btnColor1: Colors.teal,
                              btnColor2: Colors.red,
                              onQtyChanged: (val) {
                                try {
                                  int value = int.parse(val.toString());
                                  if (value != enteredValue) {
                                    setState(() {
                                      enteredValue = value;
                                    });
                                  }
                                } catch (error) {
                                  setState(() {
                                    enteredValue = 1;
                                    val = 1;
                                  });
                                }
                              }),
                          const SizedBox(height: 10),
                          SizedBox(
                            height: 20,
                            width: widget.size.width,
                            child: Text(
                              'Tổng tiền : ${formatCurrency(amount: '${widget.data!.price! * enteredValue}')}',
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
    if (enteredValue <= widget.data!.number!) {
      if (isBuy) {
        Message.success(message: 'Mua thành công.', context: context);
        Navigator.pop(context);
        _showProductDialog(context); // Show product information dialog
      } else {
        print('ABC-------------------------->${widget.data!.id!}');
        print('ABC-------------------------->${enteredValue}');

        var value = await ApiCart.apiCart(
          id: widget.data!.id!,
          quantity: enteredValue,
        );
        if (value == 200) {
          Message.success(
              message: 'Thêm giỏ hàng thành công.', context: context);
          enteredValue = 1;

          widget.updateCartData();
          setState(() {});
        } else {
          Message.error(message: 'Thêm giỏ hàng thất bại.', context: context);
          enteredValue = 1;
        }
        Navigator.pop(context);
      }
    } else {
      Message.error(
          message: 'Vui lòng kiểm tra lại số lượng', context: context);
      enteredValue = 1;
    }
  }
}
