import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sneako/src/features/orders/pages/Active_orders_page.dart';
import 'package:sneako/src/features/orders/pages/cancelled_orders_page.dart';
import 'package:sneako/src/features/orders/pages/completed_order_page.dart';

class OrderPage extends ConsumerWidget {
  const OrderPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("My Orders"),
      ),
      body: const DefaultTabController(
          length: 3,
          child: Column(
            children: [
              TabBar(
                  indicatorColor: Colors.black,
                  labelColor: Colors.black,
                  indicatorSize: TabBarIndicatorSize.tab,
                  tabs: [
                    Tab(
                      child: Text(
                        "Active",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 16),
                      ),
                    ),
                    Tab(
                      child: Text(
                        "Completed",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                    ),
                    Tab(
                      child: Text(
                        "Cancelled",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ]),
              Expanded(
                  child: TabBarView(children: [
                ActiveOrderPage(),
                CompletedOrderPage(),
                CancelledOrderPage(),
              ]))
            ],
          )),
    );
  }
}
