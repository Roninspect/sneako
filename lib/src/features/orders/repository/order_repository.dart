import 'package:sneako/src/models/order.dart';
import 'package:supabase_flutter/supabase_flutter.dart' as supabase;

class OrderRepository {
  final supabase.SupabaseClient _client;

  OrderRepository({required supabase.SupabaseClient client}) : _client = client;

  Future<List<ProductOrder>> getOrders({required String uid}) async {
    try {
      final res = await _client.from('orders').select('*').eq('uid', uid);

      final List<ProductOrder> orders =
          res.map((e) => ProductOrder.fromMap(e)).toList();

      return orders;
    } catch (e) {
      throw e.toString();
    }
  }
}
