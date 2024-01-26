// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:sneako/src/models/size.dart';

final sizeSelectorNotifierProvider =
    NotifierProvider<SizeSelectorNotifier, ProductSize?>(
        SizeSelectorNotifier.new);

class SizeSelectorNotifier extends Notifier<ProductSize?> {
  @override
  build() {
    return null;
  }

  void selectSize({required ProductSize selectedSize}) {
    if (state == selectedSize) {
      state = null;
    } else {
      state = selectedSize;
    }
  }

  void setnull() {
    state = null;
  }
}
