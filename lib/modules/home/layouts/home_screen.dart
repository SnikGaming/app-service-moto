// ignore_for_file: unused_element, non_constant_identifier_names
import 'package:app/modules/home/layouts/pages/cart_page.dart';
import 'package:app/modules/home/layouts/pages/home_page.dart';
import 'package:app/modules/home/layouts/pages/profie_page.dart';
import 'package:app/modules/home/layouts/pages/services_page.dart';
import 'package:flashy_tab_bar2/flashy_tab_bar2.dart';
import 'package:flutter/material.dart';

import '../../../components/calendar/pages/calendar_page.dart';
import '../../../components/value_app.dart';
import '../../../constants/colors.dart';
import '../../../functions/onWillPop.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;
  List<Widget> TestScreen = [
    const HomePage(),
    const ServicesPage(),
    const CalendarPage(),
    const CartScreen(),
    const ProFilePage(),
  ];

  Future<void> refreshData() async {
    await Future.delayed(const Duration(seconds: 3));
  }

  @override
  void initState() => super.initState();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: WillPopScope(
        onWillPop: () => onWillPop(context, _selectedIndex, (newIndex) {
          setState(() {
            _selectedIndex = newIndex;
          });
        }),
        child: RefreshIndicator(
          onRefresh: refreshData,
          child: GestureDetector(
            onTap: FocusScope.of(context).unfocus,
            child: SafeArea(
              child: Scaffold(
                backgroundColor: black,
                bottomNavigationBar: FlashyTabBar(
                  backgroundColor: black,
                  selectedIndex: _selectedIndex,
                  showElevation: true,
                  onItemSelected: (index) => setState(() {
                    _selectedIndex = index;
                  }),
                  items: [
                    FlashyTabBarItem(
                      inactiveColor: Colors.white,
                      activeColor: Colors.green,
                      icon: const Icon(Icons.home),
                      title: const Text(
                        txtHome,
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                    FlashyTabBarItem(
                      inactiveColor: Colors.white,
                      activeColor: Colors.green,
                      icon: const Icon(Icons.supervised_user_circle),
                      title: const Text(
                        'Services',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                    FlashyTabBarItem(
                      inactiveColor: Colors.white,
                      activeColor: Colors.green,
                      icon: const Icon(Icons.calendar_month_sharp),
                      title: const Text(
                        txtBooking,
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                    FlashyTabBarItem(
                      inactiveColor: Colors.white,
                      activeColor: Colors.green,
                      icon: const Icon(Icons.shopping_bag_sharp),
                      title: const Text(
                        txtCart,
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                    FlashyTabBarItem(
                      inactiveColor: Colors.white,
                      activeColor: Colors.green,
                      icon: const Icon(Icons.settings),
                      title: const Text(
                        txtOrder,
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ],
                ),
                body: TestScreen[_selectedIndex],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
