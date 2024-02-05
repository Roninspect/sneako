import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:sneako/src/models/order.dart';
import 'package:sneako/src/models/order_line.dart';
import 'package:sneako/src/models/order_status.dart';
import 'package:sneako/src/models/product.dart';
import 'package:sneako/src/models/product_image.dart';
import 'package:supabase_flutter/supabase_flutter.dart' as supabase;

part 'order_repository.g.dart';

@Riverpod(keepAlive: true)
OrderRepository orderRepository(OrderRepositoryRef ref) {
  return OrderRepository(client: supabase.Supabase.instance.client);
}

@Riverpod(keepAlive: true)
Future<List<ProductOrder>> getActiveOrders(GetActiveOrdersRef ref,
    {required String uid}) async {
  return ref.watch(orderRepositoryProvider).getActiveOrders(uid: uid);
}

@Riverpod(keepAlive: true)
Future<List<ProductOrder>> getCancelledOrders(GetCancelledOrdersRef ref,
    {required String uid}) async {
  return ref.watch(orderRepositoryProvider).getCancelledOrders(uid: uid);
}

@Riverpod(keepAlive: true)
Future<List<ProductOrder>> getCompletedOrders(GetCompletedOrdersRef ref,
    {required String uid}) async {
  return ref.watch(orderRepositoryProvider).getCompletedOrders(uid: uid);
}

@Riverpod(keepAlive: true)
Future<List<OrderLine>> getOrderlines(GetOrderlinesRef ref,
    {required String orderId}) async {
  return await ref
      .watch(orderRepositoryProvider)
      .getOrderlines(orderId: orderId);
}

@Riverpod(keepAlive: true)
Future<ProductImage> getProductImage(GetProductImageRef ref,
    {required int productId, required int colorId}) async {
  return await ref
      .watch(orderRepositoryProvider)
      .getOrderImage(colorId: colorId, productId: productId);
}

@Riverpod(keepAlive: true)
Future<Product> getProductById(GetProductByIdRef ref, int productId) async {
  return await ref.watch(orderRepositoryProvider).getProductById(productId);
}

@riverpod
Future<OrderStatus> getOrderStatusById(
    GetOrderStatusByIdRef ref, String orderId) async {
  return await ref.watch(orderRepositoryProvider).getOrderStatusById(orderId);
}

class OrderRepository {
  final supabase.SupabaseClient _client;

  OrderRepository({required supabase.SupabaseClient client}) : _client = client;

  Future<List<ProductOrder>> getActiveOrders({required String uid}) async {
    try {
      final res = await _client
          .from('orders')
          .select('*')
          .eq('uid', uid)
          .eq('order_status', 'Active')
          .order('order_date', ascending: false);

      final List<ProductOrder> orders =
          res.map((e) => ProductOrder.fromMap(e)).toList();

      return orders;
    } catch (e) {
      throw e.toString();
    }
  }

  Future<List<ProductOrder>> getCancelledOrders({required String uid}) async {
    try {
      final res = await _client
          .from('orders')
          .select('*')
          .eq('uid', uid)
          .eq('order_status', 'Cancelled')
          .order('order_date', ascending: false);

      final List<ProductOrder> orders =
          res.map((e) => ProductOrder.fromMap(e)).toList();

      return orders;
    } catch (e) {
      throw e.toString();
    }
  }

  Future<List<ProductOrder>> getCompletedOrders({required String uid}) async {
    try {
      final res = await _client
          .from('orders')
          .select('*')
          .eq('uid', uid)
          .eq('order_status', 'Completed')
          .order('order_date', ascending: false);

      final List<ProductOrder> orders =
          res.map((e) => ProductOrder.fromMap(e)).toList();

      return orders;
    } catch (e) {
      throw e.toString();
    }
  }

  Future<List<OrderLine>> getOrderlines({required String orderId}) async {
    try {
      final res = await _client
          .from('order_lines')
          .select("*, product_attributes(*, colors(*), sizes(*))")
          .eq('order_id', orderId);

      print(res.first);

      final List<OrderLine> orders =
          res.map((e) => OrderLine.fromMap(e)).toList();

      return orders;
    } catch (e, stk) {
      print(stk);
      throw e.toString();
    }
  }

  Future<ProductImage> getOrderImage(
      {required int productId, required int colorId}) async {
    try {
      final res = await _client
          .from('product_images')
          .select('*')
          .eq('product_id', productId)
          .eq('color', colorId)
          .single();

      final ProductImage productImage = ProductImage.fromMap(res);

      return productImage;
    } catch (e, stk) {
      print(stk);
      throw e.toString();
    }
  }

  Future<Product> getProductById(int productId) async {
    try {
      final res = await _client
          .from('products')
          .select('*')
          .eq('id', productId)
          .single();

      return Product.fromMap(res);
    } catch (e) {
      throw e.toString();
    }
  }

  Future<OrderStatus> getOrderStatusById(String orderId) async {
    try {
      final res = await _client
          .from('shipping_status')
          .select()
          .eq('order_id', orderId)
          .single();

      final OrderStatus orderStatus = OrderStatus.fromMap(res);

      return orderStatus;
    } catch (e) {
      throw e.toString();
    }
  }
}
