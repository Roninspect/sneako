import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:sneako/src/features/cart/widgets/cart_card.dart';
import 'package:sneako/src/features/cart/widgets/cart_total_bar.dart';
import 'package:sneako/src/router/router.dart';

class CartPage extends ConsumerWidget {
  const CartPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "My Cart",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: Container(
        color: Colors.pink,
        child: Stack(
          alignment: Alignment.bottomCenter,
          children: [
            const CartCard(),
            SizedBox(
              height: size.height * 0.1,
              child: CartTotalBar(
                  isCheckout: false,
                  onPressed: () => context.pushNamed(AppRoutes.checkout.name)),
            ),
          ],
        ),
      ),
    );
  }
}
