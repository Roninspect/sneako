import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:sneako/src/core/helper/custom_bottom_sheets.dart';
import 'package:sneako/src/core/helper/async_value_helper.dart';
import 'package:sneako/src/features/auth/provider/user_data_notifer.dart';
import 'package:sneako/src/features/cart/controllers/cart_controller.dart';

class CartCard extends ConsumerWidget {
  const CartCard({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final cartState = ref.watch(cartControllerProvider);
    final uid = ref.watch(userDataNotifierProvider).value!.id;

    return SizedBox(
      height: 620,
      child: AsyncValueWidget(
        value: cartState,
        data: (p0) {
          return p0.isEmpty
              ? const Center(
                  child: Text('No Cart item'),
                )
              : ListView.builder(
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
                              cacheKey: cartProduct.background,
                              imageUrl: cartProduct.background,
                            ),
                            const SizedBox(width: 10),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(
                                  width: 250,
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        cartProduct.title,
                                        style: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 18),
                                      ),
                                      IconButton(
                                          onPressed: () {
                                            CustomBottomSheets
                                                .displayRemoveConfirmSheet(
                                                    ref: ref,
                                                    cart: cart,
                                                    context: context);
                                          },
                                          icon: const Icon(
                                            MaterialCommunityIcons
                                                .delete_outline,
                                            size: 27,
                                          ))
                                    ],
                                  ),
                                ),
                                Row(
                                  children: [
                                    CircleAvatar(
                                      radius: 8,
                                      backgroundColor:
                                          Color(int.parse(cartColor.colorCode)),
                                    ),
                                    const SizedBox(width: 5),
                                    Text(
                                      cartColor.name,
                                      style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 18),
                                    ),
                                    const Padding(
                                      padding:
                                          EdgeInsets.symmetric(horizontal: 8.0),
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
                                SizedBox(
                                  width: 250,
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        '\$${cartProduct.mainPrice} x ${cart.quantity}',
                                        style: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 20),
                                      ),
                                      Container(
                                        height: 40,
                                        decoration: BoxDecoration(
                                            color: const Color.fromARGB(
                                                15, 0, 0, 0),
                                            borderRadius:
                                                BorderRadius.circular(20)),
                                        child: Row(
                                          children: [
                                            IconButton(
                                                onPressed: () {
                                                  ref
                                                      .read(
                                                          cartControllerProvider
                                                              .notifier)
                                                      .incrementQuantity(
                                                          cartId: cart.id!,
                                                          productId:
                                                              cartProduct.id,
                                                          uid: uid,
                                                          colorId: cart.color,
                                                          sizeId: cart.size,
                                                          quanity:
                                                              cart.quantity);
                                                },
                                                icon: const Icon(Icons.add)),
                                            Text(
                                              cart.quantity.toString(),
                                              style: const TextStyle(
                                                  fontSize: 17,
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.black),
                                            ),
                                            IconButton(
                                                onPressed: () {
                                                  if (cart.quantity > 1) {
                                                    ref
                                                        .read(
                                                            cartControllerProvider
                                                                .notifier)
                                                        .decrementQuantity(
                                                            cartId: cart.id!,
                                                            quanity:
                                                                cart.quantity);
                                                  } else {
                                                    CustomBottomSheets
                                                        .displayRemoveConfirmSheet(
                                                            context: context,
                                                            cart: cart,
                                                            ref: ref);
                                                  }
                                                },
                                                icon: const Icon(Icons.remove)),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                );
        },
      ),
    );
  }
}
