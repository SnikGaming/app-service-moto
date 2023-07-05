import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import 'home_test.dart';

class HomePageTest extends StatefulWidget {
  const HomePageTest({super.key});

  @override
  State<HomePageTest> createState() => _HomePageTestState();
}

class _HomePageTestState extends State<HomePageTest> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          //!: Contact
          final Uri _url = Uri(scheme: 'tel', path: '0334666651');
          if (!await launchUrl(_url)) {
            throw Exception('Could not launch $_url');
          }
        },
        child: const Icon(Icons.phone),
      ),
      body: Container(
        height: size.height,
        width: size.width,
        color: Colors.green,
        child: SingleChildScrollView(
          child: Stack(
            children: [
              Container(
                height: size.height,
                width: size.width,
                color: const Color.fromARGB(255, 120, 54, 244),
                child: Column(
                  //!: Icon
                  children: [
                    TextButton(onPressed: () {}, child: const Text('ada'))
                  ],
                ),
              ),
              Container(
                  margin: const EdgeInsets.only(top: 200),
                  height: size.height,
                  width: size.width,
                  decoration: const BoxDecoration(
                    color: Color.fromARGB(255, 255, 255, 255),
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(32),
                      topRight: Radius.circular(32),
                    ),
                  ),
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 20,
                      ),
                      Container(
                        height: 230,
                        width: size.width * .88,
                        decoration: BoxDecoration(
                          color: Colors.blue,
                          borderRadius: BorderRadius.circular(32),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      SizedBox(
                        height: 20,
                        width: 100,
                        child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemBuilder: (_, i) => Padding(
                                  padding: const EdgeInsets.all(3.0),
                                  child: Container(
                                    height: 20,
                                    width: 20,
                                    decoration: const BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: Colors.green),
                                  ),
                                )),
                      ),
                      Container(
                        width: size.width,
                        height: 100,
                        child: ListView.builder(
                          // physics: NeverScrollableScrollPhysics(),
                          scrollDirection: Axis.horizontal,
                          itemCount: 5,
                          itemBuilder: (context, index) => Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              decoration:
                                  const BoxDecoration(color: Colors.white),
                              child: const CusThemeSkeletonCategories(),
                            ),
                          ),
                        ),
                      ),
                      Flexible(
                        child: GridView.builder(
                          itemCount: 5,
                          gridDelegate:
                              const SliverGridDelegateWithMaxCrossAxisExtent(
                            mainAxisSpacing: 10,
                            crossAxisSpacing: 10,
                            childAspectRatio: .6,
                            maxCrossAxisExtent: 200,
                          ),
                          itemBuilder: (_, i) =>
                              const CusThemeSkeletonProducts(),
                        ),
                      ),
                    ],
                  )),
            ],
          ),
        ),
      ),
    );
  }
}
