import 'dart:math';
import 'package:animated_toggle_switch/animated_toggle_switch.dart';
import 'package:app/components/animation/text.dart';
import 'package:app/components/button/mybutton.dart';
import 'package:app/constants/colors.dart';
import 'package:app/models/services/service_model.dart';
import 'package:app/modules/app_constants.dart';
import 'package:app/modules/details/routes/details_routes.dart';
import 'package:app/modules/home/layouts/pages/services_page.dart';
import 'package:app/modules/home/layouts/search_screen.dart';
import 'package:app/preferences/settings/setting_prefer.dart';
import 'package:fluid_dialog/fluid_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_rating_stars/flutter_rating_stars.dart';
import '../../../../components/functions/logout.dart';
import '../../../../components/slider/slider.dart';
import '../../../../components/style/textstyle.dart';
import '../../../../models/categories/categories.dart';
import '../../../../models/data/model_data.dart';
import '../../../../models/data/provider.dart';
import '../../../../models/products/products_model.dart';
import '../../../../models/products/provider_products.dart';
import '../../../../models/services/provider_service.dart';
import '../../../../network/api/google/google.dart';
import '../../../../preferences/user/user_preferences.dart';
import '../../../TermsOfService/content.dart';
import 'package:badges/badges.dart' as badges;

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;

  static final lstCategories = Categories.lst;

  var indexData = 0;

  @override
  void dispose() {
    _animationController.dispose();
    // ignore: todo
    // TODO: implement dispose
    super.dispose();
  }

  List<String> items = [
    "Apple",
    "Banana",
    "Cherry",
    "Durian",
    "Eggfruit",
    "Fig",
    "Grapes",
    "Honeydew",
    "Jackfruit",
    "Kiwi",
    "Lemon",
    "Mango",
    "Nectarine",
    "Orange",
    "Pineapple",
    "Quince",
    "Raspberry",
    "Strawberry",
    "Tangerine",
    "Ugli fruit",
    "Vanilla bean",
    "Watermelon",
    "Xigua",
    "Yellow watermelon",
    "Zucchini",
  ];
  double value = 3.5;
  List<ProductData> lsDataTest = [];

  List<ProductModel> lstProducts = [];
  List<ServiceModel> lsService = [];
  getProducts() async {
    final data = await ProductService.getAllProduct();
    final dataService = await ProviderService.getAllService();

    final dataTest = await ProviderServices.getAllProduct();
    setState(() {});
    lsDataTest = dataTest;
    lstProducts = data;
    lsService = dataService;
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
    var sliverGrid = SliverGrid.builder(
        itemCount: lsDataTest.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          mainAxisSpacing: 16,
          crossAxisSpacing: 16,
          mainAxisExtent: 450,
          // childAspectRatio: 2,
          crossAxisCount: 2,
        ),
        itemBuilder: (_, i) => GestureDetector(
              onTap: () {
                Modular.to.pushNamed(Routes.details + DetailsRoute.product,
                    arguments: lstProducts[i]);
              },
              child: Padding(
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
                            height: 220,
                            width: 160,
                            decoration: BoxDecoration(
                              color: lsColor[Random().nextInt(lsColor.length)],
                              image: DecorationImage(
                                image: NetworkImage('${lsDataTest[i].src}'),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 20, left: 10),
                          child: SizedBox(
                            width: 160,
                            child: Text(
                              '${lsDataTest[i].title}',
                              style: h1.copyWith(
                                  color: SettingPrefer.getLightDark() == null ||
                                          SettingPrefer.getLightDark()
                                      ? black
                                      : white),
                            ),
                          ),
                        ),
                        const SizedBox(height: 10),
                        SizedBox(
                            width: 160,
                            child: Text(
                              '${lsDataTest[i].price}',
                              overflow: TextOverflow.visible,
                              style: subTitle.copyWith(
                                  fontSize: 16, color: Colors.red),
                            )),
                        const SizedBox(
                          height: 10,
                        ),
                        Container(
                          width: 160,
                          alignment: Alignment.center,
                          child: Row(
                            children: List.generate(
                              5,
                              (i) => Icon(Icons.star),
                            ),
                          ),
                        ),
                        const Spacer()
                      ],
                    ),
                  ),
                ),
              ),
            ));
    var sliverList = SliverList(
        delegate: SliverChildBuilderDelegate(
      childCount: lsService.length,
      (context, index) => GestureDetector(
        onTap: () {
          Modular.to.pushNamed(Routes.details, arguments: lsService[index]);
          // serviceDetail(context, size, lsService[index]);
        },
        child: Padding(
          padding:
              EdgeInsets.only(top: index == 0 ? 0 : 16, left: 16, right: 16),
          child: Container(
            decoration: const BoxDecoration(boxShadow: [
              BoxShadow(
                color: Colors.grey,
                offset: Offset(3, 3),
                blurRadius: 16,
              )
            ]),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Container(
                color: SettingPrefer.getLightDark() == null ||
                        SettingPrefer.getLightDark()
                    ? white
                    : black,
                // color: lsColor[Random().nextInt(lsColor.length)],
                height: 200,
                width: size.width,
                child: Row(
                  children: [
                    Expanded(
                        child: Padding(
                      padding: const EdgeInsets.all(10),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: Container(
                          color: Colors.red,
                        ),
                      ),
                    )),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(right: 16),
                        child: Column(
                          children: [
                            const SizedBox(
                              height: 20,
                            ),
                            Text(
                              textAlign: TextAlign.center,
                              lsService[index].name,
                              style: MyTextStyle.title.copyWith(
                                fontSize: 18,
                                color: SettingPrefer.getLightDark() == null ||
                                        SettingPrefer.getLightDark()
                                    ? black
                                    : white,
                              ),
                            ),
                            Text(lsService[index].price,
                                style: MyTextStyle.normal.copyWith(
                                  color: Colors.red,
                                  fontSize: 18,
                                )),
                            Text(
                              lsService[index].shortDescription,
                              style: MyTextStyle.normal.copyWith(
                                fontSize: 14,
                                color: SettingPrefer.getLightDark() == null ||
                                        SettingPrefer.getLightDark()
                                    ? black
                                    : white,
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
                            Text(
                              lsService[index].benefit,
                              style: MyTextStyle.normal.copyWith(
                                fontSize: 14,
                                color: SettingPrefer.getLightDark() == null ||
                                        SettingPrefer.getLightDark()
                                    ? black
                                    : white,
                              ),
                              overflow: TextOverflow.ellipsis,
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
        ),
      ),
    ));
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
                Modular.to.pushNamed(Routes.notifications);
              },
              icon: const badges.Badge(
                badgeContent: Text('3'),
                child: Icon(Icons.notifications),
              ),
            ),
            IconButton(
                onPressed: () {
                  showSearch(
                    context: context,
                    delegate: MySearchDelegate(items: items),
                  );
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
                                indexData = index;
                                // indexLstCategories = lstCategories[index];
                                setState(() {});
                              },
                              child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 10),
                                child: Container(
                                  height: 40,
                                  decoration: BoxDecoration(
                                      border: indexData != index
                                          ? Border.all(
                                              width: 1,
                                              color: isCheck ? black : red)
                                          : null,
                                      borderRadius: BorderRadius.circular(30),
                                      color: indexData == index
                                          ? Colors.green
                                          : white),
                                  constraints:
                                      const BoxConstraints(minWidth: 100),
                                  child: Center(
                                    child: Text(
                                      lstCategories[index].name,
                                      style: TextStyle(
                                          color: indexData == index
                                              ? white
                                              : black,
                                          fontSize: 14,
                                          fontWeight: indexData == index
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
        indexData == 0 ? sliverList : sliverGrid,
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
              onTap: () {
                setState(() {});
                Modular.to.pushNamed(Routes.profile);
              },
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
                    UserPrefer.getsetUserName() ?? 'GUEST',
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
          ListTile(
            leading: const Icon(
              Icons.attach_money,
              color: Colors.green,
            ), //Image.asset('assets/icons/user/bill.png', height: 45),
            title: const Text('Bill history'),
            onTap: () {},
          ),
          ListTile(
            leading: const Icon(
              Icons.calendar_month_outlined,
              color: Colors.blue,
            ),
            //leading: Image.asset('assets/icons/user/booking.png', height: 45),
            title: const Text('Booking history'),
            onTap: () {},
          ),

          UserPrefer.getToken() == null
              ? ListTile(
                  leading: const Icon(
                    Icons.login,
                    color: Colors.purple,
                  ),
                  // leading: Image.asset('assets/appbar/login.png', height: 45),
                  title: const Text('Login'),
                  onTap: () {
                    Modular.to.pushNamed(Routes.login);
                  },
                )
              : ListTile(
                  leading: const Icon(
                    Icons.logout_outlined,
                    color: Colors.red,
                  ),
                  // leading: Image.asset('assets/appbar/logout.png', height: 45),
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
            title: const Text('Terms of service'),
            leading: const Icon(
              Icons.info_outline_rounded,
              color: Colors.blue,
            ),
            // leading:
            //     Image.asset('assets/icons/user/information.png', height: 45),
            onTap: () {
              showDialog(
                context: context,
                builder: (context) => FluidDialog(
                  defaultDecoration: BoxDecoration(
                    color: SettingPrefer.getLightDark() == null ||
                            SettingPrefer.getLightDark()
                        ? white
                        : black,
                  ),
                  rootPage: FluidDialogPage(
                    alignment: Alignment.bottomLeft,
                    builder: (context) => const TestDialog(),
                  ),
                ),
              );
            },
          ),
          const SizedBox(
            height: 210,
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
