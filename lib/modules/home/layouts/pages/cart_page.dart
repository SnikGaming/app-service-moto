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
    print('data test ${ApiCart.lsCart.length}');
  }

  @override
  void initState() {
    super.initState();
    loadData();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    Widget slidable(int i) {
      return Slidable(
        key: const ValueKey(0),
        endActionPane: const ActionPane(
          motion: ScrollMotion(),
          children: [
            SlidableAction(
              onPressed: doNothing,
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
                    Row(
                      children: [
                        CachedNetworkImage(
                          imageUrl: '${ConnectDb.url}${data[i].image}',
                          height: 80,
                          placeholder: (context, url) =>
                              const CircularProgressIndicator(),
                          errorWidget: (context, url, error) =>
                              const Icon(Icons.error),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(data[i].productName!),
                              Text(data[i].price.toString()),
                              Text(
                                'Tổng tiền: ${formatCurrency(amount: '${int.parse(data[i].price!) * data[i].quantity!}')}',
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    Container(
                      color: Colors.red,
                      width: 70,
                      height: 30,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                data[i].quantity = data[i].quantity! - 1;
                              });
                            },
                            child: const Icon(Icons.remove, size: 10),
                          ),
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
                                            data[i].quantity = int.parse(
                                                quantityController.text);
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
                            child: Text(
                              '${data[i].quantity}', // Số lượng hiển thị
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                data[i].quantity = data[i].quantity! + 1;
                              });
                            },
                            child: const Icon(Icons.add, size: 10),
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
            'NOTIFICATION',
            style: MyTextStyle.title,
          ),
          centerTitle: true,
          backgroundColor: Colors.purple,
        ),
        body: SizedBox(
          height: size.height,
          width: size.width,
          child: Stack(
            children: [
              SizedBox(
                height: size.height * 0.68,
                child: ListView.builder(
                  itemCount: data.length,
                  itemBuilder: (context, i) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: lsClick.isEmpty
                          ? CircularProgressIndicator()
                          : slidable(i),
                    );
                  },
                ),
              ),
              Positioned(
                bottom: 0,
                child: Container(
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
                            Text('Chọn tất cả'),
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
                                      style:
                                          title.copyWith(color: Colors.black),
                                    ),
                                  ),
                            const SizedBox(width: 10),
                            Expanded(
                              child: MyButton(
                                disable: isButton,
                                onPressed: () {
                                  Modular.to.pushNamed(Routes.order);
                                },
                                child: Text(
                                  'THANH TOÁN',
                                  style: title2.copyWith(color: Colors.white),
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

void doNothing(BuildContext context) {}

class OrderOfCart {
  int id;
  int number;
  OrderOfCart({required this.id, required this.number});
}
