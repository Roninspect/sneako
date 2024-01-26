import 'package:fpdart/fpdart.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:sneako/src/core/helper/failure.dart';
import 'package:sneako/src/core/helper/typedefs.dart';
import 'package:sneako/src/models/cart.dart';
import 'package:sneako/src/models/product.dart';
import 'package:supabase_flutter/supabase_flutter.dart' as supabase;

part 'cart_repository.g.dart';

@Riverpod(keepAlive: true)
CartRepository cartRepository(CartRepositoryRef ref) {
  return CartRepository(client: supabase.Supabase.instance.client);
}

class CartRepository {
  final supabase.SupabaseClient _client;

  CartRepository({required supabase.SupabaseClient client}) : _client = client;

  Future<void> addToCart({required Cart cart}) async {
    try {
      return await _client.from('carts').insert(cart.toMap());
    } catch (e) {
      print(e.toString());
      throw e.toString();
    }
  }

  Future<List<Cart>> getCartItems() async {
    try {
      final res = await _client
          .from('carts')
          .select("*, products(*), colors(*), sizes(*)")
          .eq('uid', supabase.Supabase.instance.client.auth.currentUser!.id)
          .order('created_at', ascending: false);

      final List<Cart> carts = res.map((e) => Cart.fromMap(e)).toList();

      return carts;
    } catch (e) {
      throw e.toString();
    }
  }

  Future<List<Map<String, dynamic>>> ifItemExistsUpdate(
      {required int productId,
      required String uid,
      required int colorId,
      required int sizeId}) async {
    try {
      final itemExists = await _client
          .from('carts')
          .select('id, quantity')
          .eq('uid', uid)
          .eq('product_id', productId)
          .eq('color', colorId)
          .eq('size', sizeId);
      return itemExists;
    } catch (e) {
      throw e.toString();
    }
  }

  Future<void> updateQuantity(
      {required int productId,
      required String uid,
      required int colorId,
      required int sizeId,
      required int quanity,
      required List<Map<String, dynamic>> itemExists}) async {
    await _client
        .from('carts')
        .update({'quantity': itemExists[0]['quantity'] + quanity})
        .eq('uid', uid)
        .eq('product_id', productId)
        .eq('color', colorId)
        .eq('size', sizeId);
  }

  Future<void> incrementQuantity(
      {required int cartId, required int quanity}) async {
    try {
      await _client
          .from('carts')
          .update({'quantity': quanity + 1}).eq('id', cartId);
    } catch (e) {
      throw e.toString();
    }
  }

  Future<void> decrementQuantity(
      {required int cartId, required int quanity}) async {
    try {
      await _client
          .from('carts')
          .update({'quantity': quanity - 1}).eq('id', cartId);
    } catch (e) {
      throw e.toString();
    }
  }

  Future<void> rmeoveFromCart({
    required int productId,
    required String uid,
    required int colorId,
    required int sizeId,
  }) async {
    try {
      await _client
          .from('carts')
          .delete()
          .eq('uid', uid)
          .eq('product_id', productId)
          .eq('color', colorId)
          .eq('size', sizeId);
    } catch (e) {
      throw e.toString();
    }
  }

  Future<int> getProductQunatity({
    required int productId,
    required int colorId,
    required int sizeId,
  }) async {
    try {
      final res = await _client
          .from('product_attributes')
          .select('quantity')
          .eq('product_id', productId)
          .eq('color', colorId)
          .eq('size', sizeId)
          .single();

      final int quantity = res['quantity'];

      print(quantity);

      return quantity;
    } catch (e) {
      throw e.toString();
    }
  }
}
