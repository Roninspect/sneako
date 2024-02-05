import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sneako/src/core/helper/async_value_helper.dart';
import 'package:sneako/src/features/auth/provider/user_data_notifer.dart';
import 'package:sneako/src/features/orders/repository/order_repository.dart';
import 'package:sneako/src/features/orders/widgets/order_card.dart';
import 'package:sneako/src/models/order.dart';

class CancelledOrderPage extends ConsumerWidget {
  const CancelledOrderPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final uid = ref.watch(userDataNotifierProvider).value!.id;
    final orderState = ref.watch(getCancelledOrdersProvider(uid: uid));
    return Scaffold(
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
                    child: Text("No Cancelled Orders"),
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
