import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sneako/src/features/product_details/providers/color_provider.dart';

import 'package:sneako/src/models/product_attributes.dart';
import 'package:sneako/src/models/size.dart';

final availableSizesListNotifierProvider =
    StateNotifierProvider<AvailableSizesListNotifier, List<ProductSize>>((ref) {
  return AvailableSizesListNotifier(ref: ref);
});

class AvailableSizesListNotifier extends StateNotifier<List<ProductSize>> {
  final Ref ref;
  AvailableSizesListNotifier({
    required this.ref,
  }) : super([]);

  void filterAvailableSizes({required List<ProductAttribute> attributes}) {
    final selectedColor = ref.watch(colorSelectorNotifierProvider);
    List<ProductSize> filteredList;

    if (selectedColor != null) {
      filteredList = attributes
          .where((element) => element.colors.id == selectedColor.id)
          .map((e) => e.sizes)
          .toList();
    } else {
      filteredList = [];
    }

    state = filteredList;
  }
}
