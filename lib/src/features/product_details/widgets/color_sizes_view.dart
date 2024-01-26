// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:carousel_slider/carousel_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:sneako/src/core/helper/async_value_helper.dart';
import 'package:sneako/src/core/shared/custom_snackbar.dart';
import 'package:sneako/src/features/product_details/providers/available_sizes_provider.dart';
import 'package:sneako/src/features/product_details/providers/carousel_index_provider.dart';
import 'package:sneako/src/features/product_details/providers/color_provider.dart';
import 'package:sneako/src/features/product_details/providers/size_provider.dart';
import 'package:sneako/src/features/product_details/repository/product_details_repository.dart';
import 'package:sneako/src/models/product_image.dart';

class ColorSizeListView extends ConsumerWidget {
  final int productId;
  final CarouselController carouselController;
  final List<ProductImage> productImages;
  const ColorSizeListView({
    super.key,
    required this.productId,
    required this.carouselController,
    required this.productImages,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedColor = ref.watch(colorSelectorNotifierProvider);
    final selectedSizes = ref.watch(sizeSelectorNotifierProvider);

    final availableSizes = ref.watch(availableSizesListNotifierProvider);
    return AsyncValueWidget(
      value: ref.watch(productAttributeProvider(productId)),
      data: (p0) {
        Set<String> uniqueColorCodes = <String>{};

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Color',
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: 60,
                      width: 120,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: p0.length,
                        itemBuilder: (context, index) {
                          final productAttribute = p0[index];
                          final colorCode = productAttribute.colors.colorCode;

                          if (!uniqueColorCodes.contains(colorCode)) {
                            // Add the color code to the set to ensure uniqueness
                            uniqueColorCodes.add(colorCode);

                            return GestureDetector(
                              onTap: () {
                                ref
                                    .read(
                                        colorSelectorNotifierProvider.notifier)
                                    .selectColor(
                                        carouselController: carouselController,
                                        selectedColor: productAttribute.colors);

                                ref
                                    .read(availableSizesListNotifierProvider
                                        .notifier)
                                    .filterAvailableSizes(attributes: p0);

                                ref
                                    .read(carouselIndexNotifierProvider(
                                            carouselController)
                                        .notifier)
                                    .changeIndexFromColorSelection(
                                      productImages: productImages,
                                    );
                              },
                              child: Padding(
                                padding: const EdgeInsets.only(right: 8.0),
                                child: CircleAvatar(
                                  backgroundColor: Color(int.parse(colorCode)),
                                  child:
                                      selectedColor == productAttribute.colors
                                          ? const Icon(
                                              Icons.done,
                                              color: Colors.white,
                                            )
                                          : null,
                                ),
                              ),
                            );
                          } else {
                            // Return an empty container for duplicate color codes
                            return const SizedBox.shrink();
                          }
                        },
                      ),
                    ),
                  ],
                ),
                selectedColor != null
                    ? Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Text(
                            'Size',
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                          SizedBox(
                            height: 60,
                            width: 200,
                            child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: availableSizes.length,
                              itemBuilder: (context, index) {
                                final productAttribute = availableSizes[index];
                                return Padding(
                                  padding: const EdgeInsets.only(right: 5.0),
                                  child: GestureDetector(
                                    onTap: () {
                                      ref
                                          .read(sizeSelectorNotifierProvider
                                              .notifier)
                                          .selectSize(
                                              selectedSize: productAttribute);
                                    },
                                    child: CircleAvatar(
                                      radius: 20,
                                      backgroundColor: Colors.black,
                                      child: CircleAvatar(
                                        radius: 18,
                                        backgroundColor:
                                            selectedSizes == productAttribute
                                                ? Colors.black
                                                : Colors.white,
                                        child: Text(
                                          productAttribute.size.toString(),
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              color: selectedSizes ==
                                                      productAttribute
                                                  ? Colors.white
                                                  : Colors.black),
                                        ),
                                      ),
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                        ],
                      )
                    : Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Text(
                            'Size',
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                          SizedBox(
                            height: 60,
                            width: 200,
                            child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: p0.length,
                              itemBuilder: (context, index) {
                                final productAttribute = p0[index];
                                return Padding(
                                  padding: const EdgeInsets.only(right: 5.0),
                                  child: GestureDetector(
                                    onTap: () {
                                      selectedColor != null
                                          ? ref
                                              .read(sizeSelectorNotifierProvider
                                                  .notifier)
                                              .selectSize(
                                                  selectedSize:
                                                      productAttribute.sizes)
                                          : showSnackbar(
                                              context: context,
                                              text:
                                                  'Select Your Preferred Color First');
                                    },
                                    child: CircleAvatar(
                                      radius: 20,
                                      backgroundColor: Colors.black,
                                      child: CircleAvatar(
                                        radius: 18,
                                        backgroundColor: selectedSizes ==
                                                productAttribute.sizes
                                            ? Colors.black
                                            : Colors.white,
                                        child: Text(
                                          productAttribute.sizes.size
                                              .toString(),
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              color: selectedSizes ==
                                                      productAttribute.sizes
                                                  ? Colors.white
                                                  : Colors.black),
                                        ),
                                      ),
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                        ],
                      ),
              ],
            ),
          ],
        );
      },
    );
  }
}
