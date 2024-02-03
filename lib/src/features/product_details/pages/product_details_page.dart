// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:carousel_slider/carousel_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:go_router/go_router.dart';
import 'package:readmore/readmore.dart';
import 'package:sneako/src/core/helper/async_value_helper.dart';
import 'package:sneako/src/core/shared/loader.dart';
import 'package:sneako/src/features/cart/controllers/cart_controller.dart';
import 'package:sneako/src/features/cart/widgets/cart_icon.dart';
import 'package:sneako/src/features/favourite/controller/fav_controller.dart';
import 'package:sneako/src/features/product_details/providers/color_provider.dart';
import 'package:sneako/src/features/product_details/providers/product_attribute_provider.dart';
import 'package:sneako/src/features/product_details/providers/quantity_provider.dart';
import 'package:sneako/src/features/product_details/providers/size_provider.dart';
import 'package:sneako/src/features/product_details/repository/product_details_repository.dart';
import 'package:sneako/src/features/product_details/widgets/add-to_cart_BTN.dart';
import 'package:sneako/src/features/product_details/widgets/color_sizes_view.dart';
import 'package:sneako/src/features/product_details/widgets/product_image_carousel.dart';
import 'package:sneako/src/features/product_details/widgets/quantity_bar.dart';
import 'package:sneako/src/models/product.dart';
import 'package:sneako/src/router/router.dart';

class ProductDetailsPage extends ConsumerStatefulWidget {
  final int productId;

  final Product product;
  const ProductDetailsPage({
    super.key,
    required this.productId,
    required this.product,
  });

  @override
  ConsumerState<ProductDetailsPage> createState() => _ProductDetailsPageState();
}

class _ProductDetailsPageState extends ConsumerState<ProductDetailsPage> {
  late CarouselController carouselController;

  @override
  void initState() {
    super.initState();
    carouselController = CarouselController();
  }

  @override
  Widget build(BuildContext context) {
    final favState = ref.watch(favControllerProvider);
    final quantity = ref.watch(quantityNotifierProvider);

    final paS = ref.watch(selectedproductAttributeProvider);

    final addTocartState = ref.watch(cartControllerProvider);
    return SafeArea(
      child: Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          automaticallyImplyLeading: false,
          leading: IconButton(
              onPressed: () {
                ref.invalidate(colorSelectorNotifierProvider);
                ref.invalidate(sizeSelectorNotifierProvider);
                context.pop();
              },
              icon: const Icon(
                Icons.arrow_back_ios,
              )),
          actions: [
            IconButton(
                onPressed: () async {
                  context.pushNamed(AppRoutes.cart.name);
                },
                icon: const CartIcon())
          ],
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ProductImageCarousel(
                    productId: widget.productId,
                    carouselController: carouselController),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      widget.product.title,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                          fontSize: 25, fontWeight: FontWeight.bold),
                    ),
                    favState.isLoading
                        ? loader()
                        : AsyncValueWidget(
                            value: ref.watch(isFavAlreadyProvider(
                                productId: widget.product.id)),
                            data: (p0) => p0
                                ? IconButton(
                                    onPressed: () {
                                      ref
                                          .read(favControllerProvider.notifier)
                                          .unFavProduct(
                                              productId: widget.product.id);
                                    },
                                    icon: const Icon(
                                      AntDesign.heart,
                                      color: Colors.red,
                                      size: 30,
                                    ),
                                  )
                                : IconButton(
                                    onPressed: () {
                                      ref
                                          .read(favControllerProvider.notifier)
                                          .favProduct(
                                              productId: widget.product.id);
                                    },
                                    icon: const Icon(
                                      Feather.heart,
                                      size: 30,
                                    ),
                                  ),
                          ),
                  ],
                ),
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(7),
                      decoration: BoxDecoration(
                          color: const Color.fromARGB(255, 200, 204, 200),
                          borderRadius: BorderRadius.circular(10)),
                      child: Center(
                        child: Text(
                          '1250 Sold ',
                          style: TextStyle(
                              fontSize: 14, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                    const Text(
                      ' | ',
                      style:
                          TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
                    ),
                    const Icon(
                      Icons.star_half_rounded,
                    ),
                    const Text(
                      '4.50 ',
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const Text(
                      '(6,5734 Reviews)',
                      style:
                          TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                const Text(
                  'Description',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                ReadMoreText(
                  widget.product.description,
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                  ),
                  trimLines: 2,
                  colorClickableText: Colors.black,
                  trimMode: TrimMode.Line,
                  trimCollapsedText: 'Show more',
                  trimExpandedText: 'Show less',
                  moreStyle: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                  lessStyle: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 10),
                AsyncValueWidget(
                    value:
                        ref.watch(getProductImagesProvider(widget.productId)),
                    data: (p0) {
                      return ColorSizeListView(
                        productImages: p0,
                        productId: widget.productId,
                        carouselController: carouselController,
                      );
                    }),
                const SizedBox(height: 15),
                QuantityBar(productId: widget.productId),
                const SizedBox(height: 10),
                const Divider(thickness: 2, color: Color.fromARGB(31, 0, 0, 0)),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Total Price',
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 14,
                              fontWeight: FontWeight.bold),
                        ),
                        Text(
                          "\$${widget.product.mainPrice * quantity}.00",
                          style: const TextStyle(
                              fontSize: 28, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    addTocartState.isLoading
                        ? Container(
                            padding: EdgeInsets.zero,
                            height: 50,
                            width: 220,
                            decoration: const BoxDecoration(
                                color: Colors.black,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(30))),
                            child: const Center(
                              child: Text(
                                "Adding...",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 17,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          )
                        : addTocartState.hasError
                            ? Container(
                                padding: EdgeInsets.zero,
                                height: 50,
                                width: 220,
                                decoration: const BoxDecoration(
                                    color: Colors.black,
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(30))),
                                child: const Text(
                                  "error, can't add",
                                  style: TextStyle(color: Colors.white),
                                ),
                              )
                            : ATCButton(productId: widget.productId)
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
