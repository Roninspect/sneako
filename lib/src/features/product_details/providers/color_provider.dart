import 'package:carousel_slider/carousel_controller.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sneako/src/features/product_details/providers/carousel_index_provider.dart';
import 'package:sneako/src/features/product_details/providers/quantity_provider.dart';
import 'package:sneako/src/features/product_details/providers/size_provider.dart';
import 'package:sneako/src/models/color.dart';

final colorSelectorNotifierProvider =
    NotifierProvider<ColorSelectorNotifier, ProductColor?>(
        ColorSelectorNotifier.new);

class ColorSelectorNotifier extends Notifier<ProductColor?> {
  @override
  build() {
    return null;
  }

  void selectColor(
      {required ProductColor selectedColor,
      required CarouselController carouselController}) {
    if (state == selectedColor) {
      state = null;
      ref.read(sizeSelectorNotifierProvider.notifier).setnull();
      ref.invalidate(quantityNotifierProvider);
      ref
          .read(carouselIndexNotifierProvider(carouselController).notifier)
          .setnull();
    } else {
      state = selectedColor;
      ref.read(sizeSelectorNotifierProvider.notifier).setnull();
      ref.invalidate(quantityNotifierProvider);
    }
  }
}
