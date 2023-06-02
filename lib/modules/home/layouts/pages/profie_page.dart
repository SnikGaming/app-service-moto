// ignore_for_file: use_key_in_widget_constructors

import 'package:app/components/CusRichText/CusRichText.dart';
import 'package:app/components/mybage/mybage.dart';
import 'package:app/functions/random_color.dart';
import 'package:app/modules/home/api/order/order.dart' as order;
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import '../../../../components/convert/format_money.dart';
import '../../../../components/style/text_style.dart';
import '../../../../network/connect.dart';
import '../../../../preferences/user/user_preferences.dart';
import '../../api/order/api_order.dart';

class ProFilePage extends StatefulWidget {
  const ProFilePage({super.key});

  @override
  State<ProFilePage> createState() => _ProFilePageState();
}

class _ProFilePageState extends State<ProFilePage> {
  List<order.Data> lsData = [];
  int indexSelect = -1;
  loadData({int? status}) async {
    if (status != null) {
      await APIOrder.fetchOrder(status: status);
    } else {
      await APIOrder.fetchOrder();
    }
    lsData = APIOrder.lsData;

    var dataStatus = await APIOrder.fetchOrderStatus();
    if (dataStatus != []) {
      try {
        MyOrder.lsMyOrder[0].bage = dataStatus['status_2'].toString();
        MyOrder.lsMyOrder[1].bage = dataStatus['status_1'].toString();
        MyOrder.lsMyOrder[2].bage = dataStatus['status_3'].toString();
        MyOrder.lsMyOrder[3].bage = dataStatus['status_4'].toString();
        MyOrder.lsMyOrder[4].bage = dataStatus['status_0'].toString();
      } catch (e) {
        print(e);
      }
    }

    setState(() {});
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loadData();
  }

  bool _isExpanded = false;
  @override
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
                          return GestureDetector(
                            onTap: () {
                              indexSelect = i;
                              setState(() {});
                              loadData(status: data.id);
                            },
                            child: Padding(
                              padding: EdgeInsets.only(
                                  left: 10,
                                  right: MyOrder.lsMyOrder.length - 1 == i
                                      ? 10
                                      : 0),
                              child: Container(
                                height: 80,
                                width: 100,
                                decoration: BoxDecoration(
                                  color: indexSelect == i
                                      ? Colors.red
                                      : Colors.purple.shade400,
                                  borderRadius: BorderRadius.circular(18),
                                ),
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
                child: Row(
                  children: [
                    Expanded(
                      flex: 9,
                      child: Container(),
                    ),
                    const Expanded(
                      flex: 1,
                      child: Icon(Ionicons.chevron_forward_outline),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 16,
              ),
              Expanded(
                  child: ListView.builder(
                      itemCount: lsData.length,
                      itemBuilder: (context, i) {
                        var data = lsData[i];
                        return Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 8, horizontal: 5),
                          child: Container(
                            height: 130,
                            width: size.width,
                            decoration: BoxDecoration(
                                color: const Color.fromARGB(255, 225, 221, 221),
                                boxShadow: const [
                                  BoxShadow(
                                    color: Colors.grey,
                                    offset: Offset(5, 9),
                                    blurRadius: 5,
                                  )
                                ],
                                borderRadius: BorderRadius.circular(30)),
                            child: Padding(
                              padding: const EdgeInsets.all(14),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  CusRichText(
                                      selectedAddress: data.name.toString(),
                                      text: 'Tên người nhận : '),
                                  CusRichText(
                                      selectedAddress: formatCurrency(
                                          amount: data.totalPrice.toString()),
                                      text: 'Giá : '),
                                  CusRichText(
                                      selectedAddress: data.address.toString(),
                                      text: 'Địa chỉ : '),
                                  CusRichText(
                                      selectedAddress: data.status == 3
                                          ? "Đang giao, bạn vui lòng chuẩn bị tiền."
                                          : "Đang xử lý",
                                      text: 'Trạng thái : '),
                                ],
                              ),
                            ),
                          ),
                        );
                      }))
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
            child: UserPrefer.getImageUser() == 'null' ||
                    UserPrefer.getImageUser() == null
                ? Container()
                : CachedNetworkImage(
                    imageBuilder: (context, imageProvider) => CircleAvatar(
                        backgroundImage: NetworkImage(
                            '${ConnectDb.url}${UserPrefer.getImageUser()}')),
                    fit: BoxFit.cover,
                    placeholder: (context, url) =>
                        const Center(child: CircularProgressIndicator()),
                    errorWidget: (context, url, error) =>
                        const Icon(Icons.error),
                    imageUrl: '${ConnectDb.url}${UserPrefer.getImageUser()}',
                  )),
        const SizedBox(
          width: 8,
        ),
        //!: Name
        Text(
          UserPrefer.getsetUserName() ?? "GUES",
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
  int id;
  MyOrder(
      {required this.image, required this.name, this.bage, required this.id});
  static List<MyOrder> lsMyOrder = [
    MyOrder(
        image: 'assets/icons/cart/wallet.png',
        name: 'Chờ thanh toán',
        bage: '',
        id: 2),
    MyOrder(
        image: 'assets/icons/cart/parcel.png',
        name: 'Chờ vận chuyển',
        bage: '',
        id: 1),
    MyOrder(
        image: 'assets/icons/cart/transportation-truck.png',
        name: 'Chờ giao hàng',
        bage: '',
        id: 3),
    MyOrder(
        image: 'assets/icons/cart/chat.png',
        name: 'Chưa đánh giá',
        bage: '',
        id: 4),
    MyOrder(
        image: 'assets/icons/cart/briefcase.png',
        name: 'Đổi trả',
        bage: '',
        id: 0),
  ];
}
