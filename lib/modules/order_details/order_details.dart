import 'package:app/components/calendar/res/colors.dart';
import 'package:app/components/style/text_style.dart';
import 'package:app/functions/random_color.dart';
import 'package:app/api/order/order_details.dart' as or;
import 'package:app/api/order/order_details_api.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../components/convert/format_money.dart';
import '../../network/connect.dart';
import '../app_constants.dart';

class OrderDetails extends StatefulWidget {
  // List<Product> value;
  String value;
  OrderDetails({super.key, required this.value});

  @override
  State<OrderDetails> createState() => _OrderDetailsState();
}

class _OrderDetailsState extends State<OrderDetails> {
  List<or.Data> _data = [];
  loadData() async {
    await APIOrderDetails.fetchOrder(id: widget.value);
    _data = APIOrderDetails.data;
    setState(() {});
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loadData();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Thông tin đơn hàng'),
        backgroundColor: violet,
      ),
      body: SizedBox(
        height: size.height,
        width: size.width,
        child: ListView.builder(
            itemCount: _data.length,
            itemBuilder: ((context, i) {
              final data = _data[i];
              return GestureDetector(
                onTap: () {
                  Modular.to.pushNamed(Routes.details, arguments: data.id);
                },
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(16),
                    child: Container(
                      constraints: const BoxConstraints(
                        minHeight: 150,
                      ),
                      decoration: const BoxDecoration(
                          color: Colors.white70,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey,
                              offset: Offset(2, 3),
                              blurRadius: 10,
                            )
                          ]),
                      child: Row(
                        children: [
                          Flexible(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(16),
                                child: CachedNetworkImage(
                                  imageUrl: '${ConnectDb.url}${data.image}',
                                  height: 150,
                                  placeholder: (context, url) =>
                                      const CircularProgressIndicator(),
                                  errorWidget: (context, url, error) =>
                                      const Icon(Icons.error),
                                ),
                              ),
                            ),
                          ),
                          Flexible(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    '${data.name}',
                                    style: title1.copyWith(
                                        fontSize: 15, color: Colors.black),
                                  ),
                                  const SizedBox(
                                    height: 20,
                                  ),
                                  RichText(
                                    text: TextSpan(
                                      text: 'Số lượng : ',
                                      style: DefaultTextStyle.of(context)
                                          .style
                                          .copyWith(
                                            color: Colors.purple,
                                            fontWeight: FontWeight.w700,
                                          ),
                                      children: <TextSpan>[
                                        TextSpan(
                                          text: '${data.quantity}',
                                          style: DefaultTextStyle.of(context)
                                              .style
                                              .copyWith(color: Colors.black),
                                        ),
                                      ],
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  RichText(
                                    text: TextSpan(
                                      text: 'Tổng tiền : ',
                                      style: DefaultTextStyle.of(context)
                                          .style
                                          .copyWith(
                                            fontWeight: FontWeight.bold,
                                          ),
                                      children: <TextSpan>[
                                        TextSpan(
                                            text: formatCurrency(
                                              amount:
                                                  (data.price! * data.quantity!)
                                                      .toString(),
                                            ),
                                            style: const TextStyle(
                                                fontWeight: FontWeight.bold,
                                                color: Colors.red)),
                                      ],
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  )
                                ],
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              );
            })),
      ),
    );
  }
}
