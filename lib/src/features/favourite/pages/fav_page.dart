import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:sneako/src/core/helper/async_value_helper.dart';
import 'package:sneako/src/features/favourite/controller/fav_controller.dart';
import 'package:sneako/src/models/product.dart';

class FavPage extends ConsumerWidget {
  const FavPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Favourites"),
      ),
      body: AsyncValueWidget(
          value: ref.watch(favControllerProvider),
          data: (p0) => ListView.builder(
                itemCount: p0.length,
                itemBuilder: (context, index) {
                  final fav = p0[index];
                  final Product product = fav.products!;
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
                            cacheKey: product.background,
                            imageUrl: product.background,
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
                                      product.title,
                                      style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 18),
                                    ),
                                    IconButton(
                                        onPressed: () {
                                          ref
                                              .read(favControllerProvider
                                                  .notifier)
                                              .deleteFav(favId: fav.id!);
                                        },
                                        icon: const Icon(
                                          MaterialCommunityIcons.delete_outline,
                                        ))
                                  ],
                                ),
                              ),
                              const SizedBox(height: 10),
                              Text(
                                '\$${product.mainPrice}',
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 20),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  );
                },
              )),
    );
  }
}
