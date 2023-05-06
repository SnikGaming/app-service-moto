import 'package:animated_toggle_switch/animated_toggle_switch.dart';
import 'package:app/components/animation/text.dart';
import 'package:app/components/button/mybutton.dart';
import 'package:app/constants/colors.dart';
import 'package:app/functions/random_color.dart';
import 'package:app/modules/app_constants.dart';
import 'package:app/modules/home/api/category/api_category.dart';
import 'package:app/modules/home/layouts/pages/services_page.dart';
import 'package:app/modules/home/layouts/search_screen.dart';
import 'package:app/preferences/settings/setting_prefer.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:fluid_dialog/fluid_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:pagination_flutter/pagination.dart';
import '../../../../components/functions/logout.dart';
import '../../../../components/slider/slider.dart';
import '../../../../components/style/textstyle.dart';
import '../../../../network/api/google/google.dart';
import '../../../../network/connect.dart';
import '../../../../preferences/product/product.dart';
import '../../../../preferences/user/user_preferences.dart';
import '../../../TermsOfService/content.dart';
import 'package:badges/badges.dart' as badges;
import '../../api/category/models/category.dart' as categories;
import '../../api/products/api_product.dart';
import '../../api/products/models/products.dart' as products;

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  final _scrollController = ScrollController();
  var indexData = 0;
  var totalPage = 0;
  int page = 1;
  List<products.Data> productData = [];
  List<categories.Data> categoryData = [];
  scrollData() {
    _scrollController.animateTo(
      0,
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeInOut,
    );
  }

  loadData() async {
    productData =
        await APIProduct.getData(category_id: indexData + 1, page: page);
    categoryData = await APICategory.getData();
    totalPage = ProductPrefer.getTotal()!;
    setState(() {});
  }

  @override
  void dispose() {
    _animationController.dispose();
    // ignore: todo
    _scrollController.dispose();
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

  @override
  void initState() {
    // ignore: todo
    // TODO: implement initState
    super.initState();
    isCheck = SettingPrefer.getLightDark() ?? true;
    loadData();
    _scrollController.addListener(() {
      // if (_scrollController.offset > 0) {
      //   setState(() {
      //     print('data ____ ${_scrollController.offset}');
      //   });
      // } else {
      //   setState(() {
      //     print('data ____ ${_scrollController.offset}');
      //   });
      // }
    });
    _animationController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 500));
    // _animationColor = Tween<Color>(begin: ).animate(_animationController);
  }

  late bool isCheck;

  @override
  Widget build(BuildContext context) {
    // Future.delayed(Duration(seconds: 8)).then((value) => loadData());
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
    //?: Data products
    // var sliverList = SliverList(
    //     delegate: SliverChildBuilderDelegate(
    //   childCount: productData.length,
    //   (context, index) => ItemProduct(productData: productData),
    // ));
    var sliverList = SliverGrid.builder(
      itemCount: productData.length,
      gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
        maxCrossAxisExtent: 250,
        mainAxisSpacing: 10,
        crossAxisSpacing: 10,
        childAspectRatio: .5,
      ),
      itemBuilder: (context, index) => Padding(
        padding: EdgeInsets.only(
            left: index % 2 == 0 ? 16 : 0, right: index % 2 == 0 ? 0 : 16),
        child: ItemProduct(
          productData: productData,
          index: index,
        ),
      ),
    );

    return CustomScrollView(
      controller: _scrollController,
      slivers: [
        //!: Appbar
        SliverAppBar(
          elevation: 0,
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

        //!: Slider
        SliverToBoxAdapter(
          child: Container(
            color: SettingPrefer.getLightDark() == null ||
                    SettingPrefer.getLightDark()
                ? white
                : black,
            height: 200,
            child: const Padding(
              padding: EdgeInsets.only(top: 26, left: 10, right: 10),
              child: MySlider(),
            ),
          ),
        ),
        //? Category
        SliverPadding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
          sliver: SliverGrid.builder(
            itemCount: categoryData.length,
            gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
              maxCrossAxisExtent: 90,
              mainAxisSpacing: 10,
              crossAxisSpacing: 10,
              childAspectRatio: 1.0,
            ),
            itemBuilder: (context, index) => GestureDetector(
              onTap: () async {
                indexData = index;
                page = 1;

                productData = await APIProduct.getData(
                    category_id: indexData + 1, page: page);
                totalPage = ProductPrefer.getTotal()!;
                setState(() {});
              },
              child: Container(
                decoration: BoxDecoration(
                  color: indexData == index
                      ? const Color.fromARGB(255, 85, 34, 225)
                      : const Color.fromARGB(255, 148, 142, 142),
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: indexData == index
                          ? const Color.fromARGB(255, 143, 90, 240)
                          : Colors.grey,
                      spreadRadius: 4,
                      blurRadius: 7,
                      offset: const Offset(1, 3), // changes position of shadow
                    ),
                  ],
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CachedNetworkImage(
                      imageUrl: '${ConnectDb.url}${categoryData[index].image}',
                      color: indexData == index ? white : black,
                      height: 45,
                      placeholder: (context, url) =>
                          const CircularProgressIndicator(),
                      errorWidget: (context, url, error) => const Icon(Icons.error),
                    ),
                    Text(
                      '${categoryData[index].name}',
                      style: TextStyle(
                          color: indexData == index ? white : black,
                          fontSize: 14,
                          fontWeight: indexData == index
                              ? FontWeight.w400
                              : FontWeight.w600,
                          letterSpacing: 1),
                    )
                  ],
                ),
              ),
            ),
          ),
        ),

        //!: Data product
        productData.isEmpty
            ? const SliverToBoxAdapter(
                child: Center(
                  child: CircularProgressIndicator(),
                ),
              )
            : sliverList,
        const SliverToBoxAdapter(
          child: SizedBox(
            height: 40,
          ),
        ),

        //?: page
        SliverToBoxAdapter(
          child: productData.isEmpty
              ? Container()
              : Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Pagination(
                      numOfPages: ProductPrefer.getTotal()!,
                      selectedPage: page,
                      pagesVisible: 3,
                      spacing: 10,
                      onPageChanged: (value) {
                        scrollData();
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
                            MaterialStateProperty.all(Colors.black),
                        shape: MaterialStateProperty.all(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(38),
                          ),
                        ),
                      ),
                      inactiveBtnStyle: ButtonStyle(
                        shape: MaterialStateProperty.all(RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(38),
                        )),
                      ),
                      inactiveTextStyle: const TextStyle(
                        fontSize: 14,
                        color: Colors.black,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        GestureDetector(
                          onTap: () => setState(() {
                            scrollData();
                            page = 1;
                            loadData();
                          }),
                          child: Container(
                            decoration: BoxDecoration(
                              color: randomColor(),
                            ),
                            height: 30,
                            width: 100,
                            child: const Center(
                                child: Text(
                              'Đầu trang',
                              style: h1,
                            )),
                          ),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              scrollData();
                              page = totalPage;
                              loadData();
                            });
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              color: randomColor(),
                            ),
                            height: 30,
                            width: 100,
                            child: const Center(
                                child: Text(
                              'Cuối trang',
                              style: h1,
                            )),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
        ),

        //?:footer
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

