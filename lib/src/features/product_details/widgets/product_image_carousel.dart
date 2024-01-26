// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:carousel_slider/carousel_controller.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import 'package:sneako/src/core/helper/async_value_helper.dart';
import 'package:sneako/src/core/shared/loader.dart';
import 'package:sneako/src/features/product_details/providers/carousel_index_provider.dart';
import 'package:sneako/src/features/product_details/repository/product_details_repository.dart';

class ProductImageCarousel extends ConsumerWidget {
  final int productId;
  final CarouselController carouselController;
  const ProductImageCarousel({
    super.key,
    required this.productId,
    required this.carouselController,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final carouselIndex =
        ref.watch(carouselIndexNotifierProvider(carouselController));

    return ref.watch(getProductImagesProvider(productId)).when(
        data: (data) => AsyncValueWidget(
              value: ref.watch(getProductImagesProvider(productId)),
              data: (p0) {
                return Column(
                  children: [
                    CarouselSlider.builder(
                      carouselController: carouselController,
                      itemCount: p0.length,
                      itemBuilder: (context, index, realIndex) {
                        final image = p0[index];

                        return Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            AspectRatio(
                              aspectRatio: 16 / 9,
                              child: Image.network(image.image),
                            ),
                          ],
                        );
                      },
                      options: CarouselOptions(
                        onPageChanged: (index, reason) {
                          ref
                              .read(carouselIndexNotifierProvider(
                                      carouselController)
                                  .notifier)
                              .changeIndex(index);
                        },
                        enableInfiniteScroll: false,
                        height: 395,
                      ),
                    ),
                    AnimatedSmoothIndicator(
                      effect: const ExpandingDotsEffect(
                          dotHeight: 10,
                          dotColor: Colors.black45,
                          dotWidth: 10,
                          activeDotColor: Colors.black),
                      activeIndex: carouselIndex,
                      count: p0.length,
                      onDotClicked: (index) {
                        ref
                            .read(carouselIndexNotifierProvider(
                                    carouselController)
                                .notifier)
                            .changeIndex(index);
                        carouselController.animateToPage(index);
                      },
                    )
                  ],
                );
              },
            ),
        loading: () => SizedBox(height: 300, child: Center(child: loader())),
        error: (error, stackTrace) {
          print(error);
          print(stackTrace);
          return Center(
            child: Text(
              error.toString(),
              style: Theme.of(context)
                  .textTheme
                  .titleLarge!
                  .copyWith(color: Colors.red),
            ),
          );
        });
  }
}
