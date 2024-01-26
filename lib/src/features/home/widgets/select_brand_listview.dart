import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sneako/src/core/constants/defaults.dart';
import 'package:sneako/src/core/helper/async_value_helper.dart';
import 'package:sneako/src/features/home/providers/selected_category_provider.dart';
import 'package:sneako/src/features/home/repository/home_repository.dart';
import 'package:sneako/src/models/brand.dart';

class SelectbrandListView extends ConsumerWidget {
  const SelectbrandListView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedBrand = ref.watch(selectedCategoryNotifierProvider);
    return AsyncValueWidget(
      value: ref.watch(getBrandsProvider),
      data: (p0) {
        List<Brand> brands = [Defaults.defaultbrand];

        brands.addAll(p0);
        return SizedBox(
          height: 50,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: brands.length,
            itemBuilder: (context, index) {
              final brand = brands[index];
              final isSelected = selectedBrand == brand;
              return Padding(
                padding: const EdgeInsets.only(right: 8.0),
                child: GestureDetector(
                  onTap: () => ref
                      .read(selectedCategoryNotifierProvider.notifier)
                      .selectBrand(brand: brand),
                  child: Chip(
                    backgroundColor: isSelected ? Colors.black : Colors.white,
                    labelStyle: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: isSelected ? Colors.white : Colors.black),
                    side: const BorderSide(width: 2),
                    shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(15))),
                    label: SizedBox(
                      height: 20,
                      width: 50,
                      child: Center(child: Text(brand.name)),
                    ),
                  ),
                ),
              );
            },
          ),
        );
      },
    );
  }
}
