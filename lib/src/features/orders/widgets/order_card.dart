// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

import 'package:sneako/src/core/shared/custom_snackbar.dart';
import 'package:sneako/src/models/order.dart';
import 'package:sneako/src/router/router.dart';

class OrderCard extends ConsumerWidget {
  final ProductOrder order;
  const OrderCard({
    super.key,
    required this.order,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    String formattedDate =
        DateFormat('h:mm a, MM/dd/yy').format(order.order_date!);
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Container(
        padding: const EdgeInsets.all(15),
        decoration: BoxDecoration(
            color: const Color.fromARGB(19, 0, 0, 0),
            borderRadius: BorderRadius.circular(20)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Text(
                  " OrderId: ",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                ),
                SizedBox(
                  width: 130,
                  child: Text(
                    order.id.toString(),
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                        fontWeight: FontWeight.w600,
                        color: Colors.black54,
                        fontSize: 16),
                  ),
                ),
                IconButton(
                  padding: EdgeInsets.zero,
                  onPressed: () async {
                    await Clipboard.setData(
                        ClipboardData(text: order.id.toString()));
                    showSnackbar(
                        context: context, text: "Copied To your Clipboard");
                  },
                  icon: const Icon(
                    FontAwesome5Regular.copy,
                    color: Colors.green,
                  ),
                ),
                const SizedBox(width: 40),
              ],
            ),
            Text(
              'Ordered: $formattedDate',
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "\$${order.order_total}",
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 25),
                ),
                ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.black,
                      minimumSize: const Size(30, 40),
                    ),
                    onPressed: () {
                      context.pushNamed(AppRoutes.orderDetails.name,
                          pathParameters: {'id': order.id.toString()},
                          extra: order);
                    },
                    child: const Text(
                      "Show Details",
                      style: TextStyle(color: Colors.white),
                    ))
              ],
            ),
          ],
        ),
      ),
    );
  }
}
