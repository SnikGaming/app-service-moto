import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import '../../../components/convert/format_money.dart';
import '../../../constants/style.dart';
import '../../../network/connect.dart';
import '../../home/api/products/models/products.dart' as products;

class DetailsServiceScreen extends StatefulWidget {
  final products.Data data;
  const DetailsServiceScreen({super.key, required this.data});

  @override
  State<DetailsServiceScreen> createState() => _DetailsServiceScreenState();
}

class _DetailsServiceScreenState extends State<DetailsServiceScreen> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: () {},
          child: const Icon(Icons.calendar_month_outlined),
        ),
        body: Container(
          color: const Color(0xffF0F0F0),
          height: MediaQuery.of(context).size.height,
          width: size.width,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: ListView(
              children: [
                SizedBox(
                  height: size.height * .6,
                  width: size.width,
                  // color: randomColor(),
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      //!: APP BAR
                      Positioned(
                          top: 0,
                          child: SizedBox(
                            height: 60,
                            // color: Color.fromARGB(188, 120, 54, 244),
                            width: size.width,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    IconButton(
                                        onPressed: () {
                                          Navigator.pop(context);
                                        },
                                        icon: const Icon(
                                            Icons.arrow_back_ios_outlined)),
                                    const Text(
                                      'Thông tin sản phẩm',
                                      style: styleH1,
                                    )
                                  ],
                                ),
                                IconButton(
                                  onPressed: () {},
                                  icon: const Icon(
                                    Icons.shopping_bag_outlined,
                                  ),
                                )
                              ],
                            ),
                          )),
                      Positioned(
                        top: 170,
                        child: Container(
                          height: size.height * .37,
                          width: size.width * .7,
                          decoration: BoxDecoration(
                            color: const Color(0xffFFFFFF),
                            borderRadius: BorderRadius.circular(18),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(1),
                                spreadRadius: 2,
                                blurRadius: 10,
                                offset: const Offset(0, 3),
                              ),
                            ],
                          ),
                          child: Stack(
                            children: [
                              Positioned(
                                bottom: 0,
                                child: Container(
                                  height: size.height * .21,
                                  width: size.width * .7,
                                  decoration: const BoxDecoration(
                                      // color: Colors.blue,
                                      borderRadius: BorderRadius.only(
                                          bottomLeft: Radius.circular(18),
                                          bottomRight: Radius.circular(18))),
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 16,
                                    ),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        const SizedBox(
                                          height: 14,
                                        ),
                                        SizedBox(
                                          width: size.width,
                                          child: Text(
                                            '${widget.data.name}',
                                            style: styleH2,
                                            softWrap: true,
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        Container(
                                          width: 160,
                                          alignment: Alignment.center,
                                          child: Row(
                                            children: List.generate(
                                              5,
                                              (i) => const Icon(Icons.star),
                                            ),
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        Container(
                                          padding: const EdgeInsets.all(12),
                                          decoration: BoxDecoration(
                                            color: Colors.black,
                                            borderRadius:
                                                BorderRadius.circular(18),
                                          ),
                                          child: Text(
                                            '${formatCurrency(amount: '${widget.data.price}')}',
                                            style: styleH3.copyWith(
                                                color: Colors.red),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                      Positioned(
                        top: 70,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(18),
                          child: Container(
                            height: size.height * .27,
                            width: size.width * .6,
                            decoration: const BoxDecoration(
                                // color: const Color.fromARGB(255, 128, 47, 235)
                                //     .withOpacity(0.5),
                                ),
                            child: Stack(
                              alignment: Alignment.center,
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(16),
                                  child: Expanded(
                                    child: CachedNetworkImage(
                                      imageUrl:
                                          '${ConnectDb.url}${widget.data.image}',
                                      fit: BoxFit.cover,
                                      // color: indexData == index ? white : black,
                                      // height: 45,
                                      placeholder: (context, url) =>
                                          const CircularProgressIndicator(),
                                      errorWidget: (context, url, error) =>
                                          const Icon(Icons.error),
                                    ),
                                  ),
                                ),
                                Positioned(
                                  right: 10,
                                  top: 10,
                                  child: IconButton(
                                    onPressed: () {},
                                    icon: const Icon(
                                      Icons.favorite,
                                      color: Colors.red,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                Container(
                  constraints:
                      BoxConstraints(minHeight: 100, minWidth: size.width),
                  decoration: BoxDecoration(
                      // color: Colors.grey, //randomColor(),
                      borderRadius: BorderRadius.circular(30)),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(
                        height: 20,
                      ),
                      const Text(
                        'Thông tin sản phẩm',
                        style: styleH1,
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      Row(
                        children: [
                          Text('50 Comments',
                              style: styleNormal.copyWith(
                                color: Colors.grey,
                                fontStyle: FontStyle.italic,
                              )),
                          GestureDetector(
                            onTap: () {},
                            child: Text(' (Click here)',
                                style: styleNormal.copyWith(
                                    color: Colors.blue,
                                    fontSize: 18,
                                    fontStyle: FontStyle.italic,
                                    fontWeight: FontWeight.bold)),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: [
                          Text(
                            'Số lượt yêu thích : ',
                            style: styleNormal.copyWith(color: Colors.grey),
                          ),
                          Text(
                            '${widget.data.like}',
                            style: styleNormal.copyWith(
                                color: Colors.red, fontSize: 18),
                          ),
                          const SizedBox(
                            width: 8,
                          ),
                          const Icon(
                            Icons.favorite,
                            color: Colors.red,
                          ),
                        ],
                      ),

                      const SizedBox(
                        height: 8,
                      ),
                      Text(
                        '${widget.data.description}',
                        style: styleTitle,
                      ),

                      const SizedBox(
                        height: 8,
                      ),

                      // Container(
                      //   height: 129,
                      //   color: Colors.red,
                      // ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}
