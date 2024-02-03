import 'package:flutter/material.dart';
import 'package:sneako/src/features/cart/pages/cart_page.dart';
import 'package:sneako/src/features/home/pages/hompage.dart';
import 'package:sneako/src/features/orders/pages/orders_page.dart';

class TabWidgets {
  static List<Widget> tabs = [
    const HomePage(),
    const CartPage(),
    const OrdersPage(),
    const HomePage(),
  ];
}
