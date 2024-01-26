import 'package:flutter_riverpod/flutter_riverpod.dart';

final isDefaultNotifierProvider =
    NotifierProvider<IsDefaultNotifier, bool>(IsDefaultNotifier.new);

class IsDefaultNotifier extends Notifier<bool> {
  @override
  build() {
    return false;
  }

  void isDefault({required bool isDefault}) {
    state = isDefault;
  }
}