class ItemProduct extends StatelessWidget {
  const ItemProduct({
    super.key,
    required this.productData,
    required this.index,
  });
  final int index;
  final List<products.Data> productData;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Modular.to.pushNamed(Routes.details, arguments: productData[index]);
        // serviceDetail(context, size, productData[index]);
      },
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
              height: 300,
              width: 250,
              child: Column(
                children: [
                  Expanded(
                      flex: 2,
                      child: Padding(
                        padding: const EdgeInsets.all(10),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(20),
                          child: Container(
                            decoration: const BoxDecoration(
                                // color: Colors.red,
                                image: DecorationImage(
                                    image: NetworkImage(
                                        'https://shop2banh.vn/images/thumbs/2020/05/bao-tay-ariete-chinh-hang-25ssf-products-1076.jpg'),
                                    fit: BoxFit.cover)),
                          ),
                        ),
                      )),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(left: 16, right: 16),
                      child: Column(
                        children: [
                          SizedBox(
                            width: MediaQuery.of(context).size.width,
                            child: Text(
                              productData[index].name!.length > 45
                                  ? '${productData[index].name!.substring(0, 45)}...'
                                  : productData[index].name!,
                              textAlign: TextAlign.left, // căn lề trái
                              style: MyTextStyle.title.copyWith(
                                letterSpacing: 0,
                                fontWeight: FontWeight.w700,
                                fontSize: 14,
                                color: SettingPrefer.getLightDark() == null ||
                                        SettingPrefer.getLightDark()
                                    ? black
                                    : white,
                              ),
                            ),
                          ),
                          const SizedBox(height: 8),
                          Row(
                            children: [
                              const Icon(
                                Icons.favorite,
                                color: Colors.red,
                                size: 14,
                              ),
                              Text(
                                '${productData[index].like}',
                                style: MyTextStyle.normal
                                    .copyWith(fontSize: 12)
                                    .copyWith(color: Colors.red),
                              ),
                            ],
                          ),
                          const Spacer(),
                          Row(
                            children: [
                              Text('Giá : ',
                                  style: MyTextStyle.normal.copyWith(
                                    color: Colors.red,
                                    fontSize: 18,
                                  )),
                              Container(
                                padding: const EdgeInsetsDirectional.all(3),
                                color: Colors.black,
                                child: Text('${productData[index].price}',
                                    style: MyTextStyle.normal.copyWith(
                                      color: Colors.yellow,
                                      fontSize: 18,
                                    )),
                              ),
                            ],
                          ),
                          const SizedBox(height: 10),
                        ],
                      ),
                    ),
                  ),
                ],
              )),
        ),
      ),
    );
  }
}
