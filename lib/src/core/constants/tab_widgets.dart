import 'package:flutter/material.dart';
import 'package:sneako/src/features/cart/pages/cart_page.dart';
import 'package:sneako/src/features/home/pages/hompage.dart';
import 'package:sneako/src/features/orders/pages/order_root_page.dart';
import 'package:sneako/src/features/orders/pages/Active_orders_page.dart';

class TabWidgets {
  static List<Widget> tabs = [
    const HomePage(),
    const CartPage(),
    const OrderPage(),
    const HomePage(),
  ];
}
