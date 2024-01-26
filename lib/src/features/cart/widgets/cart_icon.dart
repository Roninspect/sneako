import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:sneako/src/features/cart/controllers/cart_controller.dart';

class CartIcon extends ConsumerWidget {
  const CartIcon({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ref.watch(cartControllerProvider).when(
          data: (data) {
            return Badge(
              label: Text(data.length.toString()),
              child: const Icon(
                Ionicons.cart,
                size: 23,
              ),
            );
          },
          error: (error, stackTrace) => const Badge(
            label: CircleAvatar(
              backgroundColor: Colors.red,
              radius: 10,
              child: Text('i'),
            ),
            child: Icon(Ionicons.cart),
          ),
          loading: () => const Badge(
            label: CircleAvatar(
              backgroundColor: Colors.red,
              radius: 10,
              child: SizedBox(
                  width: 8,
                  height: 8,
                  child: CircularProgressIndicator(
                    color: Colors.white,
                  )),
            ),
            child: Icon(Ionicons.cart),
          ),
        );
  }
}
