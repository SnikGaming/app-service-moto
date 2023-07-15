// ignore_for_file: use_key_in_widget_constructors

import 'package:app/components/CusRichText/CusRichText.dart';
import 'package:app/components/button/button.dart';

import 'package:app/components/mybage/mybage.dart';
import 'package:app/api/order/order.dart' as order;
import 'package:app/modules/login/layouts/login_screen.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:lottie/lottie.dart';
import '../../../../components/button/mybutton.dart';
import '../../../../components/convert/format_money.dart';
import '../../../../components/style/text_style.dart';
import '../../../../network/connect.dart';
import '../../../../preferences/user/user_preferences.dart';
import '../../../app_constants.dart';
import '../../../order_details/order_details.dart';
import '../../../../api/login/api_login.dart';
import '../../../../api/order/api_order.dart';

class ProFilePage extends StatefulWidget {
  const ProFilePage({super.key});
  @override
  State<ProFilePage> createState() => _ProFilePageState();
}

class _ProFilePageState extends State<ProFilePage> {
  Map<String, dynamic>? paymentIntern;

  // loadUser() async {

  //   setState(() {});
  // }

  List<order.Data> lsData = [];
  int indexSelect = -1;
  loadData({int? status}) async {
    if (UserPrefer.getToken() != null) {
      await APIAuth.getUser();
      if (status != null) {
        await APIOrder.fetchOrder(status: status);
      } else {
        await APIOrder.fetchOrder();
      }
      lsData = APIOrder.lsData;

      var dataStatus = await APIOrder.fetchOrderStatus();
      // print('------------------->DATA ${lsData}');
      if (mounted) {
        setState(() {
          if (dataStatus != []) {
            try {
              MyOrder.lsMyOrder[3].bage =
                  dataStatus['status_2'].toString(); //!: Huy doi tra
              MyOrder.lsMyOrder[0].bage =
                  dataStatus['status_1'].toString(); //!: Chờ vận chuyển
              MyOrder.lsMyOrder[1].bage =
                  dataStatus['status_3'].toString(); //!: Chờ giao hàng

              MyOrder.lsMyOrder[2].bage =
                  dataStatus['status_4'].toString(); //!: Chưa đánh giá
            } catch (e) {
              print(e);
            }
          }
        });
      }
    }
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
          child: UserPrefer.getToken() == null
              ? Center(
                  child: ButtonCustom(
                    width: 120,
                    ontap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (_) => const LoginScreen()));
                    },
                    child: const Center(
                      child: Text(
                        'Đăng nhập',
                        style: title1,
                      ),
                    ),
                  ),
                )
              : Column(
                  children: [
                    const SizedBox(
                      height: 24,
                    ),
                    //!: User
                    Row(
                      children: [
                        //!: Image
                        SizedBox(
                            height: 80,
                            width: 80,
                            child: UserPrefer.getImageUser() == 'null' ||
                                    UserPrefer.getImageUser() == null
                                ? Container(
                                    height: 45,
                                    width: 45,
                                    decoration: const BoxDecoration(
                                      // color: violet,
                                      shape: BoxShape.circle,
                                    ),
                                    child: Lottie.network(
                                        'https://assets10.lottiefiles.com/packages/lf20_1mvhccet.json'),
                                  )
                                : CachedNetworkImage(
                                    imageBuilder: (context, imageProvider) =>
                                        CircleAvatar(
                                            backgroundImage: NetworkImage(
                                                '${ConnectDb.url}${UserPrefer.getImageUser()}')),
                                    fit: BoxFit.cover,
                                    placeholder: (context, url) => const Center(
                                        child: CircularProgressIndicator()),
                                    errorWidget: (context, url, error) =>
                                        const Icon(Icons.error),
                                    imageUrl:
                                        '${ConnectDb.url}${UserPrefer.getImageUser()}',
                                  )),
                        const SizedBox(
                          width: 8,
                        ),
                        //!: Name
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              UserPrefer.getsetUserName(),
                              style: title1.copyWith(
                                color: Colors.black,
                              ),
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            Row(
                              children: [
                                Text(
                                  formatCurrency(
                                    amount: UserPrefer.getScore(),
                                  ),
                                  style: title1.copyWith(
                                    color: Colors.grey,
                                    fontSize: 14,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    //!: Đơn hàng của tôi
                    SizedBox(
                      height: 140,
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
                            // color: Colors.green,
                            height: 90,
                            width: size.width,
                            // color: Colors.purple,
                            child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: MyOrder.lsMyOrder.length,
                              itemBuilder: (context, i) {
                                var data = MyOrder.lsMyOrder[i];
                                return Padding(
                                  padding: const EdgeInsets.all(4.0),
                                  child: GestureDetector(
                                    onTap: () {
                                      indexSelect = i;
                                      setState(() {});
                                      loadData(status: data.id);
                                    },
                                    child: Container(
                                      height: 50,
                                      width: 80,
                                      decoration: BoxDecoration(
                                        color: indexSelect == i
                                            ? const Color.fromARGB(
                                                255, 54, 54, 244)
                                            : const Color.fromARGB(
                                                255, 40, 40, 42),
                                        borderRadius: BorderRadius.circular(18),
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.all(4.0),
                                        child: Column(
                                          children: [
                                            MyBage(
                                              value: data.bage!,
                                              child: Image.asset(
                                                data.image,
                                                height: 25,
                                                width: 25,
                                                color: Colors.white,
                                              ),
                                            ),
                                            const SizedBox(
                                              height: 4,
                                            ),
                                            Text(
                                              data.name,
                                              style:
                                                  title1.copyWith(fontSize: 12),
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

                    const SizedBox(
                      height: 16,
                    ),
                    Expanded(
                        child: ListView.builder(
                            itemCount: lsData.length,
                            itemBuilder: (context, i) {
                              var data = lsData[i];

                              return GestureDetector(
                                onTap: () async {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (_) =>
                                            OrderDetails(value: data.id!),
                                      ));
                                },
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 8, horizontal: 5),
                                  child: Container(
                                    height: data.status == 1 ? 200 : 170,
                                    width: size.width,
                                    decoration: BoxDecoration(
                                        color: const Color.fromARGB(
                                            255, 255, 255, 255),
                                        boxShadow: const [
                                          BoxShadow(
                                            color: Color.fromARGB(
                                                255, 213, 205, 205),
                                            offset: Offset(5, 9),
                                            blurRadius: 5,
                                          )
                                        ],
                                        borderRadius:
                                            BorderRadius.circular(30)),
                                    child: Padding(
                                      padding: const EdgeInsets.all(14),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          CusRichText(
                                              selectedAddress:
                                                  data.name.toString(),
                                              text: 'Tên người nhận : '),
                                          const SizedBox(
                                            height: 10,
                                          ),
                                          CusRichText(
                                              selectedAddress: formatCurrency(
                                                amount:
                                                    data.totalPrice.toString(),
                                              ),
                                              color: Colors.red,
                                              text: 'Giá : '),
                                          const SizedBox(
                                            height: 10,
                                          ),
                                          CusRichText(
                                              selectedAddress:
                                                  data.address.toString(),
                                              text: 'Địa chỉ : '),
                                          data.payment == 1 || data.status == 2
                                              ? Container()
                                              : const Column(
                                                  children: [
                                                    SizedBox(
                                                      height: 10,
                                                    ),
                                                    CusRichText(
                                                      selectedAddress:
                                                          "Đã thanh toán",
                                                      text: 'Đơn hàng : ',
                                                      color: Colors.green,
                                                    ),
                                                  ],
                                                ),
                                          const SizedBox(
                                            height: 10,
                                          ),
                                          CusRichText(
                                            selectedAddress: data.status == 3
                                                ? "Đang giao, bạn vui lòng chuẩn bị tiền."
                                                : data.status == 4
                                                    ? "Giao thành công"
                                                    : data.status == 2
                                                        ? "Đơn hàng đã hủy, hoặc giao không thành công"
                                                        : "Đang đóng gói",
                                            text: 'Trạng thái : ',
                                            color: Colors.blue,
                                          ),
                                          const Spacer(),
                                          data.status == 1
                                              ? SizedBox(
                                                  width: size.width,
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      Container(),
                                                      InkWell(
                                                        onTap: () {
                                                          showDialog(
                                                            context: context,
                                                            builder:
                                                                (context) =>
                                                                    AlertDialog(
                                                              title: const Text(
                                                                  'Thông báo'),
                                                              content: const Text(
                                                                  'Bạn có chắc muốn hủy đơn hàng này ?'),
                                                              actions: <Widget>[
                                                                TextButton(
                                                                  onPressed: () =>
                                                                      Navigator.of(
                                                                              context)
                                                                          .pop(
                                                                              false),
                                                                  child: const Text(
                                                                      'Không'),
                                                                ),
                                                                TextButton(
                                                                  onPressed:
                                                                      () async {
                                                                    await APIOrder
                                                                        .huy(
                                                                            id: '${data.id}');
                                                                    if (data.payment !=
                                                                        1) {
                                                                      await APIAuth
                                                                          .getUser();

                                                                      print(
                                                                          'score user ${UserPrefer.getScore()}');
                                                                    }
                                                                    loadData();

                                                                    Navigator.of(
                                                                            context)
                                                                        .pop(
                                                                            true);
                                                                  },
                                                                  child:
                                                                      const Text(
                                                                          'Có'),
                                                                ),
                                                              ],
                                                            ),
                                                          );
                                                        },
                                                        child: Container(
                                                          height: 30,
                                                          width: 100,
                                                          decoration:
                                                              BoxDecoration(
                                                            color: const Color
                                                                    .fromARGB(
                                                                255,
                                                                195,
                                                                183,
                                                                183),
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        30),
                                                          ),
                                                          child: const Center(
                                                            child: Text('Hủy'),
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                )
                                              : Container()
                                        ],
                                      ),
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

class MyOrder {
  String image;
  String name;
  String? bage;
  int id;
  MyOrder(
      {required this.image, required this.name, this.bage, required this.id});
  static List<MyOrder> lsMyOrder = [
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
        name: 'Đã hoàn thành',
        bage: '',
        id: 4),
    MyOrder(
        image: 'assets/icons/cart/wallet.png',
        name: 'Hủy, đổi trả',
        bage: '',
        id: 2),
  ];
}
