// ignore_for_file: unused_element

import 'package:app/components/test/item.dart';
import 'package:flashy_tab_bar2/flashy_tab_bar2.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: FocusScope.of(context).unfocus,
      child: SafeArea(
        child: Scaffold(
          bottomNavigationBar: FlashyTabBar(
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
                icon: const Icon(Icons.highlight),
                title: const Text(
                  'Highlights',
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
    );
  }
}

// ignore: camel_case_types
class _drawer extends StatelessWidget {
  const _drawer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Drawer(
      // Add a ListView to the drawer. This ensures the user can scroll
      // through the options in the drawer if there isn't enough vertical
      // space to fit everything.
      child: ListView(
        // Important: Remove any padding from the ListView.
        padding: EdgeInsets.zero,
        children: [
          const DrawerHeader(
            decoration: BoxDecoration(
              color: Colors.blue,
            ),
            child: Text('Drawer Header'),
          ),
          ListTile(
            title: const Text('Item 1'),
            onTap: () {
              // Update the state of the app
              // ...
              // Then close the drawer
              Navigator.pop(context);
            },
          ),
          ListTile(
            title: const Text('Item 2'),
            onTap: () {
              // Update the state of the app
              // ...
              // Then close the drawer
              Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  }
}
