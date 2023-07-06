// ignore_for_file: library_prefixes, unused_element

import 'dart:math';

import 'package:app/modules/home/api/address/model.dart' as address;
import 'package:app/modules/home/layouts/pages/services_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:lottie/lottie.dart';
import '../../../../components/button/mybutton.dart';
import '../../../../components/calendar/res/colors.dart';
import '../../../../components/districts/AddressDisplayScreen .dart';
import '../../../../components/style/text_style.dart';
import '../../../../components/style/textstyle.dart';
import '../../../../components/value_app.dart';
import '../../../../functions/check_true_false_list.dart';
import '../../../../network/connect.dart';
import '../../../app_constants.dart';
import '../../api/address/api_address.dart';
import '../../api/cart/api_cart.dart';
import '../../api/cart/model.dart' as CartModel;
import '../../../../components/convert/format_money.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({Key? key}) : super(key: key);

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  Color randomColor() {
    Random random = Random();
    int red = random.nextInt(256);
    int green = random.nextInt(256);
    int blue = random.nextInt(256);

    // Kiểm tra nếu màu là màu trắng, thì random lại
    if (red == 255 && green == 255 && blue == 255) {
      return randomColor();
    }
    print('Mã màu ${Color.fromRGBO(red, green, blue, .8)}');

    return Color.fromRGBO(red, green, blue, .8);
  }

  List<bool> lsClick = [];
  bool isLoad = false;
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
          'cartId': data[i].id,
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

  address.Data? _address;
  List<CartModel.Data> data = [];
  loadData() async {
    await APIAddress.fetchAddress();
    await ApiCart.getData();

    if (mounted) {
      setState(() {
        if (APIAddress.lsData.isNotEmpty) {
          _address = APIAddress.lsData[0];
        } else {
          _address = null;
        }
        isButton = true;

        data = ApiCart.lsCart;
        lsClick = List.generate(data.length, (index) => false);
        isLoad = true;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    loadData();
  }

  @override
  void dispose() => super.dispose();

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
            color: Color.fromARGB(204, 233, 138, 83),
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(16),
              bottomLeft: Radius.circular(16),
            ),
          ),
          child: Row(
            children: [
              Checkbox(
                side: const BorderSide(color: Colors.white),
                activeColor: Colors.red,
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
                          ClipRRect(
                            borderRadius: BorderRadius.circular(16),
                            child: CachedNetworkImage(
                              imageUrl: '${ConnectDb.url}${data[i].image}',
                              height: 100,
                              placeholder: (context, url) => const Center(
                                  child: CircularProgressIndicator()),
                              errorWidget: (context, url, error) =>
                                  const Icon(Icons.error),
                            ),
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  data[i].productName!,
                                  style: title1.copyWith(
                                      color: Colors.white, fontSize: 16),
                                ),
                                const SizedBox(
                                  height: 8,
                                ),
                                Text(
                                  'Giá : ${data[i].price.toString()}',
                                  style: title1.copyWith(
                                      color: const Color.fromARGB(
                                          255, 254, 254, 1),
                                      fontSize: 15),
                                ),
                                const SizedBox(
                                  height: 8,
                                ),
                                Text(
                                  'Tổng tiền: ${formatCurrency(amount: '${int.parse(data[i].price!) * data[i].quantity!}')}',
                                  style: title1.copyWith(
                                      color: const Color.fromARGB(
                                          255, 54, 212, 244),
                                      fontSize: 14),
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
                                border: Border.all(color: Colors.white),
                                shape: BoxShape.circle,
                              ),
                              child: const Icon(
                                Icons.remove,
                                size: 10,
                                color: Colors.white,
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
                                style: const TextStyle(color: Colors.white),
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
                                border: Border.all(color: Colors.white),
                                shape: BoxShape.circle,
                              ),
                              child: const Icon(
                                Icons.add,
                                size: 10,
                                color: Colors.white,
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
            txtCart,
            style: MyTextStyle.title,
          ),
          centerTitle: true,
          backgroundColor: violet,
        ),
        body: SizedBox(
          height: size.height,
          width: size.width,
          child: isLoad == false
              ? const Center(child: CircularProgressIndicator())
              : data.isEmpty
                  ? Center(
                      child: Lottie.network(imageNoData, height: 200),
                    )
                  // build2(context)
                  //!: Hiển thị sản phẩm
                  : Stack(
                      children: [
                        SizedBox(
                          height: size.height * 0.64,
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
                            height: size.height * 0.16,
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 10),
                              child: Column(
                                children: [
                                  Row(
                                    children: [
                                      Checkbox(
                                        checkColor: Colors.white,
                                        activeColor: Colors.red,
                                        value: selectAll,
                                        onChanged: (value) {
                                          selectAllItems(value!);
                                        },
                                      ),
                                      const Text(txtSelectAll),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      isButton
                                          ? Container()
                                          : Expanded(
                                              flex: 2,
                                              child: Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 10),
                                                child: Text(
                                                  'Tổng: ${formatCurrency(amount: calculateTotalPrice().toString())}',
                                                  style: title.copyWith(
                                                      color: Colors.red),
                                                ),
                                              ),
                                            ),
                                      const SizedBox(width: 10),
                                      Expanded(
                                        child: MyButton(
                                          backgroundColor: Colors.red,
                                          disable: isButton,
                                          onPressed: () async {
                                            List<Map<String, dynamic>> json =
                                                createOrder();

                                            // Chuyển danh sách selectedIds qua màn hình Order
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                  builder: (_) =>
                                                      AddressDisplayScreen(
                                                    selectedAddress: _address,
                                                    isBuy: false,
                                                    json: json,
                                                  ),
                                                )).then((value) {
                                              selectAll = false;
                                              loadData();
                                            });
                                            // showModalBottomSheet(
                                            //   isScrollControlled: true,
                                            //   context: context,
                                            //   builder: (context) =>
                                            //       AddressDisplayScreen(
                                            //     selectedAddress: _address,
                                            //     isBuy: false,
                                            //     json: json,
                                            //   ),
                                            // ).then((value) {
                                            //   selectAll = false;
                                            //   loadData();
                                            // });
                                            // await APIOrder.addOrder(json: json);
                                            // Modular.to
                                            //     .pushNamed(Routes.order,
                                            //         arguments: json)
                                            //     .then((value) => loadData());
                                          },
                                          child: Text(
                                            txtThanhToan,
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
