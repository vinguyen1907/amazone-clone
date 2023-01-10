import 'package:amazon_clone/cart/screens/cart_screen.dart';
import 'package:amazon_clone/constant/app_colors.dart';
import 'package:amazon_clone/features/account/screens/account_screen.dart';
import 'package:amazon_clone/features/home/screens/home_screen.dart';
import 'package:amazon_clone/providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:badges/badges.dart';
import 'package:provider/provider.dart';

class BottomBar extends StatefulWidget {
  const BottomBar({super.key});

  static const routeName = 'bottom_bar';

  @override
  State<BottomBar> createState() => _BottomBarState();
}

class _BottomBarState extends State<BottomBar> {
  int _currentIndex = 0;
  double bottomBarWidth = 42;
  double bottomBarBorderWidth = 5;

  List<Widget> pages = [
    const HomeScreen(),
    const AccountScreen(),
    const CartScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    final userCartLen = context.watch<UserProvider>().user.cart.length;

    return Scaffold(
      body: pages[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
          currentIndex: _currentIndex,
          selectedItemColor: AppColors.selectedNavBarColor,
          unselectedItemColor: AppColors.unselectedNavBarColor,
          backgroundColor: AppColors.backgroundColor,
          iconSize: 28,
          onTap: (value) {
            setState(() {
              _currentIndex = value;
            });
          },
          items: [
            // HOME
            BottomNavigationBarItem(
                icon: Container(
                    width: bottomBarWidth,
                    decoration: BoxDecoration(
                        border: Border(
                            top: BorderSide(
                                color: _currentIndex == 0
                                    ? AppColors.selectedNavBarColor
                                    : AppColors.backgroundColor,
                                width: bottomBarBorderWidth))),
                    child: const Icon(Icons.home_outlined)),
                label: ""),

            // ACCOUNT
            BottomNavigationBarItem(
                icon: Container(
                    width: bottomBarWidth,
                    decoration: BoxDecoration(
                        border: Border(
                            top: BorderSide(
                                color: _currentIndex == 1
                                    ? AppColors.selectedNavBarColor
                                    : AppColors.backgroundColor,
                                width: bottomBarBorderWidth))),
                    child: const Icon(Icons.person_outline_outlined)),
                label: ""),

            // CART
            BottomNavigationBarItem(
              icon: Container(
                width: bottomBarWidth,
                decoration: BoxDecoration(
                  border: Border(
                    top: BorderSide(
                      color: _currentIndex == 2
                          ? AppColors.selectedNavBarColor
                          : AppColors.backgroundColor,
                      width: bottomBarBorderWidth,
                    ),
                  ),
                ),
                child: Badge(
                  elevation: 0,
                  badgeContent: Text(userCartLen.toString()),
                  badgeColor: Colors.white,
                  child: const Icon(
                    Icons.shopping_cart_outlined,
                  ),
                ),
              ),
              label: '',
            ),
          ]),
    );
  }
}
