// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product_details_repository.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$productRepositoryHash() => r'2c8fad2788079534627f70f632852fe5c407161b';

/// See also [productRepository].
@ProviderFor(productRepository)
final productRepositoryProvider = Provider<ProductRepository>.internal(
  productRepository,
  name: r'productRepositoryProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$productRepositoryHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef ProductRepositoryRef = ProviderRef<ProductRepository>;
String _$getQuantityHash() => r'c991bd2311143fa66e1e3f88c0e9d3479657f6ba';

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

/// See also [getQuantity].
@ProviderFor(getQuantity)
const getQuantityProvider = GetQuantityFamily();

/// See also [getQuantity].
class GetQuantityFamily extends Family<AsyncValue<int>> {
  /// See also [getQuantity].
  const GetQuantityFamily();

  /// See also [getQuantity].
  GetQuantityProvider call({
    required int productid,
    required int sizeId,
    required int colorId,
  }) {
    return GetQuantityProvider(
      productid: productid,
      sizeId: sizeId,
      colorId: colorId,
    );
  }

  @override
  GetQuantityProvider getProviderOverride(
    covariant GetQuantityProvider provider,
  ) {
    return call(
      productid: provider.productid,
      sizeId: provider.sizeId,
      colorId: provider.colorId,
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
  String? get name => r'getQuantityProvider';
}

/// See also [getQuantity].
class GetQuantityProvider extends AutoDisposeFutureProvider<int> {
  /// See also [getQuantity].
  GetQuantityProvider({
    required int productid,
    required int sizeId,
    required int colorId,
  }) : this._internal(
          (ref) => getQuantity(
            ref as GetQuantityRef,
            productid: productid,
            sizeId: sizeId,
            colorId: colorId,
          ),
          from: getQuantityProvider,
          name: r'getQuantityProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$getQuantityHash,
          dependencies: GetQuantityFamily._dependencies,
          allTransitiveDependencies:
              GetQuantityFamily._allTransitiveDependencies,
          productid: productid,
          sizeId: sizeId,
          colorId: colorId,
        );

  GetQuantityProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.productid,
    required this.sizeId,
    required this.colorId,
  }) : super.internal();

  final int productid;
  final int sizeId;
  final int colorId;

  @override
  Override overrideWith(
    FutureOr<int> Function(GetQuantityRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: GetQuantityProvider._internal(
        (ref) => create(ref as GetQuantityRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        productid: productid,
        sizeId: sizeId,
        colorId: colorId,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<int> createElement() {
    return _GetQuantityProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is GetQuantityProvider &&
        other.productid == productid &&
        other.sizeId == sizeId &&
        other.colorId == colorId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, productid.hashCode);
    hash = _SystemHash.combine(hash, sizeId.hashCode);
    hash = _SystemHash.combine(hash, colorId.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin GetQuantityRef on AutoDisposeFutureProviderRef<int> {
  /// The parameter `productid` of this provider.
  int get productid;

  /// The parameter `sizeId` of this provider.
  int get sizeId;

  /// The parameter `colorId` of this provider.
  int get colorId;
}

class _GetQuantityProviderElement extends AutoDisposeFutureProviderElement<int>
    with GetQuantityRef {
  _GetQuantityProviderElement(super.provider);

  @override
  int get productid => (origin as GetQuantityProvider).productid;
  @override
  int get sizeId => (origin as GetQuantityProvider).sizeId;
  @override
  int get colorId => (origin as GetQuantityProvider).colorId;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
