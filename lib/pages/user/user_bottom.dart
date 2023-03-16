import 'package:animated_notch_bottom_bar/animated_notch_bottom_bar/animated_notch_bottom_bar.dart';
import 'package:bottom_sheet_expandable_bar/bottom_sheet_bar_icon.dart';
import 'package:bottom_sheet_expandable_bar/bottom_sheet_expandable_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:selling_marble/pages/user/user_cart.dart';
import 'package:selling_marble/pages/user/user_complain.dart';
import 'package:selling_marble/pages/user/user_marble.dart';
import 'package:selling_marble/pages/user/user_home.dart';

import '../admin/logout_page.dart';

class UserBottom extends StatefulWidget {
  static const routeName = '/userBottom';
  const UserBottom({Key? key}) : super(key: key);

  @override
  _UserBottomState createState() => _UserBottomState();
}

class _UserBottomState extends State<UserBottom> {
  final _pageController = PageController(initialPage: 0);
  int maxCount = 3;

  final List<Widget> bottomBarPages = [
    UserHome(),
    UserComplain(),
    UserCart()
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
                    Icons.home_filled,
                    color: Color.fromARGB(255, 71, 233, 133),
                  ),
                  activeItem: Icon(
                    Icons.home_filled,
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
                    Icons.shopping_cart,
                    color: Color.fromARGB(255, 71, 233, 133),
                  ),
                  activeItem: Icon(
                    Icons.shopping_cart,
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
