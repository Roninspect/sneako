import 'package:fpdart/fpdart.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:sneako/src/core/helper/failure.dart';
import 'package:sneako/src/core/helper/typedefs.dart';
import 'package:sneako/src/models/address.dart';
import 'package:supabase_flutter/supabase_flutter.dart' as supabase;

part 'checkout_repository.g.dart';

@Riverpod(keepAlive: true)
CheckoutRepository checkoutRepository(CheckoutRepositoryRef ref) {
  return CheckoutRepository(client: supabase.Supabase.instance.client);
}

class CheckoutRepository {
  final supabase.SupabaseClient _client;

  CheckoutRepository({required supabase.SupabaseClient client})
      : _client = client;

  Future<List<Address>> getAddress({required String uid}) async {
    try {
      final res = await _client
          .from('addresses')
          .select('*')
          .eq('uid', uid)
          .order('isDefault', ascending: false);

      final List<Address> addresses =
          res.map((e) => Address.fromMap(e)).toList();

      return addresses;
    } catch (e) {
      throw e.toString();
    }
  }

  Future<Address?> getDefaultAddress({required String uid}) async {
    try {
      final res = await _client
          .from('addresses')
          .select('*')
          .eq('uid', uid)
          .eq('isDefault', true)
          .single();

      final addresses = Address.fromMap(res);

      return addresses;
    } catch (e) {
      if (e is supabase.PostgrestException && e.code == 'PGRST116') {
        return null;
      } else {
        throw e.toString();
      }
    }
  }

  FutureVoid addAddress({required Address address}) async {
    try {
      return right(await _client.from('addresses').insert(address.toMap()));
    } catch (e) {
      return left(Failure(e.toString()));
    }
  }

  FutureVoid updateAddress({required Address address}) async {
    try {
      return right(await _client
          .from('addresses')
          .update(address.toMap())
          .eq('id', address.id!));
    } catch (e) {
      return left(Failure(e.toString()));
    }
  }

  FutureVoid makeDeafultFalse({required String uid}) async {
    try {
      return right(await _client
          .from('addresses')
          .update({'isDefault': false})
          .eq('uid', uid)
          .eq('isDefault', true));
    } catch (e) {
      return left(Failure(e.toString()));
    }
  }
}
