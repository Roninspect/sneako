import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:intl/intl.dart';
import 'package:sneako/src/core/helper/async_value_helper.dart';
import 'package:sneako/src/core/shared/custom_snackbar.dart';
import 'package:sneako/src/features/auth/provider/user_data_notifer.dart';
import 'package:sneako/src/features/orders/repository/order_repository.dart';
import 'package:sneako/src/features/orders/widgets/order_card.dart';
import 'package:sneako/src/models/order.dart';

class OrdersPage extends ConsumerWidget {
  const OrdersPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final uid = ref.watch(userDataNotifierProvider.select((value) => value.id));
    final orderState = ref.watch(getActiveOrdersProvider(uid: uid));
    final count = orderState.valueOrNull;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          count == null ? "My Orders" : "My Orders (${count.length})",
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12.0),
        child: AsyncValueWidget(
          value: orderState,
          data: (p0) {
            return ListView.builder(
              itemCount: p0.length,
              itemBuilder: (context, index) {
                if (p0.isEmpty) {
                  return const Center(
                    child: Text("No Active Orders"),
                  );
                } else {
                  final ProductOrder order = p0[index];
                  return OrderCard(order: order);
                }
              },
            );
          },
        ),
      ),
    );
  }
}
