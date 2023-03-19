
import 'package:app/components/button/mybutton.dart';
import 'package:app/constants/colors.dart';
import 'package:app/constants/list_image_slider.dart';
import 'package:app/modules/app_constants.dart';
import 'package:app/modules/home/layouts/search_screen.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final imageSliders = ListImageLocal.lst
      .map((item) => Container(
            margin: const EdgeInsets.all(5.0),
            child: ClipRRect(
                borderRadius: const BorderRadius.all(Radius.circular(5.0)),
                child: Stack(
                  children: <Widget>[
                    Image.network(item, fit: BoxFit.cover, width: 1000.0),
                    Positioned(
                      bottom: 0.0,
                      left: 0.0,
                      right: 0.0,
                      child: Container(
                        decoration: const BoxDecoration(
                          gradient: LinearGradient(
                            colors: [
                              Color.fromARGB(200, 0, 0, 0),
                              Color.fromARGB(0, 0, 0, 0)
                            ],
                            begin: Alignment.bottomCenter,
                            end: Alignment.topCenter,
                          ),
                        ),
                        padding: const EdgeInsets.symmetric(
                            vertical: 10.0, horizontal: 20.0),
                        child: Text(
                          'No. ${ListImageLocal.imgList.indexOf(item)} image',
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 20.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ],
                )),
          ))
      .toList();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: black,
      drawer: _drawer(context),
      body: _customScrollview(context),
    );
  }

  CustomScrollView _customScrollview(BuildContext context) {
    return CustomScrollView(
      slivers: [
        //!: Appbar
        SliverAppBar(
          elevation: 0,
          backgroundColor: appbarColors,
          pinned: !false,
          actions: [
            IconButton(
                onPressed: () {
                  showSearch(context: context, delegate: SearchCustom());
                },
                icon: const Icon(Icons.search))
          ],
          // leading: Icon(Icons.search),
          // forceElevated: false,
          snap: true,
          floating: true,
          centerTitle: true,
          // collapsedHeight: 100,
          expandedHeight: 180.0,
          flexibleSpace: FlexibleSpaceBar(
            title: const Text('SNIK'),
            background: Image.asset('assets/logo/logo_snik.png'),
          ),
        ),
        //!: Border
        SliverToBoxAdapter(
          child: Container(
            color: appbarColors,
            // color: const Color(0xff00396B),
            height: 30,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                Container(
                  height: 30,
                  decoration: const BoxDecoration(
                    // color: Colors.white,
                    color: black, //Color(0xff303030),
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(40),
                      topRight: Radius.circular(40),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        SliverToBoxAdapter(
          child: Container(
            height: 20,
            color: black,
          ),
        ),
        //!: Slider
        SliverToBoxAdapter(
          child: Container(
            color: black,
            height: 200,
            child: CarouselSlider(
              options: CarouselOptions(
                aspectRatio: 2.0,
                autoPlay: true,
                enlargeCenterPage: true,
                enlargeStrategy: CenterPageEnlargeStrategy.zoom,
                enlargeFactor: 0.4,
              ),
              items: imageSliders,
            ),
          ),
        ),
        SliverToBoxAdapter(
          child: Container(
            height: 60,
            color: black,
          ),
        ),
        //!: List
        SliverList(
          delegate: SliverChildBuilderDelegate(
            childCount: 100,
            (BuildContext context, int index) {
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  height: 160,
                  alignment: Alignment.center,
                  color: Colors.pink[100 * (index % 9)],
                  child: Text('list item $index'),
                ),
              );
            },
          ),
        )
      ],
    );
  }

  Drawer _drawer(BuildContext context) {
    return Drawer(
      backgroundColor: MyColors.lightGreen,
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          //!: DrawerHeader
          DrawerHeader(
            decoration: const BoxDecoration(
              color: Color.fromARGB(255, 176, 135, 236),
              // borderRadius: BorderRadius.only(topRight: Radius.circular(30)),
            ),
            child: GestureDetector(
              onTap: () => setState(() {}),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    height: 50,
                    width: 50,
                    decoration: const BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage(
                                'assets/icons/user/user_profile.png'),
                            fit: BoxFit.cover)),
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  const Text(
                    'Trần Thới Long',
                    style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 18,
                        letterSpacing: 2),
                  ),
                ],
              ),
            ),
          ),
          ListTile(
            title: const Text('Login'),
            onTap: () {
              Modular.to.pushNamed(Routes.login);
            },
          ),
          ListTile(
            title: const Text('Item 2'),
            onTap: () {
              Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  }
}
