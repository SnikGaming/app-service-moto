// ignore_for_file: unused_element

import 'package:app/components/test/item.dart';
import 'package:flashy_tab_bar2/flashy_tab_bar2.dart';
import 'package:flutter/material.dart';

import '../../../constants/colors.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;
  Future<void> refreshData() async {
    await Future.delayed(const Duration(seconds: 3));
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
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
                    'HOME',
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
                  icon: const Icon(Icons.settings),
                  title: const Text(
                    'Settings',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
                FlashyTabBarItem(
                  inactiveColor: Colors.white,
                  activeColor: Colors.green,
                  icon: const Icon(Icons.settings),
                  title: const Text(
                    '한국어',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ],
            ),
            body: TestScreen[_selectedIndex],
          ),
        ),
      ),
    );
  }
}
