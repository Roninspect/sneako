import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:sneako/src/core/shared/custom_snackbar.dart';
import 'package:sneako/src/features/checkout/repository/checkout_repository.dart';
import 'package:sneako/src/models/address.dart';

final checkoutControllerProvider =
    StateNotifierProvider<CheckoutController, bool>((ref) {
  return CheckoutController(
      ref: ref, checkoutRepository: ref.watch(checkoutRepositoryProvider));
});

final getAddressProvider =
    FutureProvider.family<List<Address>, String>((ref, uid) async {
  return ref.watch(checkoutControllerProvider.notifier).getAddress(uid: uid);
});
final getDefaultAddressProvider =
    FutureProvider.family<Address?, String>((ref, uid) async {
  return ref
      .watch(checkoutControllerProvider.notifier)
      .getDefaultAddress(uid: uid);
});

class CheckoutController extends StateNotifier<bool> {
  final CheckoutRepository _checkoutRepository;
  final Ref _ref;

  CheckoutController(
      {required CheckoutRepository checkoutRepository, required Ref ref})
      : _checkoutRepository = checkoutRepository,
        _ref = ref,
        super(false);

  Future<List<Address>> getAddress({required String uid}) async {
    try {
      return await _checkoutRepository.getAddress(uid: uid);
    } catch (e) {
      throw e.toString();
    }
  }

  Future<Address?> getDefaultAddress({required String uid}) async {
    try {
      return await _checkoutRepository.getDefaultAddress(uid: uid);
    } catch (e) {
      throw e.toString();
    }
  }

  Future<void> addAddress({
    required String name,
    required String address,
    required String uid,
    required BuildContext context,
    required bool isAddingFirstTime,
  }) async {
    state = true;
    final newAddress = isAddingFirstTime == true
        ? Address(uid: uid, name: name, address: address, isDefault: true)
        : Address(uid: uid, name: name, address: address, isDefault: false);
    final res = await _checkoutRepository.addAddress(address: newAddress);
    state = false;
    res.fold(
      (l) {
        showSnackbar(context: context, text: l.message);
      },
      (r) {
        context.pop();
        _ref.invalidate(getAddressProvider);
      },
    );
  }

  Future<void> updateAddress({
    required String name,
    required int addId,
    required String address,
    required String uid,
    required bool isDefault,
    required BuildContext context,
  }) async {
    if (isDefault == true) {
      state = true;
      final updatedAddress = Address(
          uid: uid,
          name: name,
          address: address,
          isDefault: isDefault,
          id: addId);
      final res = await _checkoutRepository.makeDeafultFalse(uid: uid);

      res.fold((l) => showSnackbar(context: context, text: l.message),
          (r) async {
        final updateREs =
            await _checkoutRepository.updateAddress(address: updatedAddress);
        updateREs.fold((l) => showSnackbar(context: context, text: l.message),
            (r) {
          context.pop();
          _ref.invalidate(getDefaultAddressProvider);
          _ref.invalidate(getAddressProvider);
        });
        state = false;
      });
    } else {
      state = true;
      final updatedAddress = Address(
          uid: uid,
          name: name,
          address: address,
          isDefault: isDefault,
          id: addId);
      final res =
          await _checkoutRepository.updateAddress(address: updatedAddress);

      res.fold((l) => showSnackbar(context: context, text: l.message), (r) {
        context.pop();
        _ref.invalidate(getDefaultAddressProvider);
        _ref.invalidate(getAddressProvider);
      });

      state = false;
    }
  }
}
