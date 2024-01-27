import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:sneako/src/core/helper/async_value_helper.dart';
import 'package:sneako/src/core/helper/custom_bottom_sheets.dart';
import 'package:sneako/src/features/auth/provider/user_data_notifer.dart';
import 'package:sneako/src/features/checkout/controller/checkout_controller.dart';
import 'package:sneako/src/features/checkout/providers/selected_address.dart';
import 'package:sneako/src/features/checkout/widgets/address_editable.dart';
import 'package:sneako/src/router/router.dart';

class AddressSection extends ConsumerWidget {
  const AddressSection({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final uid = ref.watch(userDataNotifierProvider.select((value) => value.id));
    return Column(
      children: [
        SizedBox(
          height: 100,
          child: AsyncValueWidget(
            value: ref.watch(getAddressProvider(uid)),
            data: (addresses) => AsyncValueWidget(
              value: ref.watch(getDefaultAddressProvider(uid)),
              data: (address) {
                if (address != null && addresses.length > 1) {
                  final selectedAddress =
                      ref.watch(selectedAddressNotifierProvider(address));
                  return AddressEditableCard(address: selectedAddress);
                } else if (addresses.isNotEmpty) {
                  return AddressEditableCard(address: addresses.first);
                } else {
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: GestureDetector(
                      onTap: () => CustomBottomSheets.displayAddAddressSheet(
                          isAddingFirstTime: true, context: context),
                      child: Container(
                        decoration: BoxDecoration(
                            color: const Color.fromARGB(36, 0, 0, 0),
                            borderRadius: BorderRadius.circular(20)),
                        child: const Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Text(
                              "Add A Delivery Address",
                              style: TextStyle(
                                  fontSize: 22, fontWeight: FontWeight.bold),
                            ),
                            Icon(
                              Icons.add_location_alt,
                              size: 35,
                            )
                          ],
                        ),
                      ),
                    ),
                  );
                }
              },
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 8.0),
          child: InkWell(
            onTap: () => context.pushNamed(AppRoutes.addresses.name),
            child: Container(
                width: 350,
                padding:
                    const EdgeInsets.symmetric(vertical: 15.0, horizontal: 15),
                decoration: BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.circular(20)),
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.add_location_alt_rounded, color: Colors.white),
                    SizedBox(width: 10),
                    Text(
                      'Select Other Addresses',
                      style: TextStyle(
                        fontSize: 15,
                        color: Colors.white,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                )),
          ),
        ),
      ],
    );
  }
}
