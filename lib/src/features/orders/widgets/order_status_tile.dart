// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:timeline_tile/timeline_tile.dart';

import 'package:sneako/src/core/helper/async_value_helper.dart';
import 'package:sneako/src/features/orders/repository/order_repository.dart';

class OrderStatusTile extends ConsumerWidget {
  final String orderId;
  const OrderStatusTile({
    super.key,
    required this.orderId,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return AsyncValueWidget(
      value: ref.watch(getOrderStatusByIdProvider(orderId)),
      data: (status) => Column(
        children: [
          SizedBox(
            height: 260,
            child: ListView(
              physics: NeverScrollableScrollPhysics(),
              children: [
                SizedBox(
                  height: 80,
                  child: TimelineTile(
                    isFirst: true,
                    afterLineStyle: LineStyle(
                        color:
                            status.ordered ? Colors.green : Colors.grey[400]!),
                    indicatorStyle: IndicatorStyle(
                        color:
                            status.ordered ? Colors.green : Colors.grey[400]!),
                    alignment: TimelineAlign.center,
                    startChild: Icon(
                      FontAwesome5Solid.box,
                      color: status.ordered ? Colors.black : Colors.grey[400]!,
                      size: 25,
                    ),
                    endChild: const Padding(
                      padding: EdgeInsets.only(top: 5.0, left: 10),
                      child: Text(
                        "Ordered",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 18),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 100,
                  child: TimelineTile(
                    alignment: TimelineAlign.center,
                    afterLineStyle: LineStyle(
                        color: status.inTransit
                            ? Colors.green
                            : Colors.grey[400]!),
                    beforeLineStyle: LineStyle(
                        color: status.inTransit
                            ? Colors.green
                            : Colors.grey[400]!),
                    indicatorStyle: IndicatorStyle(
                        color: status.inTransit
                            ? Colors.green
                            : Colors.grey[400]!),
                    startChild: Icon(
                      MaterialCommunityIcons.truck_delivery,
                      color:
                          status.inTransit ? Colors.black : Colors.grey[400]!,
                      size: 35,
                    ),
                    endChild: const Padding(
                      padding: EdgeInsets.only(top: 5.0, left: 10),
                      child: Text(
                        "In Delivery",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 18),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 100,
                  child: status.cancelled
                      ? TimelineTile(
                          isLast: true,
                          alignment: TimelineAlign.center,
                          beforeLineStyle: const LineStyle(color: Colors.red),
                          indicatorStyle:
                              const IndicatorStyle(color: Colors.red),
                          startChild: const CircleAvatar(
                            radius: 15,
                            backgroundColor: Colors.red,
                            child: Icon(
                              Icons.close,
                              color: Colors.white,
                              size: 20,
                            ),
                          ),
                          endChild: const Padding(
                            padding: EdgeInsets.only(top: 5.0, left: 10),
                            child: Text(
                              "Cancelled",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18,
                                  color: Colors.red),
                            ),
                          ),
                        )
                      : TimelineTile(
                          isLast: true,
                          alignment: TimelineAlign.center,
                          beforeLineStyle: LineStyle(
                              color: status.delivered
                                  ? Colors.green
                                  : Colors.grey[400]!),
                          indicatorStyle: IndicatorStyle(
                              color: status.delivered
                                  ? Colors.green
                                  : Colors.grey[400]!),
                          startChild: Icon(
                            FontAwesome5Solid.box_open,
                            color: status.delivered
                                ? Colors.black
                                : Colors.grey[400]!,
                            size: 27,
                          ),
                          endChild: const Padding(
                            padding: EdgeInsets.only(top: 5.0, left: 10),
                            child: Text(
                              "Delivered",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 18),
                            ),
                          ),
                        ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 10),
          Center(
            child: status.ordered &&
                    !status.cancelled &&
                    !status.inTransit &&
                    !status.delivered
                ? Container(
                    height: 70,
                    decoration: BoxDecoration(
                        color: Colors.green[100],
                        borderRadius: BorderRadius.circular(20)),
                    child: const Center(
                      child: Text(
                        "Just Ordered (Waiting for Pickup)",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 20),
                      ),
                    ),
                  )
                : status.ordered &&
                        status.inTransit &&
                        !status.cancelled &&
                        !status.delivered
                    ? Container(
                        height: 70,
                        decoration: BoxDecoration(
                            color: Colors.green[100],
                            borderRadius: BorderRadius.circular(20)),
                        child: const Center(
                            child: Text(
                          "Order is in Delivery",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 20),
                        )),
                      )
                    : status.ordered &&
                            status.inTransit &&
                            status.delivered &&
                            !status.cancelled
                        ? Container(
                            height: 70,
                            decoration: BoxDecoration(
                                color: Colors.green[100],
                                borderRadius: BorderRadius.circular(20)),
                            child: const Center(
                              child: Text(
                                "Order Delivered Successfully",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 20),
                              ),
                            ))
                        : Container(
                            height: 70,
                            decoration: BoxDecoration(
                                color: Colors.red[400],
                                borderRadius: BorderRadius.circular(20)),
                            child: Center(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Text(
                                    "Order Cancelled",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 20),
                                  ),
                                  Text(
                                    "Reason: ${status.reason}",
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 20),
                                  ),
                                ],
                              ),
                            ),
                          ),
          ),
        ],
      ),
    );
  }
}
