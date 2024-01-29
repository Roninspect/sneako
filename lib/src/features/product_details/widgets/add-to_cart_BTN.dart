// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import 'package:sneako/src/core/helper/async_value_helper.dart';
import 'package:sneako/src/core/shared/custom_snackbar.dart';
import 'package:sneako/src/features/auth/provider/user_data_notifer.dart';
import 'package:sneako/src/features/cart/controllers/cart_controller.dart';
import 'package:sneako/src/features/cart/pages/cart_page.dart';
import 'package:sneako/src/features/product_details/providers/color_provider.dart';
import 'package:sneako/src/features/product_details/providers/product_attribute_provider..dart';
import 'package:sneako/src/features/product_details/providers/quantity_provider.dart';
import 'package:sneako/src/features/product_details/providers/size_provider.dart';
import 'package:sneako/src/features/product_details/repository/product_details_repository.dart';
import 'package:sneako/src/models/cart.dart';
import 'package:sneako/src/router/router.dart';

class ATCButton extends ConsumerWidget {
  final int productId;
  const ATCButton({
    super.key,
    required this.productId,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedColor = ref.watch(colorSelectorNotifierProvider);
    final selectedSizes = ref.watch(sizeSelectorNotifierProvider);
    final quantity = ref.watch(quantityNotifierProvider);
    final uid = ref.watch(userDataNotifierProvider);
    final bool isColorSizeSelected =
        selectedColor != null && selectedSizes != null;

    final addTocartState = ref.watch(cartControllerProvider);

    return isColorSizeSelected
        ? AsyncValueWidget(
            value: ref.watch(getQuantityProvider(
                colorId: selectedColor.id,
                productid: productId,
                sizeId: selectedSizes.id)),
            data: (p0) {
              return p0 > 0
                  ? InkWell(
                      onTap: () {
                        ref.read(cartControllerProvider.notifier).addToCart(
                                cart: Cart(
                              productId: productId,
                              quantity: quantity,
                              uid: uid.id,
                              color: selectedColor.id,
                              pa_id: ref.watch(selectedproductAttributeProvider
                                  .select((value) => value!.id)),
                              size: selectedSizes.id,
                            ));
                        context.pushNamed(AppRoutes.cart.name);
                        if (addTocartState.hasError) {
                          showSnackbar(
                              context: context,
                              text: 'Something wrong happened');
                        }
                      },
                      child: Container(
                        padding: EdgeInsets.zero,
                        height: 50,
                        width: 220,
                        decoration: const BoxDecoration(
                            color: Colors.black,
                            borderRadius:
                                BorderRadius.all(Radius.circular(30))),
                        child: const Center(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.shopping_bag, color: Colors.white),
                              SizedBox(width: 15),
                              Text(
                                "Add To Cart",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 17,
                                    fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                        ),
                      ),
                    )
                  : InkWell(
                      onTap: () {
                        showSnackbar(context: context, text: 'Sold Out');
                      },
                      child: Container(
                        padding: EdgeInsets.zero,
                        height: 50,
                        width: 220,
                        decoration: const BoxDecoration(
                            color: Colors.black,
                            borderRadius:
                                BorderRadius.all(Radius.circular(30))),
                        child: const Center(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.close, color: Colors.white),
                              SizedBox(width: 10),
                              Text(
                                "Sold Out",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 17,
                                    fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
            },
          )
        : InkWell(
            onTap: () {
              showSnackbar(
                  context: context, text: 'Please Select Both Color & Size');
            },
            child: Container(
              padding: EdgeInsets.zero,
              height: 50,
              width: 220,
              decoration: const BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.all(Radius.circular(30))),
              child: const Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.shopping_bag, color: Colors.white),
                    SizedBox(width: 10),
                    Text(
                      "Add To Cart",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 17,
                          fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
            ),
          );
  }
}
