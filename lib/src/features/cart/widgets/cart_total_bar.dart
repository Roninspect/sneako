// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import 'package:sneako/src/core/helper/async_value_helper.dart';
import 'package:sneako/src/features/cart/controllers/cart_controller.dart';
import 'package:sneako/src/router/router.dart';

class CartTotalBar extends ConsumerWidget {
  final bool isCheckout;
  final int? shippingCharge;
  final Function()? onPressed;
  const CartTotalBar({
    super.key,
    required this.isCheckout,
    this.shippingCharge,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final size = MediaQuery.of(context).size;
    return Container(
      height: size.height * 0.12,
      padding: const EdgeInsets.all(10),
      width: double.infinity,
      decoration: const BoxDecoration(
        color: Color(0xffebedef),
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(30),
          topLeft: Radius.circular(30),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Total Price',
                  style: TextStyle(
                      color: Color.fromARGB(146, 0, 0, 0),
                      fontWeight: FontWeight.bold,
                      fontSize: 16),
                ),
                AsyncValueWidget(
                  value: ref.watch(cartControllerProvider),
                  data: (p0) {
                    if (p0.isNotEmpty) {
                      final totalPrice = p0
                          .map((cartItem) =>
                              cartItem.quantity * cartItem.product!.mainPrice)
                          .reduce((total, itemTotal) => total + itemTotal);
                      if (shippingCharge == null) {
                        return Text(
                          "\$$totalPrice.00",
                          style: const TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 30),
                        );
                      } else {
                        return Text(
                          "\$${totalPrice + shippingCharge!}.00",
                          style: const TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 30),
                        );
                      }
                    } else {
                      return const Text(
                        "\$0.00",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 30),
                      );
                    }
                  },
                ),
              ],
            ),
          ),
          isCheckout
              ? ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      surfaceTintColor: Colors.white,
                      fixedSize: const Size(200, 60),
                      backgroundColor: Colors.black),
                  onPressed: onPressed,
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Continue to payment",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 15,
                          color: Colors.white,
                        ),
                      ),
                      SizedBox(width: 5),
                    ],
                  ))
              : ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      surfaceTintColor: Colors.white,
                      fixedSize: const Size(200, 60),
                      backgroundColor: Colors.black),
                  onPressed: onPressed,
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Checkout",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 17,
                          color: Colors.white,
                        ),
                      ),
                      SizedBox(width: 5),
                      Icon(
                        Icons.arrow_forward_sharp,
                        color: Colors.white,
                      )
                    ],
                  ))
        ],
      ),
    );
  }
}
