import 'package:flutter_riverpod/flutter_riverpod.dart';

final quantityNotifierProvider =
    NotifierProvider.autoDispose<SelectedQuantityNotifier, int>(
        SelectedQuantityNotifier.new);

class SelectedQuantityNotifier extends AutoDisposeNotifier<int> {
  @override
  build() {
    return 1;
  }

  void addQuantity() {
    state++;
  }

  void decreaseQuantity() {
    if (state > 1) {
      state--;
    }
  }
}
