import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:sneako/src/features/product_details/providers/color_provider.dart';
import 'package:sneako/src/models/product_attributes.dart';
import 'package:sneako/src/models/product_image.dart';
import 'package:supabase_flutter/supabase_flutter.dart' as supabase;

part 'product_details_repository.g.dart';

// final productRepositoryProvider = Provider<ProductRepository>((ref) {
//   return ProductRepository(client: supabase.Supabase.instance.client);
// });

final getProductImagesProvider =
    FutureProvider.family<List<ProductImage>, int>((ref, productId) async {
  return ref
      .watch(productRepositoryProvider)
      .getProductImages(productId: productId);
});

final productAttributeProvider =
    FutureProvider.family<List<ProductAttribute>, int>((ref, productId) async {
  return ref
      .watch(productRepositoryProvider)
      .getProductAttributes(productId: productId);
});

@Riverpod(keepAlive: true)
ProductRepository productRepository(ProductRepositoryRef ref) {
  return ProductRepository(client: supabase.Supabase.instance.client);
}

@riverpod
Future<int> getQuantity(
  GetQuantityRef ref, {
  required int productid,
  required int sizeId,
  required int colorId,
}) {
  return ref
      .watch(productRepositoryProvider)
      .getQuantity(colorId: colorId, productid: productid, sizeId: sizeId);
}

class ProductRepository {
  final supabase.SupabaseClient _client;

  ProductRepository({required supabase.SupabaseClient client})
      : _client = client;

  Future<List<ProductImage>> getProductImages({required int productId}) async {
    try {
      final res = await _client
          .from('product_images')
          .select('*')
          .eq('product_id', productId);

      final List<ProductImage> productImages =
          res.map((e) => ProductImage.fromMap(e)).toList();

      return productImages;
    } catch (e, stk) {
      print(stk);
      throw e.toString();
    }
  }

  Future<List<ProductAttribute>> getProductAttributes(
      {required int productId}) async {
    try {
      final res = await _client
          .from("product_attributes")
          .select("*, colors(*), sizes(*)")
          .eq('product_id', productId);

      print(res);

      final List<ProductAttribute> productAttributes =
          res.map((e) => ProductAttribute.fromMap(e)).toList();

      return productAttributes;
    } catch (e, stk) {
      print(stk);
      throw e.toString();
    }
  }

  Future<int> getQuantity(
      {required int productid,
      required int sizeId,
      required int colorId}) async {
    try {
      final res = await _client
          .from('product_attributes')
          .select('quantity')
          .eq('product_id', productid)
          .eq('size', sizeId)
          .eq('color', colorId)
          .single();

      return res['quantity'];
    } catch (e) {
      throw e.toString();
    }
  }
}
