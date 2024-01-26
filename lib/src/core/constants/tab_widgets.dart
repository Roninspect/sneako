import 'package:flutter/material.dart';
import 'package:sneako/src/features/cart/pages/cart_page.dart';
import 'package:sneako/src/features/home/pages/hompage.dart';

class TabWidgets {
  static List<Widget> tabs = [
    const HomePage(),
    const CartPage(),
    const HomePage(),
    const HomePage(),
    const HomePage(),
  ];
}
