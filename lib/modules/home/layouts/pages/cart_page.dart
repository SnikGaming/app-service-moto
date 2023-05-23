import 'package:app/components/button/mybutton.dart';
import 'package:app/components/style/text_style.dart';
import 'package:app/components/style/textstyle.dart';
import 'package:app/modules/home/layouts/pages/services_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import '../../../../functions/check_true_false_list.dart';
import '../../../app_constants.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  List<bool> lsClick = [];
  bool isButton = true;
  int sl = 10;
  load() {
    for (int i = 0; i < sl; i++) {
      lsClick.add(false);
    }
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    load();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    sliable(i) {
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
                topLeft: Radius.circular(16), bottomLeft: Radius.circular(16)),
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
                    });
                  }),
              Expanded(
                flex: 1,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Row(
                      children: [
                        Image.asset(
                          'assets/appbar/logout.png',
                          height: 100,
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        const Expanded(
                          child: Text(
                              'abcasd ashdj hasjd ghajsdghj asdasdsa ad dasd asd asd asd asda sdas das das das dfsdfsdfsdfsd sd asgdhj agsdjh vasjhdva shdv hasdv'),
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
                              // Giảm số lượng
                            },
                            child: const Icon(Icons.remove, size: 10),
                          ),
                          GestureDetector(
                            onTap: () {
                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  int quantity = 10; // Số lượng hiện tại

                                  return AlertDialog(
                                    title: const Text('Nhập số lượng'),
                                    content: TextField(
                                      keyboardType: TextInputType.number,
                                      onChanged: (value) {
                                        quantity = int.tryParse(value) ?? 0;
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
                                          // Xử lý số lượng
                                          // quantity chứa giá trị số lượng mới
                                          Navigator.of(context).pop();
                                        },
                                        child: const Text('Xác nhận'),
                                      ),
                                    ],
                                  );
                                },
                              );
                            },
                            child: const Text(
                              '10', // Số lượng hiển thị
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              // Tăng số lượng
                            },
                            child: const Icon(Icons.add, size: 10),
                          ),
                        ],
                      ),
                    )
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
                height: size.height * .73,
                // color: Colors.green,
                child: ListView.builder(
                  itemCount: 10,
                  itemBuilder: (context, i) => Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: sliable(i),
                  ),
                ),
              ),
              Positioned(
                bottom: 0,
                child: Row(
                  children: [
                    SizedBox(
                      width: size.width,
                      height: size.height * .083,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: Row(
                          children: [
                            isButton
                                ? Container()
                                : Expanded(
                                    flex: 2,
                                    child: Text(
                                      'Tổng : 120.000.000đ',
                                      style:
                                          title.copyWith(color: Colors.black),
                                    ),
                                  ),
                            const SizedBox(
                              width: 10,
                            ),
                            Expanded(
                              child: MyButton(
                                  disable: isButton,
                                  onPressed: () {
                                    Modular.to.pushNamed(Routes.order);
                                  },
                                  child: Text(
                                    'THANH TOÁN',
                                    style: title2.copyWith(color: Colors.white),
                                  )),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
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
