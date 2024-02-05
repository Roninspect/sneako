// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import 'package:sneako/src/features/auth/provider/user_data_notifer.dart';
import 'package:sneako/src/features/checkout/controller/checkout_controller.dart';

class AddNewAddress extends ConsumerStatefulWidget {
  final bool isAddingFirstTime;
  const AddNewAddress({
    super.key,
    required this.isAddingFirstTime,
  });

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _AddNewAddressState();
}

class _AddNewAddressState extends ConsumerState<AddNewAddress> {
  TextEditingController nameController = TextEditingController();
  TextEditingController addressController = TextEditingController();

  @override
  void dispose() {
    nameController.dispose();
    addressController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final uid = ref.watch(userDataNotifierProvider).value!.id;
    final isLoading = ref.watch(checkoutControllerProvider);
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 05),
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
                      "Add New Address",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),
                  ],
                ),
                const Divider(),
                const SizedBox(height: 10),

                const Text(
                  "Address Type",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
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
                const SizedBox(height: 10),
                const Text(
                  "Address Details",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 7),
                TextField(
                  controller: addressController,
                  cursorColor: Colors.black,
                  maxLength: 120,
                  maxLines: 4,
                  decoration: InputDecoration(
                    contentPadding: const EdgeInsets.all(15),
                    filled: true,
                    hintText: "Floor #08, AK House, Block-C, Road #02, NYC",
                    border: InputBorder.none,
                    fillColor: Colors.grey[300],
                  ),
                ),
                const SizedBox(height: 20),
                Center(
                  child: SizedBox(
                    height: 60,
                    width: 300,
                    child: FloatingActionButton.extended(
                      backgroundColor: Colors.black,
                      splashColor: const Color.fromARGB(17, 255, 255, 255),
                      onPressed: () {
                        ref
                            .read(checkoutControllerProvider.notifier)
                            .addAddress(
                                name: nameController.text.trim(),
                                address: addressController.text.trim(),
                                uid: uid,
                                context: context,
                                isAddingFirstTime: widget.isAddingFirstTime);
                      },
                      label: isLoading
                          ? const CircularProgressIndicator(color: Colors.white)
                          : const Text(
                              "Add",
                              style:
                                  TextStyle(color: Colors.white, fontSize: 18),
                            ),
                    ),
                  ),
                ),

                // Row(
                //   children: [
                //     Checkbox(
                //       value: isSelected,
                //       onChanged: (value) {
                //         setState(() {
                //           isSelected = value!;
                //         });
                //       },
                //     ),
                //     const Text(
                //       "Make this as the default address",
                //       style: TextStyle(
                //         fontWeight: FontWeight.bold,
                //         fontSize: 16,
                //       ),
                //     ),
                //   ],
                // )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
