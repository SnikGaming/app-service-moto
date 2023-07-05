import 'package:app/components/style/text_style.dart';
import 'package:app/functions/random_color.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:lottie/lottie.dart';
import 'package:pagination_flutter/pagination.dart';
import '../../../../components/calendar/res/colors.dart';
import '../../../../components/convert/format_money.dart';
import '../../../../components/value_app.dart';
import '../../../../network/connect.dart';
import '../../../app_constants.dart';
import '../../api/favorites/api.dart';
import '../../api/products/api_product.dart';

class ServicesPage extends StatefulWidget {
  const ServicesPage({super.key});

  @override
  State<ServicesPage> createState() => _ServicesPageState();
}

class _ServicesPageState extends State<ServicesPage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _scrollController.addListener(() {});
    loadData();
  }

  final _scrollController = ScrollController();

  void scrollData() {
    _scrollController.animateTo(
      0,
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeInOut,
    );
  }

  loadData() async {
    await APIFavorites.getData(page: page);
    if (mounted) {
      setState(() {
        // Update the state here
      });
    }
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _scrollController.dispose();
  }

  int page = 1;
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: violet,
        title: const Text('YÊU THÍCH'),
      ),
      body: SingleChildScrollView(
        physics: const NeverScrollableScrollPhysics(),
        child: SizedBox(
          height: size.height,
          width: size.width,
          child: Stack(
            children: [
              SingleChildScrollView(
                physics: const NeverScrollableScrollPhysics(),
                child: Container(
                  height: size.height,
                  width: size.width,
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage(imageBooking), fit: BoxFit.cover),
                  ),
                ),
              ),
              SizedBox(
                height: size.height * .8,
                width: size.width,
                child: APIFavorites.data.length == 0
                    ? Center(
                        child: Lottie.network(imageNoData, height: 200),
                      )
                    : ListView.builder(
                        controller: _scrollController,
                        itemCount: APIFavorites.data.length + 1,
                        itemBuilder: (context, i) {
                          if (i < APIFavorites.data.length) {
                            final data = APIFavorites.data[i];
                            return GestureDetector(
                              onTap: () async {
                                Modular.to.pushNamed(Routes.details,
                                    arguments: data.productId);
                              },
                              child: Padding(
                                padding: const EdgeInsets.all(16),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(16),
                                  child: Container(
                                    constraints:
                                        const BoxConstraints(minHeight: 120),
                                    decoration: BoxDecoration(
                                      // color: randomColor(),
                                      color: const Color.fromARGB(
                                          255, 206, 205, 205),
                                    ),
                                    child: Row(
                                      children: [
                                        Flexible(
                                          child: Padding(
                                            padding: const EdgeInsets.all(16),
                                            child: ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(16),
                                              child: CachedNetworkImage(
                                                imageUrl:
                                                    '${ConnectDb.url}${data.image}',
                                                // height: 30,
                                                placeholder: (context, url) =>
                                                    const CircularProgressIndicator(),
                                                errorWidget:
                                                    (context, url, error) =>
                                                        const Icon(Icons.error),
                                              ),
                                            ),
                                          ),
                                        ),
                                        Flexible(
                                          child: Padding(
                                            padding: const EdgeInsets.only(
                                                right: 16),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  data.name!,
                                                  style: title2,
                                                ),
                                                const SizedBox(
                                                  height: 10,
                                                ),
                                                Text(
                                                  formatCurrency(
                                                    amount:
                                                        data.price.toString(),
                                                  ),
                                                  style: title2.copyWith(
                                                      color: Colors.purple),
                                                ),
                                                Row(
                                                  children: [
                                                    Spacer(),
                                                    GestureDetector(
                                                        onTap: () async {
                                                          final value =
                                                              await APIProduct
                                                                  .create(
                                                                      id: data
                                                                          .productId!);
                                                          loadData();
                                                        },
                                                        child: Icon(
                                                            Icons.favorite)),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            );
                          } else {
                            return SizedBox(
                              height: 120,
                              // color: Colors.grey, // Màu sắc của nút "Next"
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Pagination(
                                    numOfPages: APIFavorites.total!,
                                    selectedPage: page,
                                    pagesVisible: 3,
                                    spacing: 10,
                                    onPageChanged: (value) {
                                      // scrollData();
                                      setState(() {
                                        page = value;
                                        loadData();
                                      });
                                    },
                                    nextIcon: const Icon(
                                      Icons.arrow_forward_ios,
                                      size: 14,
                                    ),
                                    previousIcon: const Icon(
                                      Icons.arrow_back_ios,
                                      size: 14,
                                    ),
                                    activeTextStyle: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w700,
                                    ),
                                    activeBtnStyle: ButtonStyle(
                                      backgroundColor:
                                          MaterialStateProperty.all(
                                              Colors.black),
                                      shape: MaterialStateProperty.all(
                                        RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(38),
                                        ),
                                      ),
                                    ),
                                    inactiveBtnStyle: ButtonStyle(
                                      shape: MaterialStateProperty.all(
                                          RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(38),
                                      )),
                                    ),
                                    inactiveTextStyle: const TextStyle(
                                      fontSize: 14,
                                      color: Colors.black,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                  const SizedBox(height: 10),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      GestureDetector(
                                        onTap: () => setState(() {
                                          // scrollData();
                                          page = 1;
                                          loadData();
                                        }),
                                        child: Container(
                                          decoration: BoxDecoration(
                                            color: randomColor(),
                                            borderRadius:
                                                BorderRadius.circular(16),
                                          ),
                                          height: 30,
                                          width: 100,
                                          child: Center(
                                              child: Text(
                                            'Đầu trang',
                                            style: h1.copyWith(
                                                color: Colors.white),
                                          )),
                                        ),
                                      ),
                                      const SizedBox(
                                        width: 10,
                                      ),
                                      GestureDetector(
                                        onTap: () {
                                          setState(() {
                                            // scrollData();
                                            page = APIFavorites.total;
                                            loadData();
                                          });
                                        },
                                        child: Container(
                                          decoration: BoxDecoration(
                                            color: randomColor(),
                                            borderRadius:
                                                BorderRadius.circular(16),
                                          ),
                                          height: 30,
                                          width: 100,
                                          child: Center(
                                              child: Text(
                                            'Cuối trang',
                                            style: h1.copyWith(
                                                color: Colors.white),
                                          )),
                                        ),
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            );
                          }
                        },
                      ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

List<Color> lsColor = [
  Colors.green.shade300,
  // Colors.yellow.shade300,
  Colors.blue.shade300,
  Colors.pink.shade300,
  const Color.fromARGB(166, 98, 235, 240),
  Colors.purple.shade300,
  Colors.blueAccent,
  const Color.fromARGB(195, 129, 33, 218),
  // const Color.fromARGB(186, 240, 174, 98),
];

const title = TextStyle(
  fontWeight: FontWeight.w700,
  fontSize: 20,
  letterSpacing: 1,
);

const subTitle = TextStyle(
  fontWeight: FontWeight.w400,
  fontSize: 14,
  letterSpacing: 1,
);
const h1 = TextStyle(
  fontWeight: FontWeight.w700,
  fontSize: 18,
  letterSpacing: 1,
);
