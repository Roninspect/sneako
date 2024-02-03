// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:sneako/src/models/color.dart';
import 'package:sneako/src/models/size.dart';

class ProductAttribute {
  final int id;
  final int productId;
  ProductColor? colors;
  ProductSize? sizes;
  final int quantity;
  ProductAttribute({
    required this.id,
    required this.productId,
    required this.colors,
    required this.sizes,
    required this.quantity,
  });

  ProductAttribute copyWith({
    int? id,
    int? productId,
    ProductColor? colors,
    ProductSize? sizes,
    int? quantity,
  }) {
    return ProductAttribute(
      id: id ?? this.id,
      productId: productId ?? this.productId,
      colors: colors ?? this.colors,
      sizes: sizes ?? this.sizes,
      quantity: quantity ?? this.quantity,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'product_id': productId,
      'quantity': quantity,
    };
  }

  factory ProductAttribute.fromMap(Map<String, dynamic> map) {
    return ProductAttribute(
      id: map['id'] as int,
      productId: map['product_id'] as int,
      colors: map['colors'] != null
          ? ProductColor.fromMap(map['colors'] as Map<String, dynamic>)
          : null,
      sizes: map['sizes'] != null
          ? ProductSize.fromMap(map['sizes'] as Map<String, dynamic>)
          : null,
      quantity: map['quantity'] as int,
    );
  }

  String toJson() => json.encode(toMap());

  factory ProductAttribute.fromJson(String source) =>
      ProductAttribute.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'ProductAttribute(id: $id, productId: $productId, colors: $colors, sizes: $sizes, quantity: $quantity)';
  }

  @override
  bool operator ==(covariant ProductAttribute other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.productId == productId &&
        other.colors == colors &&
        other.sizes == sizes &&
        other.quantity == quantity;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        productId.hashCode ^
        colors.hashCode ^
        sizes.hashCode ^
        quantity.hashCode;
  }
}
