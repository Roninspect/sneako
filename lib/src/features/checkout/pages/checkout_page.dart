import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:sneako/src/core/helper/async_value_helper.dart';
import 'package:sneako/src/core/shared/custom_snackbar.dart';
import 'package:sneako/src/features/auth/provider/user_data_notifer.dart';
import 'package:sneako/src/features/cart/controllers/cart_controller.dart';
import 'package:sneako/src/features/cart/widgets/cart_total_bar.dart';
import 'package:sneako/src/features/checkout/controller/checkout_controller.dart';
import 'package:sneako/src/features/checkout/providers/selected_address.dart';
import 'package:sneako/src/features/checkout/widgets/address_section.dart';
import 'package:sneako/src/models/order.dart';
import 'package:sneako/src/models/order_line.dart';
import 'package:uuid/v4.dart';

class CheckOutPage extends ConsumerWidget {
  const CheckOutPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isLoading = ref.watch(checkoutControllerProvider);
    final uid = ref.watch(userDataNotifierProvider).value!.id;
    final cartState = ref.watch(cartControllerProvider).value!;

    return Scaffold(
      appBar: isLoading
          ? null
          : AppBar(
              title: const Text(
                "Checkout",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
      body: isLoading
          ? const Center(
              child: Text("Please Wait, Your orderis being processed"),
            )
          : Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Shipping Address",
                      style:
                          TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                    ),
                    const AddressSection(),
                    const Text(
                      "Order list",
                      style:
                          TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                    ),
                    AsyncValueWidget(
                      value: ref.watch(cartControllerProvider),
                      data: (p0) {
                        return p0.isEmpty
                            ? const SizedBox.shrink()
                            : ListView.builder(
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
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
                                          color:
                                              const Color.fromARGB(15, 0, 0, 0),
                                          borderRadius:
                                              BorderRadius.circular(20)),
                                      child: Row(
                                        children: [
                                          CachedNetworkImage(
                                            height: 100,
                                            width: 110,
                                            imageUrl: cartProduct.background,
                                          ),
                                          const SizedBox(width: 10),
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
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
                                                        int.parse(cartColor
                                                            .colorCode)),
                                                  ),
                                                  const SizedBox(width: 5),
                                                  Text(
                                                    cartColor.name,
                                                    style: const TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontSize: 18),
                                                  ),
                                                  const Padding(
                                                    padding:
                                                        EdgeInsets.symmetric(
                                                            horizontal: 8.0),
                                                    child: Text(
                                                      '|',
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          fontSize: 18),
                                                    ),
                                                  ),
                                                  const Text(
                                                    'Size - ',
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontSize: 18),
                                                  ),
                                                  Text(
                                                    cartSize.size.toString(),
                                                    style: const TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold,
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

                    Padding(
                      padding: const EdgeInsets.symmetric(
                              vertical: 15.0, horizontal: 8.0)
                          .copyWith(top: 30),
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            vertical: 10.0, horizontal: 10),
                        decoration: BoxDecoration(
                            border: Border.all(width: 2),
                            color: const Color.fromARGB(15, 0, 0, 0),
                            borderRadius: BorderRadius.circular(20)),
                        child: Row(
                          children: [
                            const Icon(
                              Icons.discount,
                              size: 30,
                            ),
                            const SizedBox(width: 20),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text("Have a Coupon?",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 20)),
                                const SizedBox(height: 5),
                                InkWell(
                                  onTap: () {},
                                  child: const Text(
                                    "Enter Your Coupon",
                                    style: TextStyle(
                                        color: Colors.deepPurple,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16),
                                  ),
                                )
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),

                    //** Shipping charge */

                    AsyncValueWidget(
                        value: ref.watch(getDefaultAddressProvider(uid)),
                        data: (address) {
                          if (address != null) {
                            final selectedAddress = ref.watch(
                                selectedAddressNotifierProvider(address));
                            if (selectedAddress.address.contains('Dhaka') ||
                                selectedAddress.address
                                    .contains('Chittagong') ||
                                selectedAddress.address
                                    .contains('Chattogram')) {
                              return Column(
                                children: [
                                  const Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        "Shipping Charge",
                                        style: TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      Text(
                                        " \$5.00",
                                        style: TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 10),
                                  CartTotalBar(
                                    isCheckout: true,
                                    onPressed: () {
                                      final ordertotal = cartState
                                          .map((cartItem) =>
                                              cartItem.quantity *
                                              cartItem.product!.mainPrice)
                                          .reduce((total, itemTotal) =>
                                              total + itemTotal);
                                      final orderId = const UuidV4().generate();
                                      ref
                                          .read(checkoutControllerProvider
                                              .notifier)
                                          .addOrder(
                                              order: ProductOrder(
                                                  id: orderId,
                                                  uid: uid,
                                                  address:
                                                      selectedAddress.address,
                                                  order_total: ordertotal,
                                                  orderStatus: "Active"),
                                              context: context,
                                              orderlines: cartState
                                                  .map((e) => OrderLine(
                                                      pa_id: e.pa_id,
                                                      order_id: orderId,
                                                      quantity: e.quantity,
                                                      price: e.productId))
                                                  .toList());
                                    },
                                    shippingCharge: 5,
                                  ),
                                ],
                              );
                            } else {
                              return Column(
                                children: [
                                  const Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        "Shipping Charge",
                                        style: TextStyle(
                                            fontSize: 25,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      Text(
                                        " \$10.00",
                                        style: TextStyle(
                                            fontSize: 25,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 10),
                                  CartTotalBar(
                                    isCheckout: true,
                                    onPressed: () {
                                      final ordertotal = cartState
                                          .map((cartItem) =>
                                              cartItem.quantity *
                                              cartItem.product!.mainPrice)
                                          .reduce((total, itemTotal) =>
                                              total + itemTotal);
                                      final orderId = const UuidV4().generate();
                                      ref
                                          .read(checkoutControllerProvider
                                              .notifier)
                                          .addOrder(
                                              order: ProductOrder(
                                                  id: orderId,
                                                  uid: uid,
                                                  address:
                                                      selectedAddress.address,
                                                  order_total: ordertotal,
                                                  orderStatus: "Active"),
                                              context: context,
                                              orderlines: cartState
                                                  .map((e) => OrderLine(
                                                      pa_id: e.pa_id,
                                                      order_id: orderId,
                                                      quantity: e.quantity,
                                                      price:
                                                          e.product!.mainPrice))
                                                  .toList());
                                    },
                                    shippingCharge: 10,
                                  ),
                                ],
                              );
                            }
                          } else {
                            return CartTotalBar(
                              isCheckout: true,
                              onPressed: () {
                                showSnackbar(
                                    context: context,
                                    text: "No address is defined");
                              },
                            );
                          }
                        }),
                  ],
                ),
              ),
            ),
    );
  }
}
