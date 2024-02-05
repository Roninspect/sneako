import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:sneako/src/features/auth/controller/auth_controller.dart';
import 'package:sneako/src/features/auth/repository/remote/auth_repository.dart';
import 'package:sneako/src/models/user.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

final userDataNotifierProvider = FutureProvider<UserModel>((ref) async {
  return await ref.watch(authRepositoryProvider).getUserDatafromSupabase(
      id: Supabase.instance.client.auth.currentUser!.id);
});
