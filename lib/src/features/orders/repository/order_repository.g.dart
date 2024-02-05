// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order_repository.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$orderRepositoryHash() => r'e978ed303861ef557f8158c167a6e04b121090ae';

/// See also [orderRepository].
@ProviderFor(orderRepository)
final orderRepositoryProvider = Provider<OrderRepository>.internal(
  orderRepository,
  name: r'orderRepositoryProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$orderRepositoryHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef OrderRepositoryRef = ProviderRef<OrderRepository>;
String _$getActiveOrdersHash() => r'8b81ee82273a72c71400f3487f929f2dca6537c8';

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

/// See also [getActiveOrders].
@ProviderFor(getActiveOrders)
const getActiveOrdersProvider = GetActiveOrdersFamily();

/// See also [getActiveOrders].
class GetActiveOrdersFamily extends Family<AsyncValue<List<ProductOrder>>> {
  /// See also [getActiveOrders].
  const GetActiveOrdersFamily();

  /// See also [getActiveOrders].
  GetActiveOrdersProvider call({
    required String uid,
  }) {
    return GetActiveOrdersProvider(
      uid: uid,
    );
  }

  @override
  GetActiveOrdersProvider getProviderOverride(
    covariant GetActiveOrdersProvider provider,
  ) {
    return call(
      uid: provider.uid,
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
  String? get name => r'getActiveOrdersProvider';
}

/// See also [getActiveOrders].
class GetActiveOrdersProvider extends FutureProvider<List<ProductOrder>> {
  /// See also [getActiveOrders].
  GetActiveOrdersProvider({
    required String uid,
  }) : this._internal(
          (ref) => getActiveOrders(
            ref as GetActiveOrdersRef,
            uid: uid,
          ),
          from: getActiveOrdersProvider,
          name: r'getActiveOrdersProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$getActiveOrdersHash,
          dependencies: GetActiveOrdersFamily._dependencies,
          allTransitiveDependencies:
              GetActiveOrdersFamily._allTransitiveDependencies,
          uid: uid,
        );

  GetActiveOrdersProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.uid,
  }) : super.internal();

  final String uid;

  @override
  Override overrideWith(
    FutureOr<List<ProductOrder>> Function(GetActiveOrdersRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: GetActiveOrdersProvider._internal(
        (ref) => create(ref as GetActiveOrdersRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        uid: uid,
      ),
    );
  }

  @override
  FutureProviderElement<List<ProductOrder>> createElement() {
    return _GetActiveOrdersProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is GetActiveOrdersProvider && other.uid == uid;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, uid.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin GetActiveOrdersRef on FutureProviderRef<List<ProductOrder>> {
  /// The parameter `uid` of this provider.
  String get uid;
}

class _GetActiveOrdersProviderElement
    extends FutureProviderElement<List<ProductOrder>> with GetActiveOrdersRef {
  _GetActiveOrdersProviderElement(super.provider);

  @override
  String get uid => (origin as GetActiveOrdersProvider).uid;
}

String _$getCancelledOrdersHash() =>
    r'3c73168cb440eae1f8e259a721d2fc655addcf53';

/// See also [getCancelledOrders].
@ProviderFor(getCancelledOrders)
const getCancelledOrdersProvider = GetCancelledOrdersFamily();

/// See also [getCancelledOrders].
class GetCancelledOrdersFamily extends Family<AsyncValue<List<ProductOrder>>> {
  /// See also [getCancelledOrders].
  const GetCancelledOrdersFamily();

  /// See also [getCancelledOrders].
  GetCancelledOrdersProvider call({
    required String uid,
  }) {
    return GetCancelledOrdersProvider(
      uid: uid,
    );
  }

  @override
  GetCancelledOrdersProvider getProviderOverride(
    covariant GetCancelledOrdersProvider provider,
  ) {
    return call(
      uid: provider.uid,
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
  String? get name => r'getCancelledOrdersProvider';
}

/// See also [getCancelledOrders].
class GetCancelledOrdersProvider extends FutureProvider<List<ProductOrder>> {
  /// See also [getCancelledOrders].
  GetCancelledOrdersProvider({
    required String uid,
  }) : this._internal(
          (ref) => getCancelledOrders(
            ref as GetCancelledOrdersRef,
            uid: uid,
          ),
          from: getCancelledOrdersProvider,
          name: r'getCancelledOrdersProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$getCancelledOrdersHash,
          dependencies: GetCancelledOrdersFamily._dependencies,
          allTransitiveDependencies:
              GetCancelledOrdersFamily._allTransitiveDependencies,
          uid: uid,
        );

  GetCancelledOrdersProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.uid,
  }) : super.internal();

  final String uid;

  @override
  Override overrideWith(
    FutureOr<List<ProductOrder>> Function(GetCancelledOrdersRef provider)
        create,
  ) {
    return ProviderOverride(
      origin: this,
      override: GetCancelledOrdersProvider._internal(
        (ref) => create(ref as GetCancelledOrdersRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        uid: uid,
      ),
    );
  }

  @override
  FutureProviderElement<List<ProductOrder>> createElement() {
    return _GetCancelledOrdersProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is GetCancelledOrdersProvider && other.uid == uid;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, uid.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin GetCancelledOrdersRef on FutureProviderRef<List<ProductOrder>> {
  /// The parameter `uid` of this provider.
  String get uid;
}

class _GetCancelledOrdersProviderElement
    extends FutureProviderElement<List<ProductOrder>>
    with GetCancelledOrdersRef {
  _GetCancelledOrdersProviderElement(super.provider);

  @override
  String get uid => (origin as GetCancelledOrdersProvider).uid;
}

String _$getCompletedOrdersHash() =>
    r'efc0b702aa0a8212f9ca7cf2a8b44f9d3605e17f';

/// See also [getCompletedOrders].
@ProviderFor(getCompletedOrders)
const getCompletedOrdersProvider = GetCompletedOrdersFamily();

/// See also [getCompletedOrders].
class GetCompletedOrdersFamily extends Family<AsyncValue<List<ProductOrder>>> {
  /// See also [getCompletedOrders].
  const GetCompletedOrdersFamily();

  /// See also [getCompletedOrders].
  GetCompletedOrdersProvider call({
    required String uid,
  }) {
    return GetCompletedOrdersProvider(
      uid: uid,
    );
  }

  @override
  GetCompletedOrdersProvider getProviderOverride(
    covariant GetCompletedOrdersProvider provider,
  ) {
    return call(
      uid: provider.uid,
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
  String? get name => r'getCompletedOrdersProvider';
}

/// See also [getCompletedOrders].
class GetCompletedOrdersProvider extends FutureProvider<List<ProductOrder>> {
  /// See also [getCompletedOrders].
  GetCompletedOrdersProvider({
    required String uid,
  }) : this._internal(
          (ref) => getCompletedOrders(
            ref as GetCompletedOrdersRef,
            uid: uid,
          ),
          from: getCompletedOrdersProvider,
          name: r'getCompletedOrdersProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$getCompletedOrdersHash,
          dependencies: GetCompletedOrdersFamily._dependencies,
          allTransitiveDependencies:
              GetCompletedOrdersFamily._allTransitiveDependencies,
          uid: uid,
        );

  GetCompletedOrdersProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.uid,
  }) : super.internal();

  final String uid;

  @override
  Override overrideWith(
    FutureOr<List<ProductOrder>> Function(GetCompletedOrdersRef provider)
        create,
  ) {
    return ProviderOverride(
      origin: this,
      override: GetCompletedOrdersProvider._internal(
        (ref) => create(ref as GetCompletedOrdersRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        uid: uid,
      ),
    );
  }

  @override
  FutureProviderElement<List<ProductOrder>> createElement() {
    return _GetCompletedOrdersProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is GetCompletedOrdersProvider && other.uid == uid;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, uid.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin GetCompletedOrdersRef on FutureProviderRef<List<ProductOrder>> {
  /// The parameter `uid` of this provider.
  String get uid;
}

class _GetCompletedOrdersProviderElement
    extends FutureProviderElement<List<ProductOrder>>
    with GetCompletedOrdersRef {
  _GetCompletedOrdersProviderElement(super.provider);

  @override
  String get uid => (origin as GetCompletedOrdersProvider).uid;
}

String _$getOrderlinesHash() => r'932a1e05d0ad0f5b36beec3a34869c902a616827';

/// See also [getOrderlines].
@ProviderFor(getOrderlines)
const getOrderlinesProvider = GetOrderlinesFamily();

/// See also [getOrderlines].
class GetOrderlinesFamily extends Family<AsyncValue<List<OrderLine>>> {
  /// See also [getOrderlines].
  const GetOrderlinesFamily();

  /// See also [getOrderlines].
  GetOrderlinesProvider call({
    required String orderId,
  }) {
    return GetOrderlinesProvider(
      orderId: orderId,
    );
  }

  @override
  GetOrderlinesProvider getProviderOverride(
    covariant GetOrderlinesProvider provider,
  ) {
    return call(
      orderId: provider.orderId,
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
  String? get name => r'getOrderlinesProvider';
}

/// See also [getOrderlines].
class GetOrderlinesProvider extends FutureProvider<List<OrderLine>> {
  /// See also [getOrderlines].
  GetOrderlinesProvider({
    required String orderId,
  }) : this._internal(
          (ref) => getOrderlines(
            ref as GetOrderlinesRef,
            orderId: orderId,
          ),
          from: getOrderlinesProvider,
          name: r'getOrderlinesProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$getOrderlinesHash,
          dependencies: GetOrderlinesFamily._dependencies,
          allTransitiveDependencies:
              GetOrderlinesFamily._allTransitiveDependencies,
          orderId: orderId,
        );

  GetOrderlinesProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.orderId,
  }) : super.internal();

  final String orderId;

  @override
  Override overrideWith(
    FutureOr<List<OrderLine>> Function(GetOrderlinesRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: GetOrderlinesProvider._internal(
        (ref) => create(ref as GetOrderlinesRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        orderId: orderId,
      ),
    );
  }

  @override
  FutureProviderElement<List<OrderLine>> createElement() {
    return _GetOrderlinesProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is GetOrderlinesProvider && other.orderId == orderId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, orderId.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin GetOrderlinesRef on FutureProviderRef<List<OrderLine>> {
  /// The parameter `orderId` of this provider.
  String get orderId;
}

class _GetOrderlinesProviderElement
    extends FutureProviderElement<List<OrderLine>> with GetOrderlinesRef {
  _GetOrderlinesProviderElement(super.provider);

  @override
  String get orderId => (origin as GetOrderlinesProvider).orderId;
}

String _$getProductImageHash() => r'558e5947a37c199d20126b60be42173d783aa616';

/// See also [getProductImage].
@ProviderFor(getProductImage)
const getProductImageProvider = GetProductImageFamily();

/// See also [getProductImage].
class GetProductImageFamily extends Family<AsyncValue<ProductImage>> {
  /// See also [getProductImage].
  const GetProductImageFamily();

  /// See also [getProductImage].
  GetProductImageProvider call({
    required int productId,
    required int colorId,
  }) {
    return GetProductImageProvider(
      productId: productId,
      colorId: colorId,
    );
  }

  @override
  GetProductImageProvider getProviderOverride(
    covariant GetProductImageProvider provider,
  ) {
    return call(
      productId: provider.productId,
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
  String? get name => r'getProductImageProvider';
}

/// See also [getProductImage].
class GetProductImageProvider extends FutureProvider<ProductImage> {
  /// See also [getProductImage].
  GetProductImageProvider({
    required int productId,
    required int colorId,
  }) : this._internal(
          (ref) => getProductImage(
            ref as GetProductImageRef,
            productId: productId,
            colorId: colorId,
          ),
          from: getProductImageProvider,
          name: r'getProductImageProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$getProductImageHash,
          dependencies: GetProductImageFamily._dependencies,
          allTransitiveDependencies:
              GetProductImageFamily._allTransitiveDependencies,
          productId: productId,
          colorId: colorId,
        );

  GetProductImageProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.productId,
    required this.colorId,
  }) : super.internal();

  final int productId;
  final int colorId;

  @override
  Override overrideWith(
    FutureOr<ProductImage> Function(GetProductImageRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: GetProductImageProvider._internal(
        (ref) => create(ref as GetProductImageRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        productId: productId,
        colorId: colorId,
      ),
    );
  }

  @override
  FutureProviderElement<ProductImage> createElement() {
    return _GetProductImageProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is GetProductImageProvider &&
        other.productId == productId &&
        other.colorId == colorId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, productId.hashCode);
    hash = _SystemHash.combine(hash, colorId.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin GetProductImageRef on FutureProviderRef<ProductImage> {
  /// The parameter `productId` of this provider.
  int get productId;

  /// The parameter `colorId` of this provider.
  int get colorId;
}

class _GetProductImageProviderElement
    extends FutureProviderElement<ProductImage> with GetProductImageRef {
  _GetProductImageProviderElement(super.provider);

  @override
  int get productId => (origin as GetProductImageProvider).productId;
  @override
  int get colorId => (origin as GetProductImageProvider).colorId;
}

String _$getProductByIdHash() => r'85c53bde7984ab4bd884b50a9ed4966036fb2fe1';

/// See also [getProductById].
@ProviderFor(getProductById)
const getProductByIdProvider = GetProductByIdFamily();

/// See also [getProductById].
class GetProductByIdFamily extends Family<AsyncValue<Product>> {
  /// See also [getProductById].
  const GetProductByIdFamily();

  /// See also [getProductById].
  GetProductByIdProvider call(
    int productId,
  ) {
    return GetProductByIdProvider(
      productId,
    );
  }

  @override
  GetProductByIdProvider getProviderOverride(
    covariant GetProductByIdProvider provider,
  ) {
    return call(
      provider.productId,
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
  String? get name => r'getProductByIdProvider';
}

/// See also [getProductById].
class GetProductByIdProvider extends FutureProvider<Product> {
  /// See also [getProductById].
  GetProductByIdProvider(
    int productId,
  ) : this._internal(
          (ref) => getProductById(
            ref as GetProductByIdRef,
            productId,
          ),
          from: getProductByIdProvider,
          name: r'getProductByIdProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$getProductByIdHash,
          dependencies: GetProductByIdFamily._dependencies,
          allTransitiveDependencies:
              GetProductByIdFamily._allTransitiveDependencies,
          productId: productId,
        );

  GetProductByIdProvider._internal(
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
    FutureOr<Product> Function(GetProductByIdRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: GetProductByIdProvider._internal(
        (ref) => create(ref as GetProductByIdRef),
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
  FutureProviderElement<Product> createElement() {
    return _GetProductByIdProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is GetProductByIdProvider && other.productId == productId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, productId.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin GetProductByIdRef on FutureProviderRef<Product> {
  /// The parameter `productId` of this provider.
  int get productId;
}

class _GetProductByIdProviderElement extends FutureProviderElement<Product>
    with GetProductByIdRef {
  _GetProductByIdProviderElement(super.provider);

  @override
  int get productId => (origin as GetProductByIdProvider).productId;
}

String _$getOrderStatusByIdHash() =>
    r'72bf9595dc6c1ba9cdb185a306d459741143b964';

/// See also [getOrderStatusById].
@ProviderFor(getOrderStatusById)
const getOrderStatusByIdProvider = GetOrderStatusByIdFamily();

/// See also [getOrderStatusById].
class GetOrderStatusByIdFamily extends Family<AsyncValue<OrderStatus>> {
  /// See also [getOrderStatusById].
  const GetOrderStatusByIdFamily();

  /// See also [getOrderStatusById].
  GetOrderStatusByIdProvider call(
    String orderId,
  ) {
    return GetOrderStatusByIdProvider(
      orderId,
    );
  }

  @override
  GetOrderStatusByIdProvider getProviderOverride(
    covariant GetOrderStatusByIdProvider provider,
  ) {
    return call(
      provider.orderId,
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
  String? get name => r'getOrderStatusByIdProvider';
}

/// See also [getOrderStatusById].
class GetOrderStatusByIdProvider
    extends AutoDisposeFutureProvider<OrderStatus> {
  /// See also [getOrderStatusById].
  GetOrderStatusByIdProvider(
    String orderId,
  ) : this._internal(
          (ref) => getOrderStatusById(
            ref as GetOrderStatusByIdRef,
            orderId,
          ),
          from: getOrderStatusByIdProvider,
          name: r'getOrderStatusByIdProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$getOrderStatusByIdHash,
          dependencies: GetOrderStatusByIdFamily._dependencies,
          allTransitiveDependencies:
              GetOrderStatusByIdFamily._allTransitiveDependencies,
          orderId: orderId,
        );

  GetOrderStatusByIdProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.orderId,
  }) : super.internal();

  final String orderId;

  @override
  Override overrideWith(
    FutureOr<OrderStatus> Function(GetOrderStatusByIdRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: GetOrderStatusByIdProvider._internal(
        (ref) => create(ref as GetOrderStatusByIdRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        orderId: orderId,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<OrderStatus> createElement() {
    return _GetOrderStatusByIdProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is GetOrderStatusByIdProvider && other.orderId == orderId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, orderId.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin GetOrderStatusByIdRef on AutoDisposeFutureProviderRef<OrderStatus> {
  /// The parameter `orderId` of this provider.
  String get orderId;
}

class _GetOrderStatusByIdProviderElement
    extends AutoDisposeFutureProviderElement<OrderStatus>
    with GetOrderStatusByIdRef {
  _GetOrderStatusByIdProviderElement(super.provider);

  @override
  String get orderId => (origin as GetOrderStatusByIdProvider).orderId;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
