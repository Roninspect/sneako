import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpdart/fpdart.dart';
import 'package:go_router/go_router.dart';
import 'package:quickalert/quickalert.dart';
import 'package:sneako/src/core/shared/custom_snackbar.dart';
import 'package:sneako/src/features/cart/controllers/cart_controller.dart';
import 'package:sneako/src/features/checkout/providers/selected_address.dart';
import 'package:sneako/src/features/checkout/repository/checkout_repository.dart';
import 'package:sneako/src/features/orders/repository/order_repository.dart';
import 'package:sneako/src/models/address.dart';
import 'package:sneako/src/models/order.dart';
import 'package:sneako/src/models/order_line.dart';

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
          // _ref
          //     .read(selectedAddressNotifierProvider.notifier)
          //     .selectAddress(selectAddress: updatedAddress);
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
        _ref
            .read(selectedAddressNotifierProvider(updatedAddress).notifier)
            .selectAddress(selectAddress: updatedAddress);
        _ref.invalidate(getDefaultAddressProvider);
        _ref.invalidate(getAddressProvider);
      });

      state = false;
    }
  }

  Future<void> addOrder(
      {required ProductOrder order,
      required BuildContext context,
      required List<OrderLine> orderlines}) async {
    state = true;
    final res = await _checkoutRepository.addOrder(order: order);

    res.fold((l) => showSnackbar(context: context, text: l.message), (r) async {
      await _ref
          .watch(checkoutControllerProvider.notifier)
          .addInitialOrderStatus(orderId: order.id!, context: context);

      for (var singleOrder in orderlines) {
        final ores =
            await _checkoutRepository.addOrderLine(orderLine: singleOrder);

        ores.fold(
            (l) => QuickAlert.show(
                context: context,
                type: QuickAlertType.error,
                text: l.message), (r) async {
          await _ref.read(cartControllerProvider.notifier).emptyCart();
          QuickAlert.show(
              onConfirmBtnTap: () {
                context.pop();
                context.pop();
              },
              barrierDismissible: false,
              confirmBtnColor: Colors.grey[300]!,
              confirmBtnText: "Back to Home",
              confirmBtnTextStyle: TextStyle(color: Colors.black),
              context: context,
              type: QuickAlertType.success,
              widget: ElevatedButton(
                  onPressed: () {}, child: Text("View My Order")));
        });
      }
      _ref.invalidate(getActiveOrdersProvider);
      state = false;
    });
  }

  Future<void> addInitialOrderStatus({
    required String orderId,
    required BuildContext context,
  }) async {
    final res =
        await _checkoutRepository.addInitialOrderStatus(orderId: orderId);

    res.fold((l) => print(l.message), (r) => null);
  }
}
