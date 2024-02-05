import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:sneako/src/models/favourite.dart';
import 'package:supabase_flutter/supabase_flutter.dart' as supabase;

part 'fav_repository.g.dart';

@Riverpod(keepAlive: true)
FavRepository favRepository(FavRepositoryRef ref) {
  return FavRepository(client: supabase.Supabase.instance.client);
}

class FavRepository {
  final supabase.SupabaseClient _client;

  FavRepository({required supabase.SupabaseClient client}) : _client = client;

  Future<void> favProduct({required Favourite favourite}) async {
    try {
      await _client.from('favourites').insert(favourite.toMap());
    } catch (e) {
      throw e.toString();
    }
  }

  Future<void> unFavProduct(
      {required int productId, required String uid}) async {
    try {
      await _client
          .from('favourites')
          .delete()
          .eq('productId', productId)
          .eq('uid', uid);
    } catch (e) {
      throw e.toString();
    }
  }

  Future<List<Favourite>> getFavourites({required String uid}) async {
    try {
      final res = await _client
          .from('favourites')
          .select("*, products(*)")
          .eq('uid', uid);

      final list = res.map((e) => Favourite.fromMap(e)).toList();

      return list;
    } catch (e) {
      throw e.toString();
    }
  }

  Future<void> deleteFav({required int favId}) async {
    try {
      await _client.from('favourites').delete().eq('id', favId);
    } catch (e) {
      throw e.toString();
    }
  }

  Future<int> isFavAlready(
      {required int productId, required String uid}) async {
    try {
      final res = await _client
          .from('favourites')
          .select('id')
          .eq('productId', productId)
          .eq('uid', uid)
          .count(supabase.CountOption.exact);

      return res.count;
    } catch (e, stk) {
      print(stk);
      throw e.toString();
    }
  }
}
