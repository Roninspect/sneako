import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:sneako/src/features/auth/provider/user_data_notifer.dart';
import 'package:sneako/src/features/favourite/repository/fav_repository.dart';
import 'package:sneako/src/models/favourite.dart';

part 'fav_controller.g.dart';

@Riverpod(keepAlive: true)
Future<bool> isFavAlready(IsFavAlreadyRef ref, {required int productId}) async {
  print("called");
  return ref
      .watch(favControllerProvider.notifier)
      .isFavAlready(productId: productId);
}

@Riverpod(keepAlive: true)
class FavController extends _$FavController {
  Future<List<Favourite>> getFavourites() async {
    print("called");
    final FavRepository favRepository = ref.watch(favRepositoryProvider);

    final uid = ref.watch(userDataNotifierProvider).value!.id;

    return await favRepository.getFavourites(uid: uid);
  }

  @override
  FutureOr<List<Favourite>> build() {
    return getFavourites();
  }

  Future<void> favProduct({required int productId}) async {
    state = const AsyncLoading();
    final FavRepository favRepository = ref.watch(favRepositoryProvider);
    // ignore: avoid_manual_providers_as_generated_provider_dependency
    final uid = ref.watch(userDataNotifierProvider).value!.id;
    state = await AsyncValue.guard(() async {
      final Favourite favourite = Favourite(productId: productId, uid: uid);
      await favRepository.favProduct(favourite: favourite);

      ref.invalidate(isFavAlreadyProvider);

      return getFavourites();
    });
  }

  Future<void> deleteFav({required int favId}) async {
    state = const AsyncLoading();
    final FavRepository favRepository = ref.watch(favRepositoryProvider);
    state = await AsyncValue.guard(() async {
      await favRepository.deleteFav(favId: favId);
      ref.invalidate(isFavAlreadyProvider);

      return getFavourites();
    });
  }

  Future<bool> isFavAlready({required int productId}) async {
    final uid = ref.watch(userDataNotifierProvider).value!.id;

    final FavRepository favRepository = ref.watch(favRepositoryProvider);

    final res =
        await favRepository.isFavAlready(productId: productId, uid: uid);

    if (res >= 1) {
      return true;
    } else {
      return false;
    }
  }

  Future<void> unFavProduct({required int productId}) async {
    state = const AsyncLoading();
    final FavRepository favRepository = ref.watch(favRepositoryProvider);
    final uid = ref.watch(userDataNotifierProvider).value!.id;
    state = await AsyncValue.guard(() async {
      await favRepository.unFavProduct(productId: productId, uid: uid);

      ref.invalidate(isFavAlreadyProvider);

      return getFavourites();
    });
  }
}
