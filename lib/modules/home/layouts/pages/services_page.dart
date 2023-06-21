import 'package:app/components/message/message.dart';
import 'package:app/modules/home/api/booking/model.dart' as Booking;
import 'package:flutter/material.dart';
import 'package:searchbar_animation/searchbar_animation.dart';

import '../../../../components/value_app.dart';
import '../../../../functions/random_color.dart';
import '../../api/booking/api_booking.dart';

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
    loadData();
  }

  void setStateIfMounted(VoidCallback fn) {
    if (mounted) {
      setState(fn);
    }
  }

  List<Booking.Data> lsBooking = [];
  // loadData() async {
  //   await APIBooking.fetchBookings();
  //   lsBooking = APIBooking.lsData;
  //   setState(() {});
  // }
  Future<List<Booking.Data>> loadData() async {
    await APIBooking.fetchBookings();
    return APIBooking.lsData;
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('BOOKING'),
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
              Column(
                children: [
                  SearchBarAnimation(
                    textEditingController: TextEditingController(),
                    isOriginalAnimation: true,
                    enableKeyboardFocus: true,
                    onExpansionComplete: () {
                      Message.success(
                          context: context, message: 'on onExpansionComplete');

                      debugPrint(
                          'do something just after searchbox is opened.');
                    },
                    onCollapseComplete: () {
                      Message.success(context: context, message: 'on collapse');
                      debugPrint(
                          'do something just after searchbox is closed.');
                    },
                    onPressButton: (isSearchBarOpens) {
                      print(isSearchBarOpens);
                      Message.success(
                          context: context, message: 'on isSearchBarOpens');

                      // debugPrint(
                      //     'do something before animation started. It\'s the ${isSearchBarOpens ? 'opening' : 'closing'} animation');
                    },
                    trailingWidget: const Icon(
                      Icons.search,
                      size: 20,
                      color: Colors.black,
                    ),
                    secondaryButtonWidget: const Icon(
                      Icons.close,
                      size: 20,
                      color: Colors.black,
                    ),
                    buttonWidget: const Icon(
                      Icons.search,
                      size: 20,
                      color: Colors.black,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        right: 20, left: 20, bottom: 30, top: 20),
                    child: SizedBox(
                      height: 55,
                      width: size.width,
                      child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (context, i) => Padding(
                                padding: EdgeInsets.only(
                                    left: i == 0 ? 0 : 10, right: 10),
                                child: Container(
                                  height: 45,
                                  width: 80,
                                  decoration: BoxDecoration(
                                    color: randomColor(),
                                    borderRadius: BorderRadius.circular(18),
                                  ),
                                ),
                              )),
                    ),
                  ),
                  Expanded(
                      // height: size.height - 330,
                      //?: Loading data
                      child: FutureBuilder<List<Booking.Data>>(
                    future: APIBooking.fetchBookings(),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        final lsBooking = snapshot.data!;
                        return ListView.builder(
                          itemCount: lsBooking.length,
                          itemBuilder: (context, i) => GestureDetector(
                            onTap: () async {
                              print('data ____');
                            },
                            child: Padding(
                              padding: EdgeInsets.only(
                                left: 20,
                                right: 20,
                                top: i == 0 ? 0 : 20,
                                bottom: i == lsBooking.length - 1 ? 200 : 0,
                              ),
                              child: Container(
                                constraints: const BoxConstraints(
                                  minHeight: 80,
                                ),
                                width: size.width,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  border: Border.all(
                                    width: 1,
                                    color: const Color.fromARGB(
                                        255, 149, 101, 211),
                                  ),
                                  borderRadius: BorderRadius.circular(30),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey.withOpacity(0.5),
                                      spreadRadius: 5,
                                      blurRadius: 7,
                                      offset: const Offset(0, 3),
                                    ),
                                  ],
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(20),
                                  child: Column(
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            "Booking ${i + 1}",
                                            style: title,
                                          ),
                                          Row(
                                            children: [
                                              Text(
                                                "${lsBooking[i].bookingTime}",
                                                style: subTitle,
                                              ),
                                              const Icon(Icons.calendar_today),
                                            ],
                                          ),
                                        ],
                                      ),
                                      const SizedBox(
                                        height: 20,
                                      ),
                                      Row(
                                        children: [
                                          const Icon(Icons.location_on),
                                          Text(
                                            "${lsBooking[i].service}",
                                            style: subTitle,
                                          ),
                                        ],
                                      ),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      Text(
                                        'BOOKING',
                                        style: title.copyWith(
                                          color: randomColor(),
                                          fontSize: 16,
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          const Flexible(
                                            flex: 1,
                                            child: Icon(
                                              Icons.note,
                                              color: Colors.orange,
                                            ),
                                          ),
                                          const SizedBox(width: 10),
                                          Flexible(
                                            flex: 9,
                                            child: Text(
                                              "${lsBooking[i].note}",
                                              style: subTitle,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        );
                      } else if (snapshot.hasError) {
                        return Text('${snapshot.error}');
                      }
                      return const Center(child: CircularProgressIndicator());
                    },
                  ))
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  _addService(data) {
    showModalBottomSheet(
        context: context,
        builder: (context) {
          return StatefulBuilder(builder: (BuildContext context,
              StateSetter setState /*You can rename this!*/) {
            return Container(
              height: 400,
            );
          });
        });
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
