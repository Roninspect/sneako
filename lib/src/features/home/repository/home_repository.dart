import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sneako/src/models/brand.dart';
import 'package:sneako/src/models/offer.dart';
import 'package:sneako/src/models/product.dart';
import 'package:supabase_flutter/supabase_flutter.dart' as supabase;

final homeRepositroyProvider = Provider<HomeRepository>((ref) {
  return HomeRepository(client: supabase.Supabase.instance.client);
});

final recentofferProvider = FutureProvider<Offer>((ref) async {
  return await ref.watch(homeRepositroyProvider).getRecentOffer();
});

final getBrandsProvider = FutureProvider<List<Brand>>((ref) async {
  return ref.watch(homeRepositroyProvider).getBrands();
});

final getProductByBrandProvider =
    FutureProvider.family<List<Product>, int>((ref, brandId) async {
  return ref.watch(homeRepositroyProvider).getProductByBrand(brandId: brandId);
});

class HomeRepository {
  final supabase.SupabaseClient _client;

  HomeRepository({required supabase.SupabaseClient client}) : _client = client;

  Future<Offer> getRecentOffer() async {
    try {
      final res = await _client
          .from('offers')
          .select('*')
          .order("created_at", ascending: false)
          .single();

      final recentOffer = Offer.fromMap(res);

      return recentOffer;
    } catch (e) {
      throw e.toString();
    }
  }

  Future<List<Brand>> getBrands() async {
    try {
      final res = await _client.from('brands').select('*');

      final brands = res.map((e) => Brand.fromMap(e)).toList();

      return brands;
    } catch (e) {
      throw e.toString();
    }
  }

  Future<List<Product>> getProductByBrand({required int brandId}) async {
    try {
      List<Map<String, dynamic>> res;
      if (brandId != 0) {
        res = await _client.from('products').select('*').eq('brand', brandId);
      } else {
        res = await _client.from('products').select('*');
      }

      final productsById = res.map((e) => Product.fromMap(e)).toList();

      return productsById;
    } catch (e) {
      throw e.toString();
    }
  }
}
