// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:sneako/src/core/shared/custom_snackbar.dart';

import 'package:sneako/src/features/auth/provider/user_data_notifer.dart';
import 'package:sneako/src/features/checkout/controller/checkout_controller.dart';
import 'package:sneako/src/features/checkout/providers/isDefault_provider.dart';
import 'package:sneako/src/models/address.dart';

import '../../../core/helper/async_value_helper.dart';

class EditAddressPage extends ConsumerStatefulWidget {
  final Address address;
  const EditAddressPage({
    super.key,
    required this.address,
  });

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _EditAddressPageState();
}

class _EditAddressPageState extends ConsumerState<EditAddressPage> {
  late TextEditingController nameController;
  late TextEditingController addressController;

  @override
  void initState() {
    nameController = TextEditingController(text: widget.address.name);
    addressController = TextEditingController(text: widget.address.address);
    super.initState();
  }

  @override
  void dispose() {
    nameController.dispose();
    addressController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final uid = ref.watch(userDataNotifierProvider.select((value) => value.id));

    final isSelected = ref.watch(isDefaultNotifierProvider);

    final isLoading = ref.watch(checkoutControllerProvider);
    return AsyncValueWidget(
        value: ref.watch(getAddressProvider(uid)),
        data: (addresses) => GestureDetector(
              onTap: () => FocusScope.of(context).unfocus(),
              child: Scaffold(
                body: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15.0),
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            IconButton(
                              onPressed: () => context.pop(),
                              icon: const Icon(
                                Icons.close,
                                size: 30,
                              ),
                            ),
                            const SizedBox(width: 65),
                            const Text(
                              "Edit Address",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                              ),
                            ),
                          ],
                        ),
                        const Divider(),
                        const Text(
                          "Address Type",
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 7),
                        TextField(
                          controller: nameController,
                          cursorColor: Colors.black,
                          maxLength: 25,
                          decoration: InputDecoration(
                            contentPadding: const EdgeInsets.all(15),
                            filled: true,
                            hintText: "Home, Office",
                            border: InputBorder.none,
                            fillColor: Colors.grey[300],
                          ),
                        ),
                        const SizedBox(height: 7),
                        const Text(
                          "Address Details",
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 5),
                        TextField(
                          controller: addressController,
                          cursorColor: Colors.black,
                          maxLength: 120,
                          maxLines: 4,
                          decoration: InputDecoration(
                            contentPadding: const EdgeInsets.all(15),
                            filled: true,
                            hintText:
                                "Floor #08, AK House, Block-C, Road #02, NYC",
                            border: InputBorder.none,
                            fillColor: Colors.grey[300],
                          ),
                        ),
                        addresses.length == 1 ||
                                widget.address.isDefault == true
                            ? const SizedBox.shrink()
                            : Row(
                                children: [
                                  IconButton(
                                    onPressed: () {
                                      ref
                                          .read(isDefaultNotifierProvider
                                              .notifier)
                                          .isDefault(isDefault: !isSelected);
                                    },
                                    icon: isSelected
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
                                  ),
                                  const Text(
                                    'Make this as a default address',
                                    style: TextStyle(
                                      fontSize: 17,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  )
                                ],
                              ),
                        Center(
                          child: SizedBox(
                            height: 45,
                            width: 150,
                            child: FloatingActionButton.extended(
                              backgroundColor: Colors.black,
                              splashColor:
                                  const Color.fromARGB(17, 255, 255, 255),
                              onPressed: () {
                                if (isSelected != widget.address.isDefault) {
                                  ref
                                      .read(checkoutControllerProvider.notifier)
                                      .updateAddress(
                                          addId: widget.address.id!,
                                          name: nameController.text.trim(),
                                          address:
                                              addressController.text.trim(),
                                          uid: uid,
                                          isDefault: isSelected,
                                          context: context);
                                } else {
                                  ref
                                      .read(checkoutControllerProvider.notifier)
                                      .updateAddress(
                                          addId: widget.address.id!,
                                          name: nameController.text.trim(),
                                          address:
                                              addressController.text.trim(),
                                          uid: uid,
                                          isDefault: widget.address.isDefault,
                                          context: context);
                                }
                              },
                              label: isLoading
                                  ? const CircularProgressIndicator(
                                      color: Colors.white)
                                  : const Text(
                                      "Update",
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 18),
                                    ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ));
  }
}
