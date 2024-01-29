import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:sneako/src/features/auth/repository/remote/auth_repository.dart';
import 'package:sneako/src/models/user.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

final userDataNotifierProvider =
    StateNotifierProvider<UserDataNotifier, UserModel>((ref) {
  return UserDataNotifier(ref);
});

class UserDataNotifier extends StateNotifier<UserModel> {
  UserDataNotifier(this.ref)
      : super(UserModel(
            username: 'loading',
            email: 'loading',
            id: 'loading',
            phone: 'loading',
            shippingAddress: 'loading',
            profile: "loading")) {
    fetchData();
  }

  final Ref ref;

  void fetchData() {
    ref
        .watch(
            userDetailsProvider(Supabase.instance.client.auth.currentUser!.id))
        .when(
            data: (data) async {
              state = data;
            },
            error: (error, stackTrace) {
              state = UserModel(
                  phone: "$error",
                  shippingAddress: "$error",
                  id: "$error",
                  username: "$error",
                  email: "$error",
                  profile: "$error");
            },
            loading: () => state = UserModel(
                phone: 'loading',
                shippingAddress: 'loading',
                username: 'loading',
                email: 'loading',
                id: 'loading',
                profile: "loading"));
  }
}
