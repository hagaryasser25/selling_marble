import 'package:animated_notch_bottom_bar/animated_notch_bottom_bar/animated_notch_bottom_bar.dart';
import 'package:bottom_sheet_expandable_bar/bottom_sheet_bar_icon.dart';
import 'package:bottom_sheet_expandable_bar/bottom_sheet_expandable_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../admin/logout_page.dart';
import 'admin_complain.dart';
import 'admin_home.dart';

class AdminBottom extends StatefulWidget {
  static const routeName = '/adminBottom';
  const AdminBottom({Key? key}) : super(key: key);

  @override
  _AdminBottomState createState() => _AdminBottomState();
}

class _AdminBottomState extends State<AdminBottom> {
  final _pageController = PageController(initialPage: 0);
  int maxCount = 3;

  final List<Widget> bottomBarPages = [
    AdminHome(),
    AdminComplain(),
    LogoutPage(),
  ];

  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: _pageController,
        physics: const NeverScrollableScrollPhysics(),
        children: List.generate(
            bottomBarPages.length, (index) => bottomBarPages[index]),
      ),
      extendBody: true,
      bottomNavigationBar: (bottomBarPages.length <= maxCount)
          ? AnimatedNotchBottomBar(
              pageController: _pageController,
              color: Color.fromARGB(255, 34, 34, 34),
              showLabel: false,
              notchColor: Color.fromARGB(255, 71, 233, 133),
              bottomBarItems: [
                const BottomBarItem(
                  inActiveItem: Icon(
                    Icons.account_balance ,
                    color: Color.fromARGB(255, 71, 233, 133),
                  ),
                  activeItem: Icon(
                    Icons.account_balance ,
                    color: Colors.white,
                  ),
                  itemLabel: 'Page 1',
                ),
                const BottomBarItem(
                  inActiveItem: Icon(
                    Icons.ads_click,
                    color: Color.fromARGB(255, 71, 233, 133),
                  ),
                  activeItem: Icon(
                    Icons.ads_click,
                    color: Colors.white,
                  ),
                  itemLabel: 'Page 2',
                ),

                ///svg example
                BottomBarItem(
                   inActiveItem: Icon(
                    Icons.logout,
                    color: Color.fromARGB(255, 71, 233, 133),
                  ),
                  activeItem: Icon(
                    Icons.logout,
                    color: Colors.white,
                  ),
                  itemLabel: 'Page 3',
                ),

              ],
              onTap: (index) {
                /// control your animation using page controller
                _pageController.animateToPage(
                  index,
                  duration: const Duration(milliseconds: 500),
                  curve: Curves.easeIn,
                );
              },
            )
          : null,
    );
  }
}