import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sneako/src/core/constants/defaults.dart';
import 'package:sneako/src/models/brand.dart';

final selectedCategoryNotifierProvider =
    NotifierProvider<SelectedCategoryNotifier, Brand>(
        SelectedCategoryNotifier.new);

class SelectedCategoryNotifier extends Notifier<Brand> {
  @override
  build() {
    return Defaults.defaultbrand;
  }

  void selectBrand({required Brand brand}) {
    state = brand;
  }
}
