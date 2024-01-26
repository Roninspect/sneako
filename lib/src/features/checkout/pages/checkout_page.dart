import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sneako/src/core/helper/async_value_helper.dart';
import 'package:sneako/src/features/cart/controllers/cart_controller.dart';
import 'package:sneako/src/features/cart/widgets/cart_total_bar.dart';
import 'package:sneako/src/features/checkout/widgets/address_section.dart';

class CheckOutPage extends ConsumerWidget {
  const CheckOutPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Checkout",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Shipping Address",
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const AddressSection(),
            const Text(
              "Order list",
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 440,
              child: AsyncValueWidget(
                value: ref.watch(cartControllerProvider),
                data: (p0) {
                  return ListView.builder(
                      itemCount: p0.length,
                      itemBuilder: (context, index) {
                        final cart = p0[index];
                        final cartProduct = cart.product!;
                        final cartColor = cart.colors!;
                        final cartSize = cart.sizes!;
                        return Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 8.0, horizontal: 8.0),
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                                vertical: 10.0, horizontal: 10),
                            decoration: BoxDecoration(
                                color: const Color.fromARGB(15, 0, 0, 0),
                                borderRadius: BorderRadius.circular(20)),
                            child: Row(
                              children: [
                                CachedNetworkImage(
                                  height: 100,
                                  width: 110,
                                  imageUrl: cartProduct.background,
                                ),
                                const SizedBox(width: 10),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      cartProduct.title,
                                      style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 18),
                                    ),
                                    Row(
                                      children: [
                                        CircleAvatar(
                                          radius: 8,
                                          backgroundColor: Color(
                                              int.parse(cartColor.colorCode)),
                                        ),
                                        const SizedBox(width: 5),
                                        Text(
                                          cartColor.name,
                                          style: const TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 18),
                                        ),
                                        const Padding(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 8.0),
                                          child: Text(
                                            '|',
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 18),
                                          ),
                                        ),
                                        const Text(
                                          'Size - ',
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 18),
                                        ),
                                        Text(
                                          cartSize.size.toString(),
                                          style: const TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 18),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 5),
                                    Text(
                                      '\$${cartProduct.mainPrice} x ${cart.quantity}',
                                      style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 20),
                                    )
                                  ],
                                ),
                              ],
                            ),
                          ),
                        );
                      });
                },
              ),
            ),
            CartTotalBar(isCheckout: true, onPressed: () {}),
          ],
        ),
      ),
    );
  }
}
