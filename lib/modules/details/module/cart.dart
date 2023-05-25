// ignore_for_file: must_be_immutable

import 'package:app/components/message/message.dart';
import 'package:app/constants/style.dart';
import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import '../../home/api/products/models/products.dart' as products;

import '../../../components/button/mybutton.dart';
import '../../../components/convert/format_money.dart';
import '../../../components/style/text_style.dart';
import '../../../preferences/user/user_preferences.dart';
import '../../home/api/cart/api_cart.dart';

class Cart extends StatelessWidget {
  Cart({
    super.key,
    this.data,
    // required this.widget,
    required this.size,
  });
  products.Data? data;
  // final DetailsServiceScreen widget;
  final Size size;

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: () {
        int quantity = 1;
        String note = '';
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
                  child: Container(
                    color: Colors.white,
                    height: 350 + MediaQuery.of(context).viewInsets.bottom,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 16),
                      child: Column(
                        children: [
                          const SizedBox(height: 20),
                          TextFormField(
                            controller: TextEditingController(text: note),
                            maxLines: null,
                            decoration: const InputDecoration(
                              labelText: 'Ghi chú',
                              border: OutlineInputBorder(),
                            ),
                            onChanged: (value) {
                              // Xử lý khi ghi chú thay đổi
                            },
                          ),
                          const SizedBox(height: 20),
                          Row(
                            children: [
                              IconButton(
                                onPressed: quantity > 1
                                    ? () => setState(() => quantity--)
                                    : null,
                                icon: const Icon(Icons.remove),
                              ),
                              const SizedBox(width: 16),
                              SizedBox(
                                height: 45,
                                width: 50,
                                child: TextField(
                                  keyboardType: TextInputType.number,
                                  textAlign: TextAlign.center,
                                  decoration: const InputDecoration(
                                    border: OutlineInputBorder(),
                                  ),
                                  onChanged: (value) {
                                    setState(() {
                                      if (int.tryParse(value)! >
                                              data!.number! ||
                                          value.length < 3) {
                                        quantity = int.tryParse(value) ?? 1;
                                      }
                                    });
                                  },
                                  controller:
                                      TextEditingController(text: '$quantity'),
                                ),
                              ),
                              const SizedBox(width: 16),
                              IconButton(
                                onPressed: () => setState(() {
                                  if (quantity < 99) {
                                    quantity++;
                                  }
                                }),
                                icon: const Icon(Icons.add),
                              ),
                            ],
                          ),
                          // const Spacer(),
                          const SizedBox(
                            height: 10,
                          ),
                          SizedBox(
                            height: 20,
                            width: size.width,
                            // color: Colors.red,
                            child: Text(
                              'Tổng tiền : ${formatCurrency(amount: '${data!.price! * quantity}')}',
                              style: styleH3,
                            ),
                          ),
                          const SizedBox(
                            height: 40,
                          ),
                          SizedBox(
                            width: size.width,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                MyButton(
                                  backgroundColor: Colors.white,
                                  borderColor: Colors.blue,
                                  icons: const Icon(Ionicons.cart),
                                  width: size.width * .6,
                                  onPressed: () {
                                    check(quantity, note, context, false);
                                  },
                                  child: Text(
                                    'Thêm vào giỏ hàng',
                                    style: title1.copyWith(color: Colors.blue),
                                  ),
                                ),
                                MyButton(
                                  backgroundColor: Colors.red,
                                  width: size.width * .3,
                                  onPressed: () {
                                    check(quantity, note, context, true);
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

  check(quantity, note, context, isBuy) async {
    if (UserPrefer.getToken() == null || UserPrefer.getToken() == 'null') {
      Message.error(
          message: 'Vui lòng đăng nhập vào hệ thống.', context: context);
    } else {
      if (quantity < data!.number!) {
        if (isBuy) {
          // Message.success(message: 'Mua thành công.', context: context);
          Navigator.pop(context);
        } else {
          var value = await ApiCart.apiCart(id: data!.id!, quantity: quantity);
          if (value == 200) {
            Message.success(
                message: 'Thêm giỏ hàng thành công.', context: context);
          } else {
            Message.error(message: 'Thêm giỏ hàng thất bại.', context: context);
          }
          Navigator.pop(context);
        }
        //API
      } else {
        Message.error(
            message: 'Vui lòng kiểm tra lại số lượng', context: context);
      }
    }
  }
}
