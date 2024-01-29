import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:sneako/src/features/product_details/providers/color_provider.dart';
import 'package:sneako/src/features/product_details/providers/size_provider.dart';
import 'package:sneako/src/models/product_attributes.dart';

final selectedproductAttributeProvider =
    NotifierProvider<ProductAttributeNotifier, ProductAttribute?>(
        ProductAttributeNotifier.new);

class ProductAttributeNotifier extends Notifier<ProductAttribute?> {
  @override
  build() {
    return null;
  }

  void selectProductAttribute({
    required List<ProductAttribute> productAttributes,
  }) {
    final selectedColor =
        ref.watch(colorSelectorNotifierProvider.select((value) => value!.id));

    final selectedSizes =
        ref.watch(sizeSelectorNotifierProvider.select((value) => value!.id));

    state = productAttributes.firstWhere((element) =>
        element.colors.id == selectedColor &&
        element.sizes.id == selectedSizes);
  }
}
