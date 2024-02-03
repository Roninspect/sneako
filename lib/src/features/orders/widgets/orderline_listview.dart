// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:sneako/src/core/helper/async_value_helper.dart';
import 'package:sneako/src/features/orders/repository/order_repository.dart';
import 'package:sneako/src/features/orders/widgets/orderline_image.dart';
import 'package:sneako/src/models/order_line.dart';
import 'package:sneako/src/models/product_attributes.dart';

class OrderlineListview extends ConsumerWidget {
  final String orderId;
  const OrderlineListview({
    super.key,
    required this.orderId,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return AsyncValueWidget(
      value: ref.watch(getOrderlinesProvider(orderId: orderId)),
      data: (orderLines) => ListView.builder(
        shrinkWrap: true,
        itemCount: orderLines.length,
        itemBuilder: (context, index) {
          final OrderLine orderLine = orderLines[index];
          final ProductAttribute productAttribute = orderLine.productAttribute!;
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: const Color.fromARGB(10, 0, 0, 0)),
              child: Row(
                children: [
                  OrderlineImage(productAttribute: productAttribute),
                  const SizedBox(width: 10),
                  AsyncValueWidget(
                    value: ref.watch(getProductByIdProvider(
                        orderLine.productAttribute!.productId)),
                    data: (product) => Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          product.title,
                          style: const TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 5),
                        Row(
                          children: [
                            Row(
                              children: [
                                CircleAvatar(
                                  radius: 8,
                                  backgroundColor: Color(int.parse(
                                      productAttribute.colors!.colorCode)),
                                ),
                                const SizedBox(width: 5),
                                Text(
                                  "${productAttribute.colors!.name} | ",
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black45),
                                ),
                                Text(
                                  "Size - ${productAttribute.sizes!.size} | ",
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black45),
                                ),
                                Text(
                                  "Qty - ${orderLine.quantity}",
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black45),
                                ),
                              ],
                            )
                          ],
                        ),
                        const SizedBox(height: 5),
                        Text(
                          "\$${orderLine.price} x ${orderLine.quantity}",
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
