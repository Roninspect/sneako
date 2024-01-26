import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import 'package:sneako/src/core/helper/async_value_helper.dart';
import 'package:sneako/src/core/helper/custom_bottom_sheets.dart';
import 'package:sneako/src/features/auth/provider/user_data_notifer.dart';
import 'package:sneako/src/features/checkout/controller/checkout_controller.dart';
import 'package:sneako/src/features/checkout/providers/selected_address.dart';
import 'package:sneako/src/models/address.dart';

class AddressPage extends ConsumerWidget {
  const AddressPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final uid = ref.watch(userDataNotifierProvider.select((value) => value.id));
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            "Shipping Address",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
        body: AsyncValueWidget(
            value: ref.watch(getDefaultAddressProvider(uid)),
            data: (p0) {
              Address? selectedAddress;

              selectedAddress = ref.watch(selectedAddressNotifierProvider(p0!));

              return AsyncValueWidget(
                value: ref.watch(getAddressProvider(uid)),
                data: (addresses) => ListView.builder(
                  itemCount: addresses.length,
                  itemBuilder: (context, index) {
                    final Address address = addresses[index];

                    return Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 8.0, horizontal: 8.0),
                      child: Container(
                        height: 90,
                        padding: const EdgeInsets.symmetric(
                            vertical: 10.0, horizontal: 10),
                        decoration: BoxDecoration(
                            color: const Color.fromARGB(15, 0, 0, 0),
                            borderRadius: BorderRadius.circular(20)),
                        child: Row(
                          children: [
                            const CircleAvatar(
                              backgroundColor: Colors.black,
                              child:
                                  Icon(Icons.location_on, color: Colors.white),
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
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 7,
                                                      vertical: 3),
                                              decoration: BoxDecoration(
                                                  color: Colors.green,
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          10)),
                                              child: const Text(
                                                'Default',
                                                style: TextStyle(
                                                    fontSize: 14,
                                                    color: Colors.white,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                            ),
                                    ],
                                  ),
                                  SizedBox(
                                    width: 270,
                                    child: Text(
                                      address.address,
                                      style: TextStyle(
                                          fontSize: 14,
                                          overflow: TextOverflow.ellipsis,
                                          color: Colors.grey[800],
                                          fontWeight: FontWeight.w500),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            IconButton(
                              onPressed: () {
                                ref
                                    .read(selectedAddressNotifierProvider(p0)
                                        .notifier)
                                    .selectAddress(selectAddress: address);
                                Timer(const Duration(milliseconds: 400), () {
                                  context.pop();
                                });
                              },
                              icon: selectedAddress == address
                                  ? const CircleAvatar(
                                      radius: 14,
                                      backgroundColor: Colors.black,
                                      child: CircleAvatar(
                                        radius: 12,
                                        backgroundColor: Colors.white,
                                        child: CircleAvatar(
                                          radius: 10,
                                          backgroundColor: Colors.black,
                                        ),
                                      ),
                                    )
                                  : const CircleAvatar(
                                      radius: 12,
                                      backgroundColor: Colors.black,
                                      child: CircleAvatar(
                                        radius: 10,
                                        backgroundColor: Colors.white,
                                      ),
                                    ),
                            )
                          ],
                        ),
                      ),
                    );
                  },
                ),
              );
            }),
        floatingActionButton: FloatingActionButton.extended(
          backgroundColor: Colors.black,
          splashColor: const Color.fromARGB(17, 255, 255, 255),
          onPressed: () => CustomBottomSheets.displayAddAddressSheet(
              context: context, isAddingFirstTime: false),
          label: const Text(
            "Add New Address",
            style: TextStyle(color: Colors.white),
          ),
        ),
      ),
    );
  }
}
