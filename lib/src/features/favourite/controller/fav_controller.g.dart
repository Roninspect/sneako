// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'fav_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$isFavAlreadyHash() => r'da8db0c6ab708fe61a73d97d5a6cc0a6b5bcc83b';

/// Copied from Dart SDK
class _SystemHash {
  _SystemHash._();

  static int combine(int hash, int value) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + value);
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x0007ffff & hash) << 10));
    return hash ^ (hash >> 6);
  }

  static int finish(int hash) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x03ffffff & hash) << 3));
    // ignore: parameter_assignments
    hash = hash ^ (hash >> 11);
    return 0x1fffffff & (hash + ((0x00003fff & hash) << 15));
  }
}

/// See also [isFavAlready].
@ProviderFor(isFavAlready)
const isFavAlreadyProvider = IsFavAlreadyFamily();

/// See also [isFavAlready].
class IsFavAlreadyFamily extends Family<AsyncValue<bool>> {
  /// See also [isFavAlready].
  const IsFavAlreadyFamily();

  /// See also [isFavAlready].
  IsFavAlreadyProvider call({
    required int productId,
  }) {
    return IsFavAlreadyProvider(
      productId: productId,
    );
  }

  @override
  IsFavAlreadyProvider getProviderOverride(
    covariant IsFavAlreadyProvider provider,
  ) {
    return call(
      productId: provider.productId,
    );
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'isFavAlreadyProvider';
}

/// See also [isFavAlready].
class IsFavAlreadyProvider extends FutureProvider<bool> {
  /// See also [isFavAlready].
  IsFavAlreadyProvider({
    required int productId,
  }) : this._internal(
          (ref) => isFavAlready(
            ref as IsFavAlreadyRef,
            productId: productId,
          ),
          from: isFavAlreadyProvider,
          name: r'isFavAlreadyProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$isFavAlreadyHash,
          dependencies: IsFavAlreadyFamily._dependencies,
          allTransitiveDependencies:
              IsFavAlreadyFamily._allTransitiveDependencies,
          productId: productId,
        );

  IsFavAlreadyProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.productId,
  }) : super.internal();

  final int productId;

  @override
  Override overrideWith(
    FutureOr<bool> Function(IsFavAlreadyRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: IsFavAlreadyProvider._internal(
        (ref) => create(ref as IsFavAlreadyRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        productId: productId,
      ),
    );
  }

  @override
  FutureProviderElement<bool> createElement() {
    return _IsFavAlreadyProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is IsFavAlreadyProvider && other.productId == productId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, productId.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin IsFavAlreadyRef on FutureProviderRef<bool> {
  /// The parameter `productId` of this provider.
  int get productId;
}

class _IsFavAlreadyProviderElement extends FutureProviderElement<bool>
    with IsFavAlreadyRef {
  _IsFavAlreadyProviderElement(super.provider);

  @override
  int get productId => (origin as IsFavAlreadyProvider).productId;
}

String _$favControllerHash() => r'f2276b43cd3f81480aa93a23a1021bdce15841fb';

/// See also [FavController].
@ProviderFor(FavController)
final favControllerProvider =
    AsyncNotifierProvider<FavController, List<Favourite>>.internal(
  FavController.new,
  name: r'favControllerProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$favControllerHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$FavController = AsyncNotifier<List<Favourite>>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
