import 'dart:math';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:animated_toggle_switch/animated_toggle_switch.dart';
import 'package:app/components/animation/text.dart';
import 'package:app/components/button/mybutton.dart';
import 'package:app/components/message/message.dart';
import 'package:app/constants/colors.dart';
import 'package:app/modules/app_constants.dart';
import 'package:app/modules/home/layouts/pages/services_page.dart';
import 'package:app/modules/home/layouts/search_screen.dart';
import 'package:app/preferences/settings/setting_prefer.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import '../../../../components/functions/logout.dart';
import '../../../../components/slider/slider.dart';
import '../../../../components/style/textstyle.dart';
import '../../../../models/categories/categories.dart';
import '../../../../models/products/products_model.dart';
import '../../../../models/products/provider_products.dart';
import '../../../../network/api/google/google.dart';
import '../../../../preferences/user/user_preferences.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;

  static final lstCategories = Categories.lst;
  var indexLstCategories = lstCategories[0];
  var indexData = 0;

  @override
  void dispose() {
    _animationController.dispose();
    // ignore: todo
    // TODO: implement dispose
    super.dispose();
  }

  List<ProductModel> lstProducts = [];
  getProducts() async {
    final data = await ProductService.getAllProduct();
    setState(() {});
    lstProducts = data;
    // print(lstProducts[0].productName.toString() + '-----------');
  }

  @override
  void initState() {
    // ignore: todo
    // TODO: implement initState
    super.initState();
    getProducts();
    isCheck = SettingPrefer.getLightDark() ?? true;
    // print(isCheck);
    // print(SettingPrefer.getLightDark());

    _animationController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 500));
    // _animationColor = Tween<Color>(begin: ).animate(_animationController);
  }

  late bool isCheck;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor:
          SettingPrefer.getLightDark() == null || SettingPrefer.getLightDark()
              ? white
              : black,
      drawer: _drawer(context),
      body: _customScrollview(context, size),
    );
  }

  CustomScrollView _customScrollview(BuildContext context, size) {
    return CustomScrollView(
      slivers: [
        //!: Appbar
        SliverAppBar(
          elevation: 0,
          // automaticallyImplyLeading: true,
          // excludeHeaderSemantics: true,
          forceElevated: true,
          floating: true,
          foregroundColor: white,
          backgroundColor: appbarColors,
          pinned: false,
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

          centerTitle: true,
          // collapsedHeight: 100,
          expandedHeight: 180.0,
          flexibleSpace: FlexibleSpaceBar(
            // title: const Text('SNIK'),
            background: Image.asset(
              'assets/logo/SNIK.png',
              fit: BoxFit.cover,
            ),
          ),
        ),
        //!: Border
        // SliverToBoxAdapter(
        //   child: Container(
        //     color: appbarColors,
        //     // color: const Color(0xff00396B),
        //     height: 30,
        //     child: Column(
        //       mainAxisAlignment: MainAxisAlignment.end,
        //       children: <Widget>[
        //         Container(
        //           height: 30,
        //           decoration: BoxDecoration(
        //             // color: Colors.white,
        //             color: isCheck ? white : black, //Color(0xff303030),
        //             borderRadius: const BorderRadius.only(
        //               topLeft: Radius.circular(40),
        //               topRight: Radius.circular(40),
        //             ),
        //           ),
        //         ),
        //       ],
        //     ),
        //   ),
        // ),
        // SliverToBoxAdapter(
        //   child: Container(
        //     height: 20,
        //     color: SettingPrefer.getLightDark() == null ||
        //             SettingPrefer.getLightDark()
        //         ? white
        //         : black,
        //   ),
        // ),

        //!: Slider
        SliverToBoxAdapter(
          child: Container(
            color: SettingPrefer.getLightDark() == null ||
                    SettingPrefer.getLightDark()
                ? white
                : black,
            height: 200,
            child: MySlider(),
          ),
        ),
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Container(
                height: 60,
                color: const Color.fromARGB(0, 255, 255, 255),
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
                                      border: indexLstCategories !=
                                              lstCategories[index]
                                          ? Border.all(
                                              width: 1,
                                              color: isCheck ? black : red)
                                          : null,
                                      borderRadius: BorderRadius.circular(30),
                                      color: indexLstCategories ==
                                              lstCategories[index]
                                          ? Colors.green
                                          : white),
                                  constraints:
                                      const BoxConstraints(minWidth: 100),
                                  child: Center(
                                    child: Text(
                                      lstCategories[index].name,
                                      style: TextStyle(
                                          color: indexLstCategories ==
                                                  lstCategories[index]
                                              ? white
                                              : black,
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
        //!: List Content
        SliverGrid.builder(
            itemCount: lstProducts.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              mainAxisSpacing: 16,
              crossAxisSpacing: 16,
              mainAxisExtent: 340,
              // childAspectRatio: 2,
              crossAxisCount: 2,
            ),
            itemBuilder: (_, i) => Padding(
                  padding: EdgeInsets.only(
                      left: i % 2 == 0 ? 16 : 0, right: i % 2 != 0 ? 16 : 0),
                  child: Container(
                    height: 100,
                    decoration: BoxDecoration(
                      // color: lsColor[Random().nextInt(lsColor.length)],
                      color: SettingPrefer.getLightDark() == null ||
                              SettingPrefer.getLightDark()
                          ? white
                          : black,
                      borderRadius: BorderRadius.circular(20),
                      // ignore: prefer_const_literals_to_create_immutables
                      boxShadow: [
                        const BoxShadow(
                            color: Colors.grey,
                            offset: Offset(6, 6),
                            blurRadius: 16)
                      ],
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 6),
                      child: Column(
                        // fit: StackFit.passthrough,
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const SizedBox(height: 10),
                          ClipRRect(
                            borderRadius: BorderRadius.circular(20),
                            child: Container(
                              height: 150,
                              width: 160,
                              color: lsColor[Random().nextInt(lsColor.length)],
                            ),
                          ),
                          const Spacer(),
                          Padding(
                            padding: const EdgeInsets.only(left: 10),
                            child: SizedBox(
                                width: 160,
                                child: Text(
                                  '${lstProducts[i].productName}',
                                  overflow: TextOverflow.ellipsis,
                                  style: MyTextStyle.title.copyWith(
                                      color: SettingPrefer.getLightDark() ==
                                                  null ||
                                              SettingPrefer.getLightDark()
                                          ? black
                                          : white),
                                )),
                          ),
                          const SizedBox(height: 10),
                          SizedBox(
                              width: 160,
                              child: Text(
                                '${lstProducts[i].price}',
                                style: MyTextStyle.title
                                    .copyWith(color: Colors.red),
                              )),
                          const SizedBox(height: 10),
                          SizedBox(
                              height: 100,
                              width: 160,
                              // color: Colors.white,
                              child: Text(
                                '${lstProducts[i].description}',
                                // softWrap: true,
                                overflow: TextOverflow.clip,
                                style: MyTextStyle.normal.copyWith(
                                    color:
                                        SettingPrefer.getLightDark() == null ||
                                                SettingPrefer.getLightDark()
                                            ? black
                                            : white),
                              )),
                          const SizedBox(height: 8),
                        ],
                      ),
                    ),
                  ),
                )),
        _footer(size)
      ],
    );
  }

  SliverToBoxAdapter _footer(size) {
    return SliverToBoxAdapter(
      child: Container(
        height: 250,
        color:
            SettingPrefer.getLightDark() == null || SettingPrefer.getLightDark()
                ? white
                : black,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            MyTextAnimated.Colorize(animatedTexts: [
              MyTextAnimated.itemColorize('SNIK'),
              MyTextAnimated.itemColorize('REPAIR'),
              MyTextAnimated.itemColorize('BOOKING'),
              MyTextAnimated.itemColorize('ADVISE'),
              MyTextAnimated.itemColorize('QUICK RESISTANCE'),
            ]),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Container(
                alignment: Alignment.center,
                width: size.width,
                child: const Text(
                    textAlign: TextAlign.center,
                    'Above is the reference price from SNIK, please book an appointment for consultation.'),
              ),
            )
          ],
        ),
      ),
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
                    height: 80,
                    width: 80,
                    decoration: UserPrefer.getImageUser() != null
                        ? BoxDecoration(
                            shape: BoxShape.circle,
                            image: DecorationImage(
                                image: NetworkImage(UserPrefer.getImageUser()),
                                fit: BoxFit.cover))
                        : const BoxDecoration(
                            image: DecorationImage(
                                image: AssetImage(
                                    'assets/icons/user/user_profile.png'),
                                fit: BoxFit.cover)),
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  Text(
                    UserPrefer.getsetUserName() ?? 'Trần Thới Long',
                    style: const TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 18,
                        overflow: TextOverflow.ellipsis,
                        letterSpacing: 2),
                  ),
                ],
              ),
            ),
          ),
          UserPrefer.getToken() == null
              ? ListTile(
                  title: const Text('Login'),
                  onTap: () {
                    Modular.to.pushNamed(Routes.login);
                  },
                )
              : ListTile(
                  title: const Text('Logout'),
                  onTap: () {
                    AuthWithGoogle.googleSignOutMethod(context)
                        .then((value) => Modular.to.navigate(Routes.home));
                    LogoutApp.Logout();
                    Future.delayed(const Duration(seconds: 1))
                        .then((value) => {setState(() {})});
                  },
                ),
          ListTile(
            title: const Text('Item 2'),
            onTap: () {
              Navigator.pop(context);
            },
          ),
          const SizedBox(
            height: 340,
          ),
          _darkLight(),
        ],
      ),
    );
  }

  Padding _darkLight() {
    return Padding(
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
            ? const Icon(Icons.coronavirus_rounded)
            : const Icon(Icons.tag_faces_rounded),
        textBuilder: (value) => value
            ? const Center(child: Text('Oh no...'))
            : const Center(child: Text('Nice :)')),
      ),
    );
  }
}
