import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sneako/src/core/constants/defaults.dart';
import 'package:sneako/src/core/helper/async_value_helper.dart';
import 'package:sneako/src/features/home/repository/home_repository.dart';

class BrandListView extends ConsumerWidget {
  const BrandListView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return AsyncValueWidget(
      value: ref.watch(getBrandsProvider),
      data: (brands) {
        final modifiedBrands = [...brands, Defaults.morebrand];
        return SizedBox(
          height: 200,
          child: GridView.builder(
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 4, mainAxisSpacing: 10),
            itemCount: modifiedBrands.length,
            itemBuilder: (context, index) {
              final brand = modifiedBrands[index];
              return InkWell(
                onTap: () {},
                child: Column(
                  children: [
                    CircleAvatar(
                      radius: 31,
                      backgroundColor: const Color.fromARGB(255, 209, 209, 209),
                      child: SizedBox(
                        width: 40,
                        child: CachedNetworkImage(
                          cacheKey: brand.id.toString(),
                          imageUrl: brand.logo,
                        ),
                      ),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      brand.name,
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    )
                  ],
                ),
              );
            },
          ),
        );
      },
    );
  }
}
