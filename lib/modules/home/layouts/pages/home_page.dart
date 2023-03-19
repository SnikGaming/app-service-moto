import 'package:animated_toggle_switch/animated_toggle_switch.dart';
import 'package:app/components/button/mybutton.dart';
import 'package:app/components/message/message.dart';
import 'package:app/constants/colors.dart';
import 'package:app/constants/constants.dart';
import 'package:app/constants/list_image_slider.dart';
import 'package:app/modules/app_constants.dart';
import 'package:app/modules/home/layouts/search_screen.dart';
import 'package:app/preferences/settings/setting_prefer.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import '../../../../models/categories/categories.dart';
import '../../../../preferences/settings/setting_prefer.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

Rectangulo(index, _, color) {
  return GestureDetector(
    onTap: () {
      Message.success(message: '$index', context: _);
    },
    child: Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        height: 200,
        width: 200,
        // ignore: prefer_const_literals_to_create_immutables
        decoration: BoxDecoration(
            boxShadow: [
              const BoxShadow(
                  color: Colors.grey, offset: Offset(3, 6), blurRadius: 10)
            ],
            color: Colors.green.withAlpha(100),
            borderRadius: BorderRadius.circular(16)),
        child: Stack(
          children: [
            Positioned(
              top: 10,
              left: 10,
              child: Container(
                height: 100,
                width: 140,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    image: const DecorationImage(
                        image: NetworkImage(
                            'https://shop2banh.vn/images/thumbs/2023/02/bo-oc-dia-salaya-inox-8ly-cho-exciter-150-5con-products-2040.jpg'),
                        fit: BoxFit.cover)),
              ),
            ),
            Positioned(
                bottom: 25,
                left: 10,
                child: Container(
                  width: 140,
                  child: const Text(
                    'Bộ ốc đĩa Salaya inox 8ly cho Exciter 150 (5con)',
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                        color: black),
                  ),
                )),
            const Positioned(
                bottom: 5,
                left: 15,
                child: SizedBox(
                  width: 140,
                  child: Text(
                    '90.000 Vnđ',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                        color: Colors.red),
                  ),
                ))
          ],
        ),
      ),
    ),
  );
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _animation;
  late Animation<Color> _animationColor;
  static final lstCategories = Categories.lst;
  var indexLstCategories = lstCategories[0];
  var indexData = 0;
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
  void dispose() {
    _animationController.dispose();
    // TODO: implement dispose
    super.dispose();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    isCheck = SettingPrefer.getLightDark() ?? true;
    print(isCheck);
    print(SettingPrefer.getLightDark());

    _animationController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 500));
    _animation = Tween<double>(begin: 0, end: 1).animate(_animationController);
    // _animationColor = Tween<Color>(begin: ).animate(_animationController);
  }

  late bool isCheck;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:
          SettingPrefer.getLightDark() == null || SettingPrefer.getLightDark()
              ? white
              : black,
      drawer: _drawer(context),
      body: _customScrollview(context),
    );
  }

  CustomScrollView _customScrollview(BuildContext context) {
    List<Widget> items =
        List.generate(200, (index) => Rectangulo(index, context, Colors.red));
    List<Widget> items1 =
        List.generate(200, (index) => Rectangulo(index, context, Colors.blue));
    var data = [items, items1];
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
                  decoration: BoxDecoration(
                    // color: Colors.white,
                    color: isCheck ? white : black, //Color(0xff303030),
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
            color: SettingPrefer.getLightDark() == null ||
                    SettingPrefer.getLightDark()
                ? white
                : black,
          ),
        ),
        //!: Slider
        SliverToBoxAdapter(
          child: Container(
            color: SettingPrefer.getLightDark() == null ||
                    SettingPrefer.getLightDark()
                ? white
                : black,
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
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Container(
                height: 60,
                color: SettingPrefer.getLightDark() == null ||
                        SettingPrefer.getLightDark()
                    ? white
                    : black,
                child: Row(
                    children: List.generate(
                        lstCategories.length,
                        (index) => GestureDetector(
                              onTap: () {
                                indexData = index;
                                indexLstCategories = lstCategories[index];
                                setState(() {});
                              },
                              child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 10),
                                child: Container(
                                  height: 40,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(30),
                                      color: indexLstCategories ==
                                              lstCategories[index]
                                          ? Colors.red
                                          : Colors.green),
                                  constraints:
                                      const BoxConstraints(minWidth: 80),
                                  child: Center(
                                    child: Text(
                                      lstCategories[index].name,
                                      style: TextStyle(
                                          color: indexLstCategories ==
                                                  lstCategories[index]
                                              ? white
                                              : blue,
                                          fontSize: 14,
                                          fontWeight: indexLstCategories ==
                                                  lstCategories[index]
                                              ? FontWeight.w400
                                              : FontWeight.w600,
                                          letterSpacing: 1),
                                    ),
                                  ),
                                ),
                              ),
                            ))),
              ),
            ),
          ),
        ),
        //!: List

        SliverGrid.extent(
          maxCrossAxisExtent: 300,
          children: data[indexData],
        ),
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
          SizedBox(
            height: 340,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 50),
            child: AnimatedToggleSwitch<bool>.dual(
              current: SettingPrefer.getLightDark() ?? true,
              first: false,
              second: true,
              dif: 50.0,
              borderColor: Colors.transparent,
              borderWidth: 5.0,
              height: 55,
              boxShadow: const [
                BoxShadow(
                  color: Colors.black26,
                  spreadRadius: 1,
                  blurRadius: 2,
                  offset: Offset(0, 1.5),
                ),
              ],
              onChanged: (b) {
                SettingPrefer.setLightDark(value: b);

                setState(() {
                  isCheck = b;
                });
                // return Future.delayed(Duration(seconds: 2));
              },
              colorBuilder: (b) => b ? Colors.red : Colors.green,
              iconBuilder: (value) => value
                  ? Icon(Icons.coronavirus_rounded)
                  : Icon(Icons.tag_faces_rounded),
              textBuilder: (value) => value
                  ? Center(child: Text('Oh no...'))
                  : Center(child: Text('Nice :)')),
            ),
          ),
        ],
      ),
    );
  }
}
