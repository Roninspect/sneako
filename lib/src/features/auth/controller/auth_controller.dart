import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../core/shared/custom_snackbar.dart';
import '../../../core/shared/error_snackbar.dart';
import '../provider/user_data_notifer.dart';
import '../repository/remote/auth_repository.dart';

final authControllerProvider =
    StateNotifierProvider<AuthController, bool>((ref) {
  return AuthController(
      authRepository: ref.watch(authRepositoryProvider), ref: ref);
});

class AuthController extends StateNotifier<bool> {
  final AuthRepository _authRepository;
  final Ref _ref;
  AuthController({
    required AuthRepository authRepository,
    required Ref ref,
  })  : _authRepository = authRepository,
        _ref = ref,
        super(false);

  //* login function from auth repository
  Future<void> loginUser({
    required String email,
    required String password,
    required BuildContext context,
  }) async {
    state = true;
    final res =
        await _authRepository.loginUser(email: email, password: password);

    res.fold((l) {
      state = false;
      showSnackbar(context: context, text: l.message);
    }, (r) {
      state = false;
      _ref.invalidate(userDataNotifierProvider);
    });
  }

  //* register function from auth repository
  registerUser({
    required String name,
    required String email,
    required String password,
    required BuildContext contexts,
    required String phone,
  }) async {
    state = true;
    final res = await _authRepository.registerUser(
        phone: phone, name: name, email: email, password: password);

    state = false;

    res.fold((l) {
      showSnackbar(context: contexts, text: l.message);
    }, (r) {
      _ref.read(userDataNotifierProvider.notifier).fetchData();
      _ref.invalidate(userDataNotifierProvider);
      contexts.pop();
      showSnackbar(context: contexts, text: "Registration Successful");
    });
  }

  void singInWithGoogle(BuildContext context) async {
    _ref.read(authControllerProvider.notifier).state = true;

    final user = await _authRepository.signInWithGoogle();

    _ref.read(authControllerProvider.notifier).state = false;

    user.fold(
      (l) {
        print(l.message);
        return ErrorSnackbar().showsnackBar(context, l.message);
      },
      (r) async {
        // _ref.refresh(userdataProvider);
        // _ref.refresh(userDataNotifierProvider);
      },
    );
  }

  // Future<UserModel> getData() async {
  //   return await _authRepository.getUserDatafromFirestore();
  // }
}
