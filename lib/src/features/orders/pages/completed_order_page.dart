import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sneako/src/core/helper/async_value_helper.dart';
import 'package:sneako/src/features/auth/provider/user_data_notifer.dart';
import 'package:sneako/src/features/orders/repository/order_repository.dart';
import 'package:sneako/src/features/orders/widgets/order_card.dart';
import 'package:sneako/src/models/order.dart';

class CompletedOrderPage extends ConsumerWidget {
  const CompletedOrderPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final uid = ref.watch(userDataNotifierProvider).value!.id;

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12.0),
        child: AsyncValueWidget(
          value: ref.watch(getCompletedOrdersProvider(uid: uid)),
          data: (p0) {
            if (p0.isEmpty) {
              return const Center(
                child: Text("No Completed Orders"),
              );
            } else {
              return ListView.builder(
                itemCount: p0.length,
                itemBuilder: (context, index) {
                  final ProductOrder order = p0[index];
                  return OrderCard(order: order);
                },
              );
            }
          },
        ),
      ),
    );
  }
}
