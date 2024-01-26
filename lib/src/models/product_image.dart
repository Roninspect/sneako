// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class ProductImage {
  final int id;
  final String image;
  final int color;
  final int productId;
  ProductImage({
    required this.id,
    required this.image,
    required this.color,
    required this.productId,
  });

  ProductImage copyWith({
    int? id,
    String? image,
    int? color,
    int? productId,
  }) {
    return ProductImage(
      id: id ?? this.id,
      image: image ?? this.image,
      color: color ?? this.color,
      productId: productId ?? this.productId,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'image': image,
      'color': color,
      'product_id': productId,
    };
  }

  factory ProductImage.fromMap(Map<String, dynamic> map) {
    return ProductImage(
      id: map['id'] as int,
      image: map['image'] as String,
      color: map['color'] as int,
      productId: map['product_id'] as int,
    );
  }

  String toJson() => json.encode(toMap());

  factory ProductImage.fromJson(String source) =>
      ProductImage.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'ProductImage(id: $id, image: $image, color: $color, productId: $productId)';
  }

  @override
  bool operator ==(covariant ProductImage other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.image == image &&
        other.color == color &&
        other.productId == productId;
  }

  @override
  int get hashCode {
    return id.hashCode ^ image.hashCode ^ color.hashCode ^ productId.hashCode;
  }
}
