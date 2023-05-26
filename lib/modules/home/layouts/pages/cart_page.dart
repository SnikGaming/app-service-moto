// ignore_for_file: library_prefixes

import 'package:app/modules/home/layouts/pages/services_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../../../../components/button/mybutton.dart';
import '../../../../components/style/text_style.dart';
import '../../../../components/style/textstyle.dart';
import '../../../../functions/check_true_false_list.dart';
import '../../../../network/connect.dart';
import '../../../app_constants.dart';
import '../../api/cart/api_cart.dart';
import '../../api/cart/model.dart' as CartModel;
import '../../../../components/convert/format_money.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({Key? key}) : super(key: key);

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  List<bool> lsClick = [];
  bool isButton = true;
  bool selectAll = false;
  List<Map<String, dynamic>> createOrder() {
    List<Map<String, dynamic>> orderDetails = [];

    for (int i = 0; i < lsClick.length; i++) {
      if (lsClick[i]) {
        Map<String, dynamic> order = {
          "product_id": data[i].productId,
          "quantity": data[i].quantity,
          "price": data[i].price,
          'cartId': data[i].id
        };
        orderDetails.add(order);
      }
    }

    // String json = jsonEncode(orderDetails);
    // print('test data $json');
    return orderDetails;
  }

  void selectAllItems(bool value) {
    setState(() {
      selectAll = value;
      lsClick = List.generate(data.length, (index) => value);
      isButton = checkList(lsClick);

      // Check if all elements in lsClick are true
      if (lsClick.every((element) => element)) {
        selectAll = true;
      } else {
        selectAll = false;
      }
    });
  }

  int calculateTotalPrice() {
    int totalPrice = 0;
    for (int i = 0; i < lsClick.length; i++) {
      if (lsClick[i]) {
        totalPrice += int.parse(data[i].price!) * data[i].quantity!;
      }
    }
    return totalPrice;
  }

  List<CartModel.Data> data = [];
  loadData() async {
    await ApiCart.getData();
    data = ApiCart.lsCart;
    lsClick = List.generate(data.length, (index) => false);
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    loadData();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    Widget build2(BuildContext context) {
      return FutureBuilder(
        future: Future.delayed(const Duration(seconds: 2)),
        builder: (BuildContext context, AsyncSnapshot<void> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else {
            // Display the Container with the image after 5 seconds
            WidgetsBinding.instance.addPostFrameCallback((_) {
              if (mounted) {
                setState(() {
                  // Set your state here
                });
              }
            });

            return Container(
              height: size.height,
              width: size.width,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/images/notdata.gif'),
                ),
              ),
            );
          }
        },
      );
    }

    Widget slidable(int i, context) {
      return Slidable(
        key: const ValueKey(0),
        endActionPane: ActionPane(
          motion: const ScrollMotion(),
          children: [
            SlidableAction(
              onPressed: (context) {
                ApiCart.apiDeleteCarts(cartIds: [data[i].id!]);
                loadData();
              },
              backgroundColor: Colors.red,
              foregroundColor: Colors.white,
              icon: Icons.delete,
              label: 'delete',
            ),
          ],
        ),
        child: Container(
          constraints: const BoxConstraints(minHeight: 100),
          padding: const EdgeInsets.only(top: 10, right: 10, bottom: 10),
          width: size.width,
          decoration: const BoxDecoration(
            color: Color.fromARGB(255, 231, 226, 226),
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(16),
              bottomLeft: Radius.circular(16),
            ),
          ),
          child: Row(
            children: [
              Checkbox(
                shape: const CircleBorder(),
                value: lsClick[i],
                onChanged: (value) {
                  setState(() {
                    lsClick[i] = value!;
                    isButton = checkList(lsClick);

                    // Check if all values in lsClick are true
                    if (lsClick.every((element) => element)) {
                      selectAll = true;
                    } else {
                      selectAll = false;
                    }
                  });
                },
              ),
              Expanded(
                flex: 1,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    InkWell(
                      onTap: () => Modular.to.pushNamed(Routes.details,
                          arguments: data[i].productId),
                      child: Row(
                        children: [
                          CachedNetworkImage(
                            imageUrl: '${ConnectDb.url}${data[i].image}',
                            height: 80,
                            placeholder: (context, url) => const Center(
                                child: CircularProgressIndicator()),
                            errorWidget: (context, url, error) =>
                                const Icon(Icons.error),
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(data[i].productName!,
                                    style: title1.copyWith(color: Colors.blue)),
                                const SizedBox(
                                  height: 8,
                                ),
                                Text(
                                  'Giá : ${data[i].price.toString()}',
                                  style: title1.copyWith(color: Colors.red),
                                ),
                                const SizedBox(
                                  height: 8,
                                ),
                                Text(
                                  'Tổng tiền: ${formatCurrency(amount: '${int.parse(data[i].price!) * data[i].quantity!}')}',
                                  style: title1.copyWith(color: Colors.black),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    //!: Số lượng
                    SizedBox(
                      // color: Colors.red,
                      width: 90,
                      height: 30,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          //!: Số lượng -
                          GestureDetector(
                            onTap: () {
                              if (data[i].quantity! > 1) {
                                setState(() {
                                  data[i].quantity = data[i].quantity! - 1;
                                });
                              }
                            },
                            child: Container(
                              height: 30,
                              width: 30,
                              decoration: BoxDecoration(
                                border: Border.all(),
                                shape: BoxShape.circle,
                              ),
                              child: const Icon(
                                Icons.remove,
                                size: 10,
                                color: Colors.black,
                              ),
                            ),
                          ),
                          //!: Hiển thị
                          GestureDetector(
                            onTap: () {
                              var quantityController = TextEditingController(
                                text: '${data[i].quantity}',
                              );
                              var focusNode = FocusNode();

                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    title: const Text('Nhập số lượng'),
                                    content: TextField(
                                      controller: quantityController,
                                      keyboardType: TextInputType.number,
                                      focusNode: focusNode,
                                      autofocus: true,
                                      onChanged: (value) {
                                        quantityController.text = value;
                                      },
                                    ),
                                    actions: [
                                      TextButton(
                                        onPressed: () {
                                          Navigator.of(context).pop();
                                        },
                                        child: const Text('Hủy'),
                                      ),
                                      TextButton(
                                        onPressed: () {
                                          if (quantityController
                                              .text.isNotEmpty) {
                                            if (int.parse(
                                                    quantityController.text) >
                                                1) {
                                              data[i].quantity = int.parse(
                                                  quantityController.text);
                                            }
                                          }

                                          setState(() {});
                                          Navigator.of(context).pop();
                                        },
                                        child: const Text('Xác nhận'),
                                      ),
                                    ],
                                  );
                                },
                              );
                              FocusScope.of(context).requestFocus(focusNode);
                            },
                            child: Container(
                              alignment: Alignment.center,
                              height: 30,
                              width: 30,
                              child: Text(
                                '${data[i].quantity}', // Số lượng hiển thị
                                style: const TextStyle(color: Colors.black),
                              ),
                            ),
                          ),
                          //!: Số lượng -
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                data[i].quantity = data[i].quantity! + 1;
                              });
                            },
                            child: Container(
                              height: 30,
                              width: 30,
                              decoration: BoxDecoration(
                                border: Border.all(),
                                shape: BoxShape.circle,
                              ),
                              child: const Icon(
                                Icons.add,
                                size: 10,
                                color: Colors.black,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      );
    }

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            'CART',
            style: MyTextStyle.title,
          ),
          centerTitle: true,
          backgroundColor: Colors.purple,
        ),
        body: SizedBox(
          height: size.height,
          width: size.width,
          child: data.isEmpty
              ? build2(context)
              //!: Hiển thị sản phẩm
              : Stack(
                  children: [
                    SizedBox(
                      height: size.height * 0.68,
                      child: ListView.builder(
                        itemCount: data.length,
                        itemBuilder: (context, i) {
                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: lsClick.isEmpty
                                ? const CircularProgressIndicator()
                                : slidable(i, context),
                          );
                        },
                      ),
                    ),
                    Positioned(
                      bottom: 0,
                      child: SizedBox(
                        // color: Colors.red,
                        width: size.width,
                        height: size.height * 0.12,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  Checkbox(
                                    value: selectAll,
                                    onChanged: (value) {
                                      selectAllItems(value!);
                                    },
                                  ),
                                  const Text('Chọn tất cả'),
                                ],
                              ),
                              Row(
                                children: [
                                  isButton
                                      ? Container()
                                      : Expanded(
                                          flex: 2,
                                          child: Text(
                                            'Tổng: ${formatCurrency(amount: calculateTotalPrice().toString())}',
                                            style: title.copyWith(
                                                color: Colors.black),
                                          ),
                                        ),
                                  const SizedBox(width: 10),
                                  Expanded(
                                    child: MyButton(
                                      disable: isButton,
                                      onPressed: () async {
                                        List<Map<String, dynamic>> json =
                                            createOrder();

                                        // Chuyển danh sách selectedIds qua màn hình Order
                                        print('data test $json');
                                        // await APIOrder.addOrder(json: json);
                                        Modular.to
                                            .pushNamed(Routes.order,
                                                arguments: json)
                                            .then((value) => loadData());
                                      },
                                      child: Text(
                                        'THANH TOÁN',
                                        style: title2.copyWith(
                                            color: Colors.white),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
        ),
      ),
    );
  }
}
