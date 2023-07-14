// ignore_for_file: use_build_context_synchronously, depend_on_referenced_packages, no_logic_in_create_state

import 'package:animated_floating_buttons/widgets/animated_floating_action_button.dart';
import 'package:animated_toggle_switch/animated_toggle_switch.dart';
import 'package:app/components/animation/text.dart';
import 'package:app/components/button/mybutton.dart';
import 'package:app/components/message/message.dart';
import 'package:app/constants/colors.dart';
import 'package:app/functions/random_color.dart';
import 'package:app/modules/app_constants.dart';
import 'package:app/api/category/api_category.dart';
import 'package:app/modules/home/layouts/pages/skeleton.dart';
import 'package:app/modules/home/layouts/pages/services_page.dart';
import 'package:app/modules/home/layouts/search_screen.dart';
import 'package:app/preferences/settings/setting_prefer.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:fluid_dialog/fluid_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:lottie/lottie.dart';
import 'package:pagination_flutter/pagination.dart';
import '../../../../components/calendar/res/colors.dart';
import '../../../../components/convert/format_money.dart';
import '../../../../components/functions/logout.dart';
import '../../../../components/search/search.dart';
import '../../../../components/slider/slider.dart';
import '../../../../components/style/textstyle.dart';
import '../../../../components/value_app.dart';
import '../../../../network/api/google/google.dart';
import '../../../../network/connect.dart';
import '../../../../preferences/product/product.dart';
import '../../../../preferences/user/user_preferences.dart';
import '../../../TermsOfService/content.dart';
import 'package:badges/badges.dart' as badges;
import '../../../../api/category/models/category.dart' as categories;
import '../../../../api/login/api_login.dart';
import '../../../../api/products/api_product.dart';
import '../../../../api/products/models/products.dart' as products;
import '../../../../api/login/model.dart' as users;

