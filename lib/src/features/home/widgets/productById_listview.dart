import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:go_router/go_router.dart';
import 'package:sneako/src/core/helper/async_value_helper.dart';
import 'package:sneako/src/core/shared/loader.dart';
import 'package:sneako/src/features/auth/provider/user_data_notifer.dart';
import 'package:sneako/src/features/home/providers/selected_category_provider.dart';
import 'package:sneako/src/features/home/repository/home_repository.dart';
import 'package:sneako/src/router/router.dart';
import 'package:sneako/src/features/favourite/controller/fav_controller.dart';

class ProductByIdListView extends ConsumerWidget {
  const ProductByIdListView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(userDataNotifierProvider).valueOrNull;

    final selectedBrand = ref.watch(selectedCategoryNotifierProvider);
    return ref.watch(getProductByBrandProvider(selectedBrand.id)).when(
          data: (p0) {
            return p0.isEmpty
                ? const SizedBox(
                    height: 278,
                    child: Center(
                      child: Text('No Sneakers'),
                    ),
                  )
                : Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 8.0, horizontal: 10),
                    child: SizedBox(
                      height: 270,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: p0.length,
                        itemBuilder: (context, index) {
                          final product = p0[index];

                          return GestureDetector(
                            onTap: () => context.pushNamed(
                                AppRoutes.product.name,
                                pathParameters: {'id': product.id.toString()},
                                extra: product),
                            child: SizedBox(
                              width: 150,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Stack(
                                    alignment: Alignment.topRight,
                                    children: [
                                      Image.network(
                                        product.background,
                                        height: 150,
                                      ),
                                      user == null
                                          ? loader()
                                          : ref
                                                  .watch(favControllerProvider)
                                                  .isLoading
                                              ? loader()
                                              : AsyncValueWidget(
                                                  value: ref.watch(
                                                      isFavAlreadyProvider(
                                                          productId:
                                                              product.id)),
                                                  data: (p0) => p0
                                                      ? IconButton(
                                                          onPressed: () {
                                                            ref
                                                                .read(favControllerProvider
                                                                    .notifier)
                                                                .unFavProduct(
                                                                    productId:
                                                                        product
                                                                            .id);
                                                          },
                                                          icon:
                                                              const CircleAvatar(
                                                            radius: 15,
                                                            backgroundColor:
                                                                Colors.black,
                                                            child: Icon(
                                                              Icons.favorite,
                                                              size: 20,
                                                              color: Colors.red,
                                                            ),
                                                          ),
                                                        )
                                                      : IconButton(
                                                          onPressed: () {
                                                            ref
                                                                .read(favControllerProvider
                                                                    .notifier)
                                                                .favProduct(
                                                                    productId:
                                                                        product
                                                                            .id);
                                                          },
                                                          icon:
                                                              const CircleAvatar(
                                                            radius: 15,
                                                            backgroundColor:
                                                                Colors.black,
                                                            child: Icon(
                                                              Icons
                                                                  .favorite_border,
                                                              size: 20,
                                                              color:
                                                                  Colors.white,
                                                            ),
                                                          )),
                                                ),
                                    ],
                                  ),
                                  const SizedBox(height: 5),
                                  Text(
                                    product.title,
                                    overflow: TextOverflow.ellipsis,
                                    style: const TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  const SizedBox(height: 10),
                                  Row(
                                    children: [
                                      const Icon(Icons.star_half_rounded),
                                      const Text(
                                        '4.50',
                                        style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      const Text(
                                        ' | ',
                                        style: TextStyle(
                                            fontSize: 17,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      Container(
                                        padding: const EdgeInsets.all(4),
                                        decoration: BoxDecoration(
                                            color: const Color.fromARGB(
                                                255, 200, 204, 200),
                                            borderRadius:
                                                BorderRadius.circular(10)),
                                        child: const Center(
                                          child: Text(
                                            '1250 Sold',
                                            style: TextStyle(
                                                fontSize: 14,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                  const SizedBox(height: 5),
                                  Text(
                                    '\$${product.mainPrice}.00',
                                    style: const TextStyle(
                                        fontSize: 21,
                                        letterSpacing: 0,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  );
          },
          error: (error, stackTrace) => Center(
            child: Text(error.toString()),
          ),
          loading: () => const SizedBox(
            height: 270,
            child: Center(
              child: CircularProgressIndicator(
                color: Colors.black,
              ),
            ),
          ),
        );
  }
}
