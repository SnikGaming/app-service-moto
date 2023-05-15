import 'package:app/components/message/message.dart';
import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';

import '../../../components/button/mybutton.dart';
import '../../../components/style/text_style.dart';
import '../../../preferences/user/user_preferences.dart';
import '../layouts/detail_service.dart';

class Cart extends StatelessWidget {
  const Cart({
    super.key,
    required this.widget,
    required this.size,
  });

  final DetailsServiceScreen widget;
  final Size size;

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: () {
        int _quantity = 1;

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
                                onPressed: _quantity > 1
                                    ? () => setState(() => _quantity--)
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
                                              widget.data.number! ||
                                          value.length < 3) {
                                        _quantity = int.tryParse(value) ?? 1;
                                      }
                                    });
                                  },
                                  controller:
                                      TextEditingController(text: '$_quantity'),
                                ),
                              ),
                              const SizedBox(width: 16),
                              IconButton(
                                onPressed: () => setState(() {
                                  if (_quantity < 99) {
                                    _quantity++;
                                  }
                                }),
                                icon: const Icon(Icons.add),
                              ),
                            ],
                          ),
                          // const Spacer(),
                          const SizedBox(
                            height: 90,
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
                                    check(_quantity, context, false);
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
                                    check(_quantity, context, true);
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

  check(_quantity, context, isBuy) {
    if (UserPrefer.getToken() == null || UserPrefer.getToken() == 'null') {
      Message.error(
          message: 'Vui lòng đăng nhập vào hệ thống.', context: context);
    } else {
      if (_quantity < widget.data.number!) {
        if (isBuy) {
          Message.success(message: 'Mua thành công.', context: context);
          Navigator.pop(context);
        } else {
          Message.success(
              message: 'Thêm giỏ hàng thành công', context: context);
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
