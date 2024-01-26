// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:sneako/src/core/helper/custom_bottom_sheets.dart';
import 'package:sneako/src/features/checkout/providers/isDefault_provider.dart';
import 'package:sneako/src/features/checkout/providers/selected_address.dart';

import 'package:sneako/src/models/address.dart';

class AddressEditableCard extends ConsumerWidget {
  final Address address;
  const AddressEditableCard({
    super.key,
    required this.address,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedAddress = ref.watch(selectedAddressNotifierProvider(address));
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 8.0),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 10),
        decoration: BoxDecoration(
            color: const Color.fromARGB(15, 0, 0, 0),
            borderRadius: BorderRadius.circular(20)),
        child: Row(
          children: [
            const CircleAvatar(
              backgroundColor: Colors.black,
              child: Icon(Icons.location_on, color: Colors.white),
            ),
            const SizedBox(width: 10),
            Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    children: [
                      Text(
                        address.name,
                        style: const TextStyle(
                            fontSize: 17,
                            color: Colors.black,
                            fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(width: 10),
                      !address.isDefault
                          ? const SizedBox.shrink()
                          : Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 7, vertical: 3),
                              decoration: BoxDecoration(
                                  color: Colors.green,
                                  borderRadius: BorderRadius.circular(10)),
                              child: const Text(
                                'Default',
                                style: TextStyle(
                                    fontSize: 14,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                    ],
                  ),
                  SizedBox(
                    width: 253,
                    child: Text(
                      selectedAddress.address,
                      style: const TextStyle(
                          fontSize: 15,
                          overflow: TextOverflow.ellipsis,
                          color: Colors.black,
                          fontWeight: FontWeight.w500),
                    ),
                  ),
                ],
              ),
            ),
            IconButton(
                onPressed: () {
                  ref
                      .read(isDefaultNotifierProvider.notifier)
                      .isDefault(isDefault: address.isDefault);
                  CustomBottomSheets.displayEditAddressSheet(
                      address: address, context: context);
                },
                icon: const Icon(
                  FontAwesome5Solid.edit,
                  size: 23,
                ))
          ],
        ),
      ),
    );
  }
}
