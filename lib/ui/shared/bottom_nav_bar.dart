import 'package:flutter/material.dart';
import 'package:fruitshop/ui/products/products_favorite_screen.dart';
import 'package:fruitshop/ui/screens.dart';
import 'package:provider/provider.dart';

import '../cart/cart_manager.dart';
import '../products/top_right_badge.dart';
import 'dart:core';

import '../user/admin_page.dart';

class BottomNavBar extends StatefulWidget {
  const BottomNavBar({super.key});
  @override
  State<BottomNavBar> createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  int selectedIndex = 0;
  final Widget _shop = const ProductsOverviewScreen();
  final Widget _favorite = const ProductsFavoriteScreen();
  final Widget _cart = const CartScreen();
  final Widget _user = const UserPage();
  final Widget _admin = const AdminPage();

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    const background = Color.fromARGB(255, 220, 220, 220);
    return Scaffold(
        body: getBody(),
        bottomNavigationBar: SizedBox(
          height: height * 1 / 12,
          child: BottomNavigationBar(
            type: BottomNavigationBarType.shifting,
            iconSize: height * 1 / 35,
            selectedItemColor: const Color.fromARGB(255, 10, 204, 13),
            unselectedItemColor: const Color.fromARGB(255, 0, 0, 0),
            items: <BottomNavigationBarItem>[
              const BottomNavigationBarItem(
                  icon: Icon(Icons.home_outlined),
                  activeIcon: Icon(Icons.home),
                  label: 'Trang Chủ',
                  backgroundColor: background),
              const BottomNavigationBarItem(
                  icon: Icon(Icons.favorite_outline),
                  activeIcon: Icon(Icons.favorite),
                  label: 'Yêu Thích',
                  backgroundColor: background),
              BottomNavigationBarItem(
                  icon: buildShoppingCartIcon(),
                  activeIcon: buildShoppingCartActionIcon(),
                  label: 'Giỏ Hàng',
                  backgroundColor: background),
              const BottomNavigationBarItem(
                  icon: Icon(Icons.person_outline),
                  activeIcon: Icon(Icons.person),
                  label: 'Tài Khoản',
                  backgroundColor: background),
            ],
            currentIndex: selectedIndex,
            onTap: (int index) {
              onTapHandler(index);
            },
          ),
        ));
  }

  Widget buildShoppingCartIcon() {
    return Consumer<CartManager>(builder: (ctx, cartManager, child) {
      return TopRightBadge(
        data: cartManager.productCount,
        child: const Icon(
          Icons.shopping_cart_outlined,
        ),
      );
    });
  }

  Widget buildShoppingCartActionIcon() {
    return Consumer<CartManager>(builder: (ctx, cartManager, child) {
      return TopRightBadge(
        data: cartManager.productCount,
        child: const Icon(
          Icons.shopping_cart,
        ),
      );
    });
  }

  getBody() {
    if (selectedIndex == 0) {
      return _shop;
    } else if (selectedIndex == 1) {
      return _favorite;
    } else if (selectedIndex == 2) {
      return _cart;
    } else if (selectedIndex == 3 &&
        context.read<AuthManager>().authToken!.userId ==
            'A5bJ6KrRamb91Pc5XlId0eZjTVy2') {
      return _admin;
    } else {
      return _user;
    }
  }

  void onTapHandler(int index) {
    setState(() {
      selectedIndex = index;
    });
  }
}
