// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:sneako/src/models/address.dart';

final selectedAddressNotifierProvider =
    StateNotifierProvider.family<SelectedAddressNotifier, Address, Address>(
        (ref, initalAddress) {
  return SelectedAddressNotifier(initalAddress: initalAddress);
});

class SelectedAddressNotifier extends StateNotifier<Address> {
  final Address initalAddress;
  SelectedAddressNotifier({
    required this.initalAddress,
  }) : super(initalAddress);

  void selectAddress({required Address selectAddress}) {
    state = selectAddress;
  }
}
