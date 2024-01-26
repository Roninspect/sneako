// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sneako/src/core/helper/async_value_helper.dart';
import 'package:sneako/src/core/shared/custom_snackbar.dart';

import 'package:sneako/src/features/product_details/providers/color_provider.dart';
import 'package:sneako/src/features/product_details/providers/quantity_provider.dart';
import 'package:sneako/src/features/product_details/providers/size_provider.dart';
import 'package:sneako/src/features/product_details/repository/product_details_repository.dart';

class QuantityBar extends ConsumerWidget {
  final int productId;
  const QuantityBar({
    super.key,
    required this.productId,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final quantity = ref.watch(quantityNotifierProvider);

    final selectedColor = ref.watch(colorSelectorNotifierProvider);
    final selectedSizes = ref.watch(sizeSelectorNotifierProvider);
    final bool isColorSizeSelected =
        selectedColor != null && selectedSizes != null;

    int? limitqunatity() {
      if (isColorSizeSelected) {
        final rquantity = ref
            .watch(getQuantityProvider(
                colorId: selectedColor.id,
                productid: productId,
                sizeId: selectedSizes.id))
            .valueOrNull;

        return rquantity;
      } else {
        return null;
      }
    }

    return Row(
      children: [
        const Text(
          "Quantity",
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        const SizedBox(width: 10),
        Container(
          decoration: BoxDecoration(
              color: Colors.black12, borderRadius: BorderRadius.circular(20)),
          child: Row(
            children: [
              IconButton(
                  onPressed: () => isColorSizeSelected
                      ? quantity < limitqunatity()!
                          ? ref
                              .read(quantityNotifierProvider.notifier)
                              .addQuantity()
                          : () {}
                      : showSnackbar(
                          context: context,
                          text: 'Please Select Both Color And Size'),
                  icon: const Icon(Icons.add)),
              Text(
                quantity.toString(),
                style: const TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.bold,
                    color: Colors.black),
              ),
              IconButton(
                  onPressed: () => isColorSizeSelected
                      ? ref
                          .read(quantityNotifierProvider.notifier)
                          .decreaseQuantity()
                      : showSnackbar(
                          context: context,
                          text: 'Please Select Both Color And Size'),
                  icon: const Icon(Icons.remove)),
            ],
          ),
        ),
        selectedColor != null && selectedSizes != null
            ? Center(
                child: AsyncValueWidget(
                  value: ref.watch(getQuantityProvider(
                      colorId: selectedColor.id,
                      productid: productId,
                      sizeId: selectedSizes.id)),
                  data: (p0) {
                    return p0 <= 0
                        ? Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 8.0),
                            child: Container(
                              height: 39,
                              width: 170,
                              decoration: BoxDecoration(
                                  color: Colors.red[400],
                                  borderRadius: BorderRadius.circular(20)),
                              child: const Center(
                                child: Text(
                                  "Sold Out",
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                          )
                        : Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              height: 39,
                              width: 170,
                              decoration: BoxDecoration(
                                  color: Colors.green[100],
                                  borderRadius: BorderRadius.circular(20)),
                              child: Center(
                                child: Text(
                                  "Only $p0 item Available",
                                  style: const TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ),
                          );
                  },
                ),
              )
            : const SizedBox.shrink()
      ],
    );
  }
}
