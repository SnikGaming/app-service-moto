import 'package:animated_toggle_switch/animated_toggle_switch.dart';
import 'package:app/components/animation/text.dart';
import 'package:app/components/button/mybutton.dart';
import 'package:app/components/message/message.dart';
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
import '../../../../components/convert/format_money.dart';
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
import '../../api/login/api_login.dart';
import '../../api/products/api_product.dart';
import '../../api/products/models/products.dart' as products;
import '../../api/login/model.dart' as users;
import '../common/skeleton_home.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  final _scrollController = ScrollController();
  bool isProfile = false;
  var indexData = 0;
  var totalPage = 0;
  String username = UserPrefer.getsetUserName() ?? 'GUEST';
  int page = 1;
  List<products.Data> productData = [];
  List<categories.Data> categoryData = [];
  users.Data user = users.Data();
  scrollData() {
    _scrollController.animateTo(
      0,
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeInOut,
    );
  }

  loadData() async {
    final productDataFuture =
        APIProduct.getData(category_id: indexData + 1, page: page);
    final categoryDataFuture = APICategory.getData();
    List<dynamic> results =
        await Future.wait([productDataFuture, categoryDataFuture]);
    productData = results[0];
    categoryData = results[1];
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
    username = UserPrefer.getsetUserName() ?? 'GUEST';
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
            itemCount: APICategory.apiCategory.length,
            gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
              maxCrossAxisExtent: 90,
              mainAxisSpacing: 10,
              crossAxisSpacing: 10,
              childAspectRatio: 1.0,
            ),
            itemBuilder: (context, index) => GestureDetector(
              onTap: () async {
                setState(() {
                  productData = [];
                  indexData = index;
                  page = 1;
                  loadData();
                });
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
                      imageUrl:
                          '${ConnectDb.url}${APICategory.apiCategory[index].image}',
                      color: indexData == index ? white : black,
                      height: 45,
                      placeholder: (context, url) =>
                          const CircularProgressIndicator(),
                      errorWidget: (context, url, error) =>
                          const Icon(Icons.error),
                    ),
                    Text(
                      '${APICategory.apiCategory[index].name}',
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

        // SliverToBoxAdapter(
        //   child: SkelatonHome(),
        // ),
        //!: Data product
        productData.isEmpty
            ? const SliverToBoxAdapter(child: SkelatonHome())
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
                    const SizedBox(height: 10),
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
                              borderRadius: BorderRadius.circular(16),
                            ),
                            height: 30,
                            width: 100,
                            child: Center(
                                child: Text(
                              'Đầu trang',
                              style: h1.copyWith(color: Colors.white),
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
                              borderRadius: BorderRadius.circular(16),
                            ),
                            height: 30,
                            width: 100,
                            child: Center(
                                child: Text(
                              'Cuối trang',
                              style: h1.copyWith(color: Colors.white),
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
              onTap: () async {
                if (!isProfile) {
                  isProfile = true;
                  try {
                    user = (await APIAuth.getUser())!;
                    Modular.to.pushNamed(Routes.profile,
                        arguments: [user]).then((value) => isProfile = false);
                  } catch (e) {
                    Message.warning(
                        message: 'Bạn chưa đăng nhập', context: context);
                  }
                  Future.delayed(const Duration(seconds: 5))
                      .then((value) => isProfile = false);
                }
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
                    username,
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
            ),
            title: const Text('Bill history'),
            onTap: () {},
          ),
          ListTile(
            leading: const Icon(
              Icons.calendar_month_outlined,
              color: Colors.blue,
            ),
            title: const Text('Booking history'),
            onTap: () {},
          ),

          UserPrefer.getToken() == null
              ? ListTile(
                  leading: const Icon(
                    Icons.login,
                    color: Colors.purple,
                  ),
                  title: const Text('Login'),
                  onTap: () {
                    Modular.to.pushNamed(Routes.login).then((value) {
                      Navigator.pop(context);

                      setState(() {});
                    });
                  },
                )
              : ListTile(
                  leading: const Icon(
                    Icons.logout_outlined,
                    color: Colors.red,
                  ),
                  title: const Text('Logout'),
                  onTap: () {
                    AuthWithGoogle.googleSignOutMethod(context)
                        .then((value) => Modular.to.navigate(Routes.home));
                    LogoutApp.Logout();

                    setState(() {});
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
                            decoration: const BoxDecoration(),
                            child: CachedNetworkImage(
                              imageUrl:
                                  '${ConnectDb.url}${productData[index].image}',
                              fit: BoxFit.cover,
                              placeholder: (context, url) => const Center(
                                  child: CircularProgressIndicator()),
                              errorWidget: (context, url, error) =>
                                  const Icon(Icons.error),
                            ),
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
                          Container(
                            alignment: Alignment.centerLeft,
                            child: Text('Giá : ',
                                textAlign: TextAlign.left,
                                style: MyTextStyle.normal.copyWith(
                                  color: Colors.red,
                                  fontSize: 16,
                                )),
                          ),
                          const SizedBox(height: 8),
                          Container(
                            padding: const EdgeInsetsDirectional.all(3),
                            color: Colors.black,
                            child: Text(
                                formatCurrency(
                                    amount: '${productData[index].price}'),
                                style: MyTextStyle.normal.copyWith(
                                  color: Colors.yellow,
                                  fontSize: 16,
                                )),
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
