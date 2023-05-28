// ignore_for_file: use_key_in_widget_constructors

import 'package:app/components/mybage/mybage.dart';
import 'package:app/functions/random_color.dart';
import 'package:app/modules/home/api/order/order.dart' as order;
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import '../../../../components/style/text_style.dart';
import '../../../../network/connect.dart';
import '../../../../preferences/user/user_preferences.dart';
import '../../api/order/api_order.dart';

class ProFilePage extends StatefulWidget {
  const ProFilePage({super.key});

  @override
  State<ProFilePage> createState() => s();
}

class s extends State<ProFilePage> {
  List<order.Data> lsData = [];

  @override
  loadData() async {
    await APIOrder.fetchOrder();
    var dataStatus = await APIOrder.fetchOrderStatus();

    lsData = APIOrder.lsData;

    MyOrder.lsMyOrder[1].bage = dataStatus['status_1'].toString();
    MyOrder.lsMyOrder[2].bage = dataStatus['status_2'].toString();
    MyOrder.lsMyOrder[3].bage = dataStatus['status_3'].toString();

    setState(() {});
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loadData();
  }

  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      body: SizedBox(
        height: size.height,
        width: size.width,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            children: [
              const SizedBox(
                height: 24,
              ),
              //!: User
              const UserProfile(),
              const SizedBox(
                height: 16,
              ),
              //!: Đơn hàng của tôi
              SizedBox(
                height: 136,
                width: size.width,
                // color: Colors.green,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Đơn hàng của tôi',
                      style: h2.copyWith(
                        color: Colors.black,
                      ),
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    SizedBox(
                      height: 100,
                      width: size.width,
                      // color: Colors.purple,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: MyOrder.lsMyOrder.length,
                        itemBuilder: (context, i) {
                          var data = MyOrder.lsMyOrder[i];
                          return Padding(
                            padding: EdgeInsets.only(
                                left: 10,
                                right:
                                    MyOrder.lsMyOrder.length - 1 == i ? 10 : 0),
                            child: Container(
                              height: 80,
                              width: 100,
                              decoration: BoxDecoration(
                                color: randomColor(),
                                borderRadius: BorderRadius.circular(18),
                              ),
                              child: GestureDetector(
                                onTap: () {
                                  setState(() {});
                                },
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    children: [
                                      MyBage(
                                        value: data.bage!,
                                        child: Image.asset(
                                          data.image,
                                          height: 35,
                                          width: 35,
                                          color: Colors.white,
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 4,
                                      ),
                                      Text(
                                        data.name,
                                        style: title1,
                                        textAlign: TextAlign.center,
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    )
                  ],
                ),
              ),
              //!: Slider Sp đang được giao
              Container(
                height: 60,
                width: size.width,
                color: Colors.blue,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class UserProfile extends StatelessWidget {
  const UserProfile({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        //!: Image
        SizedBox(
            height: 80,
            width: 80,
            child: CachedNetworkImage(
              imageBuilder: (context, imageProvider) => CircleAvatar(
                  backgroundImage: NetworkImage(
                      '${ConnectDb.url}${UserPrefer.getImageUser()}')),
              fit: BoxFit.cover,
              placeholder: (context, url) =>
                  const Center(child: CircularProgressIndicator()),
              errorWidget: (context, url, error) => const Icon(Icons.error),
              imageUrl: '${ConnectDb.url}${UserPrefer.getImageUser()}',
            )),
        const SizedBox(
          width: 8,
        ),
        //!: Name
        Text(
          UserPrefer.getsetUserName(),
          style: title2.copyWith(
            color: Colors.black,
          ),
        ),
      ],
    );
  }
}

class MyOrder {
  String image;
  String name;
  String? bage;
  MyOrder({required this.image, required this.name, this.bage});
  static List<MyOrder> lsMyOrder = [
    MyOrder(
        image: 'assets/icons/cart/wallet.png',
        name: 'Chờ thanh toán',
        bage: ''),
    MyOrder(
        image: 'assets/icons/cart/parcel.png',
        name: 'Chờ vận chuyển',
        bage: ''),
    MyOrder(
        image: 'assets/icons/cart/transportation-truck.png',
        name: 'Chờ giao hàng',
        bage: ''),
    MyOrder(
        image: 'assets/icons/cart/chat.png', name: 'Chưa đánh giá', bage: ''),
    MyOrder(
        image: 'assets/icons/cart/briefcase.png', name: 'Đổi trả', bage: ''),
  ];
}
