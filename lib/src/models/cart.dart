// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:sneako/src/models/color.dart';
import 'package:sneako/src/models/product.dart';
import 'package:sneako/src/models/size.dart';

class Cart {
  int? id;
  final int productId;
  final int quantity;
  final String uid;
  final int color;
  final int size;
  ProductColor? colors;
  ProductSize? sizes;
  Product? product;
  Cart({
    this.id,
    required this.productId,
    required this.quantity,
    required this.uid,
    required this.color,
    required this.size,
    this.colors,
    this.sizes,
    this.product,
  });

  Cart copyWith({
    int? id,
    int? productId,
    int? quantity,
    String? uid,
    int? color,
    int? size,
    ProductColor? colors,
    ProductSize? sizes,
    Product? product,
  }) {
    return Cart(
      id: id ?? this.id,
      productId: productId ?? this.productId,
      quantity: quantity ?? this.quantity,
      uid: uid ?? this.uid,
      color: color ?? this.color,
      size: size ?? this.size,
      colors: colors ?? this.colors,
      sizes: sizes ?? this.sizes,
      product: product ?? this.product,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'product_id': productId,
      'quantity': quantity,
      'uid': uid,
      'color': color,
      'size': size,
    };
  }

  factory Cart.fromMap(Map<String, dynamic> map) {
    return Cart(
      id: map['id'] != null ? map['id'] as int : null,
      productId: map['product_id'] as int,
      quantity: map['quantity'] as int,
      uid: map['uid'] as String,
      color: map['color'] as int,
      size: map['size'] as int,
      colors: map['colors'] != null
          ? ProductColor.fromMap(map['colors'] as Map<String, dynamic>)
          : null,
      sizes: map['sizes'] != null
          ? ProductSize.fromMap(map['sizes'] as Map<String, dynamic>)
          : null,
      product: map['products'] != null
          ? Product.fromMap(map['products'] as Map<String, dynamic>)
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory Cart.fromJson(String source) =>
      Cart.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Cart(id: $id, productId: $productId, quantity: $quantity, uid: $uid, color: $color, size: $size, colors: $colors, sizes: $sizes, product: $product)';
  }

  @override
  bool operator ==(covariant Cart other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.productId == productId &&
        other.quantity == quantity &&
        other.uid == uid &&
        other.color == color &&
        other.size == size &&
        other.colors == colors &&
        other.sizes == sizes &&
        other.product == product;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        productId.hashCode ^
        quantity.hashCode ^
        uid.hashCode ^
        color.hashCode ^
        size.hashCode ^
        colors.hashCode ^
        sizes.hashCode ^
        product.hashCode;
  }
}