import 'package:ionicons/ionicons.dart';
import 'package:url_launcher/url_launcher.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  final _scrollController = ScrollController();
  final GlobalKey<AnimatedFloatingActionButtonState> key =
      GlobalKey<AnimatedFloatingActionButtonState>();
  bool isLogin = false;
  bool isProfileOpen = false;

  String search = '';
  var indexData = 0;
  var totalPage = 0;
  String username = UserPrefer.getsetUserName() ?? 'Khách';
  int page = 1;
  List<products.Data> productData = [];
  List<categories.Data> categoryData = [];
  users.Data user = users.Data();
  void scrollData() {
    _scrollController.animateTo(
      0,
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeInOut,
    );
  }

  void _logout() {
    setState(() {
      LogoutApp.logout();
      AuthWithGoogle.googleSignOutMethod(context);
      isLogin = false;
      Modular.to.navigate(Routes.home);
    });
  }

  void _login() {
    Modular.to.pushNamed(Routes.login).then((value) => setState(() {
          isLogin = true;
          Navigator.pop(context);
        }));
  }

  void _opentProfile() async {
    // setState(() {});

    if (!isProfileOpen) {
      isProfileOpen = true;

      try {
        user = (await APIAuth.getUser())!;

        Modular.to.pushNamed(Routes.profile, arguments: [user]);
      } catch (e) {
        Message.warning(
          message: 'Bạn chưa đăng nhập',
          context: context,
        );
      }

      await Future.delayed(const Duration(seconds: 5));
      isProfileOpen = false;
    }
  }

  void loadData() async {
    final productDataFuture = APIProduct.getData(
        search: search, category_id: indexData + 1, page: page);
    final categoryDataFuture = APICategory.getData();
    List<dynamic> results =
        await Future.wait([productDataFuture, categoryDataFuture]);
    if (mounted) {
      setState(() {
        productData = results[0];
        categoryData = results[1];
        totalPage = ProductPrefer.getTotal()!;
      });
    }
  }

  @override
  void dispose() {
    _animationController.dispose();

    // ignore: todo
    _scrollController.dispose();

    super.dispose();
  }

  double value = 3.5;

  @override
  void initState() {
    // ignore: todo
    // TODO: implement initState
    super.initState();
    isCheck = SettingPrefer.getLightDark() ?? true;
    loadData();
    UserPrefer.getImageUser() != null ? isLogin = true : false;
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
  }

  late bool isCheck;
  Widget authAction() {
    return FloatingActionButton(
      onPressed: UserPrefer.getToken() == null ? _login : _logout,
      heroTag: "btn1",
      tooltip: UserPrefer.getToken() == null ? 'Đăng nhập' : 'Đăng xuất',
      child: UserPrefer.getToken() == null
          ? const Icon(Icons.login)
          : const Icon(Icons.logout_outlined),
    );
  }

  Widget callZalo() {
    return FloatingActionButton(
      onPressed: () async {
        final Uri url = Uri(scheme: 'tel', path: '0334666651');
        if (!await launchUrl(url)) {
          throw Exception('Could not launch $url');
        }
      },
      heroTag: "btn2",
      tooltip: 'Liên hệ',
      child: const Icon(Icons.phone),
    );
  }

  Widget teamsOfService() {
    return FloatingActionButton(
      onPressed: () => showDialog(
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
      ),
      heroTag: "btn3",
      tooltip: 'First button',
      child: const Icon(
        Icons.info_outline_rounded,
        color: Colors.blue,
      ),
    );
  }

  Widget userAction() {
    return FloatingActionButton(
      onPressed: _opentProfile,
      heroTag: "btn4",
      tooltip: 'Thông tin user',
      child: UserPrefer.getImageUser() != null && isLogin
          ? CachedNetworkImage(
              imageBuilder: (context, imageProvider) => CircleAvatar(
                  backgroundImage: NetworkImage(
                      '${ConnectDb.url}${UserPrefer.getImageUser()}')),
              fit: BoxFit.cover,
              placeholder: (context, url) =>
                  const Center(child: CircularProgressIndicator()),
              errorWidget: (context, url, error) => const Icon(Icons.error),
              imageUrl: '${ConnectDb.url}${UserPrefer.getImageUser()}',
            )
          : Container(
              height: 45,
              width: 45,
              decoration: const BoxDecoration(
                color: violet,
                shape: BoxShape.circle,
              ),
              child: Lottie.network(
                  'https://assets10.lottiefiles.com/packages/lf20_1mvhccet.json'),
            ),
    );
  }

  @override
  Widget build(BuildContext context) {
    username = UserPrefer.getsetUserName() ?? 'Khách';
    final size = MediaQuery.of(context).size;
    return Scaffold(
      floatingActionButton: AnimatedFloatingActionButton(
          //Fab list
          fabButtons: UserPrefer.getToken() == null
              ? <Widget>[authAction(), callZalo(), teamsOfService()]
              : <Widget>[
                  userAction(),
                  authAction(),
                  callZalo(),
                  teamsOfService()
                ],
          key: key,
          colorStartAnimation: violet,
          colorEndAnimation: Colors.red,
          animatedIconData: AnimatedIcons.menu_close //To principal button
          ),
      backgroundColor:
          SettingPrefer.getLightDark() == null || SettingPrefer.getLightDark()
              ? white
              : black,
      // drawer: _drawer(context),
      body: _customScrollview(context, size),
    );
  }

  CustomScrollView _customScrollview(BuildContext context, size) {
    //?: Data products

    var sliverProducts = SliverGrid.builder(
      itemCount: productData.length,
      gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
        maxCrossAxisExtent: 250,
        mainAxisSpacing: 10,
        crossAxisSpacing: 10,
        childAspectRatio: .53,
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

    var sliverSkeletonProducs = SliverGrid.builder(
      itemCount: 4,
      gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
        maxCrossAxisExtent: 250,
        mainAxisSpacing: 10,
        crossAxisSpacing: 10,
        childAspectRatio: .53,
      ),
      itemBuilder: (context, index) => Padding(
        padding: EdgeInsets.only(
            left: index % 2 == 0 ? 16 : 0, right: index % 2 == 0 ? 0 : 16),
        child: const CusThemeSkeletonProducts(),
      ),
    );

    var sliverCategories = SliverPadding(
      padding: const EdgeInsets.only(left: 10, right: 10, bottom: 20),
      sliver: SliverToBoxAdapter(
        child: SizedBox(
          height: 100,
          width: size.width,
          // color: Colors.red,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, i) => Padding(
              padding: EdgeInsets.only(
                  top: 10,
                  bottom: 20,
                  left: i % 2 == 0 ? 10 : 0,
                  right: i % 2 == 0
                      ? 10
                      : i == APICategory.apiCategory.length - 1
                          ? 10
                          : 0),
              child: categoriesItem(i),
            ),
            itemCount: APICategory.apiCategory.length,
          ),
        ),
      ),
    );
    var sliverSkeletonCategories = SliverPadding(
      padding: const EdgeInsets.only(left: 10, right: 10, bottom: 20),
      sliver: SliverToBoxAdapter(
        child: SizedBox(
          height: 100,
          width: size.width,
          // color: Colors.red,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, i) => Padding(
              padding: EdgeInsets.only(
                  top: 10,
                  bottom: 20,
                  left: i % 2 == 0 ? 10 : 0,
                  right: i % 2 == 0
                      ? 10
                      : i == 6 - 1
                          ? 10
                          : 0),
              child: const CusThemeSkeletonCategories(),
            ),
            itemCount: 6,
          ),
        ),
      ),
    );

    return CustomScrollView(
      controller: _scrollController,
      slivers: [
        //!: Appbar
        SliverAppBar(
          elevation: 0,
          floating: true,
          foregroundColor: Colors.white,
          backgroundColor: appbarColors,
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
              //!:Xử lý search
              onPressed: () async {
                // var data = await APIProduct.getData(
                //     category_id: 1, search: '', page: page);
                var data = await APIProduct.search(search: '');
                showSearch(
                  context: context,
                  delegate: MySearchDelegate(items: data),
                ).then((value) {
                  if (value != null) {
                    Modular.to.pushNamed(Routes.details, arguments: value.id);
                  }
                });
              },
              icon: const Icon(Icons.search),
            )
          ],
          expandedHeight: 180.0,
          flexibleSpace: FlexibleSpaceBar(
            background: Image.asset(
              'assets/logo/SNIK.png',
              fit: BoxFit.cover,
            ),
          ),
          title: const Text('SNIK'),
        ),

        //!: Slider
        SliverToBoxAdapter(
          child: Container(
            color: SettingPrefer.getLightDark() == null ||
                    SettingPrefer.getLightDark()
                ? white
                : black,
            height: 250,
            width: 300,
            child: const MySlider(),
          ),
        ),

        //!: Search
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.only(left: 16, right: 16, bottom: 16),
            child: MySearchBar(
              hintText: 'Tìm kiếm',
              onSearch: (value) => setState(() {
                indexData = 0;
                search = value;
                page = 1;
                loadData();
              }),
            ),
          ),
        ),
        //? SP Mới nhất
        false
            ? SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    children: [
                      SizedBox(
                        width: size.width,
                        child: const Text(
                          'Sản phẩm mới',
                          style: h1,
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Container(
                        height: 200,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (context, index) => ClipRRect(
                            borderRadius: BorderRadius.circular(16),
                            child: Padding(
                              padding:
                                  EdgeInsets.only(left: index == 0 ? 20 : 0),
                              child: Container(
                                width: 230,
                                color: Colors.green,
                              ),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              )
            : SliverToBoxAdapter(),
        //? Category
        APICategory.apiCategory.isEmpty
            ? sliverSkeletonCategories
            : sliverCategories,
        //!: Data product
        productData.isEmpty ? sliverSkeletonProducs : sliverProducts,
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

  GestureDetector categoriesItem(int index) {
    return GestureDetector(
      onTap: () async {
        search = '';
        setState(() {
          productData = [];
          indexData = index;
          page = 1;
          loadData();
        });
      },
      child: Container(
        width: 80,
        height: 80,
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
              height: 30,
              placeholder: (context, url) => const CircularProgressIndicator(),
              errorWidget: (context, url, error) => const Icon(Icons.error),
            ),
            const SizedBox(
              height: 4,
            ),
            Text(
              '${APICategory.apiCategory[index].name}',
              style: TextStyle(
                  color: indexData == index ? white : black,
                  fontSize: 12,
                  fontWeight:
                      indexData == index ? FontWeight.w400 : FontWeight.w600,
                  letterSpacing: 1),
            )
          ],
        ),
      ),
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
              MyTextAnimated.itemColorize('Sửa chữa'),
              MyTextAnimated.itemColorize('Đặt lịch'),
              MyTextAnimated.itemColorize('Tư vấn'),
              MyTextAnimated.itemColorize('Nhanh chóng'),
            ]),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Container(
                alignment: Alignment.center,
                width: size.width,
                child: const Text(
                    textAlign: TextAlign.center,
                    'Trên đây là giá tham khảo từ cửa hàng SNIK, vui lòng đặt lịch hẹn để được tư vấn.'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Widget _drawer(BuildContext context) {
  //   return Drawer(
  //     backgroundColor: MyColors.lightGreen,
  //     child: ListView(
  //       padding: EdgeInsets.zero,
  //       children: [
  //         DrawerHeader(
  //           decoration: const BoxDecoration(
  //             color: Color.fromARGB(255, 176, 135, 236),
  //           ),
  //           child: GestureDetector(
  //             onTap: _opentProfile,
  //             child: Column(
  //               mainAxisAlignment: MainAxisAlignment.center,
  //               children: [
  //                 SizedBox(
  //                   height: 90,
  //                   width: 90,
  //                   child: UserPrefer.getImageUser() != null && isLogin
  //                       ? CachedNetworkImage(
  //                           imageBuilder: (context, imageProvider) => CircleAvatar(
  //                               backgroundImage: NetworkImage(
  //                                   '${ConnectDb.url}${UserPrefer.getImageUser()}')),
  //                           fit: BoxFit.cover,
  //                           placeholder: (context, url) => const Center(
  //                               child: CircularProgressIndicator()),
  //                           errorWidget: (context, url, error) =>
  //                               const Icon(Icons.error),
  //                           imageUrl:
  //                               '${ConnectDb.url}${UserPrefer.getImageUser()}',
  //                         )
  //                       : const CircleAvatar(
  //                           child: Icon(Ionicons.person),
  //                         ),
  //                 ),
  //                 const SizedBox(
  //                   height: 16,
  //                 ),
  //                 Text(
  //                   username,
  //                   style: const TextStyle(
  //                       fontWeight: FontWeight.w600,
  //                       fontSize: 18,
  //                       overflow: TextOverflow.ellipsis,
  //                       letterSpacing: 2),
  //                 ),
  //               ],
  //             ),
  //           ),
  //         ),
  //         ListTile(
  //           leading: const Icon(
  //             Icons.attach_money,
  //             color: Colors.green,
  //           ),
  //           title: const Text('Bill history'),
  //           onTap: () {},
  //         ),
  //         ListTile(
  //           leading: const Icon(
  //             Icons.calendar_month_outlined,
  //             color: Colors.blue,
  //           ),
  //           title: const Text('Booking history'),
  //           onTap: () {},
  //         ),
  //         UserPrefer.getToken() == null
  //             ? ListTile(
  //                 leading: const Icon(
  //                   Icons.login,
  //                   color: Colors.purple,
  //                 ),
  //                 title: const Text('Login'),
  //                 onTap: _login,
  //               )
  //             : ListTile(
  //                 leading: const Icon(
  //                   Icons.logout_outlined,
  //                   color: Colors.red,
  //                 ),
  //                 title: const Text('Logout'),
  //                 onTap: _logout,
  //               ),
  //         ListTile(
  //           title: const Text('Terms of service'),
  //           leading: const Icon(
  //             Icons.info_outline_rounded,
  //             color: Colors.blue,
  //           ),
  //           onTap: () {
  //             showDialog(
  //               context: context,
  //               builder: (context) => FluidDialog(
  //                 defaultDecoration: BoxDecoration(
  //                   color: SettingPrefer.getLightDark() == null ||
  //                           SettingPrefer.getLightDark()
  //                       ? white
  //                       : black,
  //                 ),
  //                 rootPage: FluidDialogPage(
  //                   alignment: Alignment.bottomLeft,
  //                   builder: (context) => const TestDialog(),
  //                 ),
  //               ),
  //             );
  //           },
  //         ),
  //         const SizedBox(
  //           height: 210,
  //         ),
  //         _darkLight(),
  //       ],
  //     ),
  //   );
  // }

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

class ItemProduct extends StatefulWidget {
  const ItemProduct({
    super.key,
    required this.productData,
    required this.index,
  });
  final int index;
  final List<products.Data> productData;
  @override
  State<ItemProduct> createState() => _ItemProductState(
        productData: productData,
        index: index,
      );
}

class _ItemProductState extends State<ItemProduct> {
  _ItemProductState({
    required this.productData,
    required this.index,
  });
  final int index;
  final List<products.Data> productData;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        Modular.to.pushNamed(Routes.details, arguments: productData[index].id);
      },
      child: Container(
        decoration: const BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.grey,
              offset: Offset(3, 3),
              blurRadius: 16,
            )
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(12),
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
                      padding: const EdgeInsets.all(0),
                      child: ClipRRect(
                        borderRadius: const BorderRadius.only(
                          bottomLeft: Radius.circular(20),
                          bottomRight: Radius.circular(20),
                        ),
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
                    ),
                  ),
                  const SizedBox(height: 8),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(left: 16, right: 16),
                      child: Column(
                        children: [
                          SizedBox(
                            width: MediaQuery.of(context).size.width,
                            child: Text(
                              productData[index].name!.length > 45
                                  ? '${productData[index].name!.substring(0, 40)}...'
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
                          const Spacer(),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                padding: const EdgeInsetsDirectional.all(4),
                                // color: Colors.black,
                                child: Text(
                                    productData[index].number! > 0
                                        ? formatCurrency(
                                            amount:
                                                '${productData[index].price}')
                                        : outOfStock,
                                    style: MyTextStyle.normal.copyWith(
                                      color: Colors.purple,
                                      fontSize: 14,
                                    )),
                              ),
                              GestureDetector(
                                onTap: () async {
                                  final value = await APIProduct.create(
                                      id: productData[index].id!);

                                  if (value == 200) {
                                    if (productData[index].love == 1) {
                                      productData[index].love = 0;
                                    } else {
                                      productData[index].love = 1;
                                    }
                                    Message.success(
                                        message:
                                            'Đã thêm vào danh sách yêu thích.',
                                        context: context);
                                  } else {
                                    if (productData[index].love == 1) {
                                      productData[index].love = 0;
                                    } else {
                                      productData[index].love = 1;
                                    }
                                    Message.success(
                                        message:
                                            'Đã bỏ khỏi danh sách yêu thích.',
                                        context: context);
                                  }
                                  setState(() {});
                                },
                                child: Icon(
                                    productData[index].love == 1
                                        ? Ionicons.heart
                                        : Ionicons.heart_outline,
                                    color: Colors.red),
                              ),
                            ],
                          ),
                          const SizedBox(height: 20),
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
