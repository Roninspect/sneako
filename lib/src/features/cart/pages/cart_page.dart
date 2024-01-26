import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:go_router/go_router.dart';
import 'package:sneako/src/features/cart/widgets/cart_card.dart';
import 'package:sneako/src/features/cart/widgets/cart_total_bar.dart';
import 'package:sneako/src/router/router.dart';

class CartPage extends ConsumerWidget {
  const CartPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "My Cart",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: Column(
        children: [
          const CartCard(),
          CartTotalBar(
              isCheckout: false,
              onPressed: () => context.pushNamed(AppRoutes.checkout.name)),
        ],
      ),
    );
  }
}
