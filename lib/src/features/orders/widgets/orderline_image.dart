// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:sneako/src/core/helper/async_value_helper.dart';
import 'package:sneako/src/features/orders/repository/order_repository.dart';
import 'package:sneako/src/models/order_line.dart';
import 'package:sneako/src/models/product_attributes.dart';

class OrderlineImage extends ConsumerWidget {
  final ProductAttribute productAttribute;
  const OrderlineImage({
    super.key,
    required this.productAttribute,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return AsyncValueWidget(
      value: ref.watch(getProductImageProvider(
          colorId: productAttribute.colors!.id,
          productId: productAttribute.productId)),
      data: (p0) => Container(
        padding: const EdgeInsets.all(5),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: const Color.fromARGB(22, 0, 0, 0)),
        width: 100,
        height: 100,
        child: AspectRatio(
          aspectRatio: 16 / 9,
          child: CachedNetworkImage(
            cacheKey: p0.image,
            imageUrl: p0.image,
          ),
        ),
      ),
    );
  }
}
