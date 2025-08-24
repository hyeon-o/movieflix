import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:twitter_clone/constants/sizes.dart';
import 'package:twitter_clone/features/activity/activity_screen.dart';
import 'package:twitter_clone/features/search/search_screen.dart';

class MainNavigationScreen extends StatefulWidget {
  const MainNavigationScreen({super.key});

  @override
  State<MainNavigationScreen> createState() => _MainNavigationScreenState();
}

class _MainNavigationScreenState extends State<MainNavigationScreen> {
  int _selectedIndex = 3;

  void _onItemTapped(int index) {
    // setState를 호출하여 화면을 다시 그리도록 함
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: [
          Offstage(offstage: _selectedIndex != 0, child: Container(color: Colors.red,)),
          Offstage(offstage: _selectedIndex != 1, child: SearchScreen()),
          Offstage(offstage: _selectedIndex != 2, child: Container(color: Colors.green,)),
          Offstage(offstage: _selectedIndex != 3, child: ActivityScreen()),
          Offstage(offstage: _selectedIndex != 4, child: Container(color: Colors.purple,)),
        ],
      ),
      bottomNavigationBar: CupertinoTabBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: FaIcon(FontAwesomeIcons.house, size: Sizes.size28),
            activeIcon: FaIcon(FontAwesomeIcons.house, size: Sizes.size28),
          ),
          BottomNavigationBarItem(
            icon: FaIcon(FontAwesomeIcons.magnifyingGlass, size: Sizes.size28),
            activeIcon: FaIcon(FontAwesomeIcons.magnifyingGlass, size: Sizes.size28),
          ),
          BottomNavigationBarItem(
            icon: FaIcon(FontAwesomeIcons.message, size: Sizes.size28),
            activeIcon: FaIcon(FontAwesomeIcons.solidMessage, size: Sizes.size28),
          ),
          BottomNavigationBarItem(
            icon: FaIcon(FontAwesomeIcons.heart, size: Sizes.size28),
            activeIcon: FaIcon(FontAwesomeIcons.solidHeart, size: Sizes.size28),
          ),
          BottomNavigationBarItem(
            icon: FaIcon(FontAwesomeIcons.user, size: Sizes.size28),
            activeIcon: FaIcon(FontAwesomeIcons.solidUser, size: Sizes.size28),
          ),
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        height: Sizes.size60,
        activeColor: Colors.black,
        backgroundColor: Colors.white,
        border: Border(
          top: BorderSide.none,
        ),
      ),
    );
  }
}
