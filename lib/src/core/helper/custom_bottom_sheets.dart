import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:sneako/src/features/auth/provider/user_data_notifer.dart';
import 'package:sneako/src/features/cart/controllers/cart_controller.dart';
import 'package:sneako/src/features/cart/widgets/cart_card_without_increment.dart';
import 'package:sneako/src/features/checkout/pages/add_new_address.dart';
import 'package:sneako/src/features/checkout/pages/edit_address.dart';
import 'package:sneako/src/models/address.dart';
import 'package:sneako/src/models/cart.dart';

class CustomBottomSheets {
  static Future displayRemoveConfirmSheet(
      {required BuildContext context,
      required Cart cart,
      required WidgetRef ref}) {
    final uid = ref.watch(userDataNotifierProvider.select((value) => value.id));
    return showModalBottomSheet(
      showDragHandle: true,
      context: context,
      builder: (context) => SizedBox(
        height: 250,
        width: 450,
        child: Column(
          children: [
            const Text(
              "Remove From Cart?",
              style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
            ),
            CartCardWithoutBTN(cart: cart),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                InkWell(
                  onTap: () => context.pop(),
                  child: Container(
                    height: 50,
                    width: 180,
                    decoration: BoxDecoration(
                        color: const Color.fromARGB(15, 0, 0, 0),
                        borderRadius: BorderRadius.circular(20)),
                    child: const Center(
                      child: Text(
                        "Cancel",
                        style: TextStyle(
                            fontWeight: FontWeight.w600, fontSize: 17),
                      ),
                    ),
                  ),
                ),
                InkWell(
                  onTap: () {
                    ref.read(cartControllerProvider.notifier).removeFromCart(
                          productId: cart.productId,
                          uid: uid,
                          colorId: cart.color,
                          sizeId: cart.size,
                        );
                    context.pop();
                  },
                  child: Container(
                    height: 50,
                    width: 180,
                    decoration: BoxDecoration(
                        color: Colors.black,
                        borderRadius: BorderRadius.circular(20)),
                    child: const Center(
                      child: Text(
                        "Yes, Remove",
                        style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 17,
                            color: Colors.white),
                      ),
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  static Future displayAddAddressSheet({
    required BuildContext context,
    required bool isAddingFirstTime,
  }) {
    return showModalBottomSheet(
      isDismissible: false,
      context: context,
      builder: (context) {
        return SizedBox(
          height: 800,
          child: AddNewAddress(isAddingFirstTime: isAddingFirstTime),
        );
      },
    );
  }

  static Future displayEditAddressSheet(
      {required Address address, required BuildContext context}) {
    return showModalBottomSheet(
      isDismissible: false,
      context: context,
      builder: (context) {
        return SizedBox(height: 800, child: EditAddressPage(address: address));
      },
    );
  }
}
