import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:sneako/src/features/cart/repository/cart_repository.dart';
import 'package:sneako/src/models/cart.dart';

part 'cart_controller.g.dart';

@riverpod
class CartController extends _$CartController {
  Future<List<Cart>> getCartItems() async {
    final cartRepository = ref.watch(cartRepositoryProvider);
    return await cartRepository.getCartItems();
  }

  @override
  FutureOr<List<Cart>> build() async {
    return getCartItems();
  }

  void addToCart({required Cart cart}) async {
    state = const AsyncLoading();
    final cartRepository = ref.watch(cartRepositoryProvider);

    final itemExists = await cartRepository.ifItemExistsUpdate(
        uid: cart.uid,
        colorId: cart.color,
        productId: cart.productId,
        sizeId: cart.size);

    final availableQuantity = await cartRepository.getProductQunatity(
      productId: cart.productId,
      colorId: cart.color,
      sizeId: cart.size,
    );

    if (itemExists.isNotEmpty &&
        itemExists[0]['quantity'] + cart.quantity <= availableQuantity) {
      state = await AsyncValue.guard(() async {
        await ref.read(cartRepositoryProvider).updateQuantity(
              quanity: cart.quantity,
              uid: cart.uid,
              colorId: cart.color,
              productId: cart.productId,
              sizeId: cart.size,
              itemExists: itemExists,
            );
        return cartRepository.getCartItems();
      });
    } else if (itemExists.isEmpty && cart.quantity <= availableQuantity) {
      state = await AsyncValue.guard(() async {
        await ref.read(cartRepositoryProvider).addToCart(cart: cart);

        return cartRepository.getCartItems();
      });
    } else {
      state = await AsyncValue.guard(() async {
        return cartRepository.getCartItems();
      });
    }
  }

  void incrementQuantity({
    required int productId,
    required String uid,
    required int colorId,
    required int cartId,
    required int sizeId,
    required int quanity,
  }) async {
    state = const AsyncLoading();
    final cartRepository = ref.watch(cartRepositoryProvider);

    final availableQuantity = await cartRepository.getProductQunatity(
      productId: productId,
      colorId: colorId,
      sizeId: sizeId,
    );

    if (quanity + 1 <= availableQuantity) {
      state = await AsyncValue.guard(() async {
        await ref.read(cartRepositoryProvider).incrementQuantity(
              cartId: cartId,
              quanity: quanity,
            );
        return cartRepository.getCartItems();
      });
    } else {
      state = await AsyncValue.guard(() async {
        return cartRepository.getCartItems();
      });
    }
  }

  void decrementQuantity({
    required int cartId,
    required int quanity,
  }) async {
    state = const AsyncLoading();
    final cartRepository = ref.watch(cartRepositoryProvider);

    if (quanity > 1) {
      state = await AsyncValue.guard(() async {
        await ref.read(cartRepositoryProvider).decrementQuantity(
              cartId: cartId,
              quanity: quanity,
            );
        return cartRepository.getCartItems();
      });
    } else {
      state = await AsyncValue.guard(() async {
        return cartRepository.getCartItems();
      });
    }
  }

  void removeFromCart({
    required int productId,
    required String uid,
    required int colorId,
    required int sizeId,
  }) async {
    state = const AsyncLoading();
    final cartRepository = ref.watch(cartRepositoryProvider);
    state = await AsyncValue.guard(() async {
      await ref.read(cartRepositoryProvider).rmeoveFromCart(
            uid: uid,
            colorId: colorId,
            productId: productId,
            sizeId: sizeId,
          );
      return cartRepository.getCartItems();
    });
  }

  Future<void> emptyCart() async {
    final cartRepository = ref.watch(cartRepositoryProvider);
    for (var cart in state.value!) {
      state = await AsyncValue.guard(() async {
        await ref.read(cartRepositoryProvider).rmeoveFromCart(
              uid: cart.uid,
              colorId: cart.color,
              productId: cart.productId,
              sizeId: cart.size,
            );
        return cartRepository.getCartItems();
      });
    }
  }
}
