// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:sneako/src/models/product.dart';

class Favourite {
  final int? id;
  final int productId;
  final String uid;
  final Product? products;
  Favourite({
    this.id,
    required this.productId,
    required this.uid,
    this.products,
  });

  Favourite copyWith({
    int? id,
    int? productId,
    String? uid,
    Product? products,
  }) {
    return Favourite(
      id: id ?? this.id,
      productId: productId ?? this.productId,
      uid: uid ?? this.uid,
      products: products ?? this.products,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'productId': productId,
      'uid': uid,
    };
  }

  factory Favourite.fromMap(Map<String, dynamic> map) {
    return Favourite(
      id: map['id'] != null ? map['id'] as int : null,
      productId: map['productId'] as int,
      uid: map['uid'] as String,
      products: map['products'] != null
          ? Product.fromMap(map['products'] as Map<String, dynamic>)
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory Favourite.fromJson(String source) =>
      Favourite.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Favourite(id: $id, productId: $productId, uid: $uid, products: $products)';
  }

  @override
  bool operator ==(covariant Favourite other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.productId == productId &&
        other.uid == uid &&
        other.products == products;
  }

  @override
  int get hashCode {
    return id.hashCode ^ productId.hashCode ^ uid.hashCode ^ products.hashCode;
  }
}
