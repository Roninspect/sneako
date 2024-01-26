// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class Product {
  final int id;
  final String title;
  final String description;
  final int mainPrice;
  final String gender;
  final String background;
  final int brand;
  int? discountedPrice;
  Product({
    required this.id,
    required this.title,
    required this.description,
    required this.mainPrice,
    required this.gender,
    required this.background,
    required this.brand,
    this.discountedPrice,
  });

  Product copyWith({
    int? id,
    String? title,
    String? description,
    int? mainPrice,
    String? gender,
    String? background,
    int? brand,
    int? discountedPrice,
  }) {
    return Product(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      mainPrice: mainPrice ?? this.mainPrice,
      gender: gender ?? this.gender,
      background: background ?? this.background,
      brand: brand ?? this.brand,
      discountedPrice: discountedPrice ?? this.discountedPrice,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'title': title,
      'description': description,
      'mainPrice': mainPrice,
      'gender': gender,
      'background': background,
      'brand': brand,
      'discountedPrice': discountedPrice,
    };
  }

  factory Product.fromMap(Map<String, dynamic> map) {
    return Product(
      id: map['id'] as int,
      title: map['title'] as String,
      description: map['description'] as String,
      mainPrice: map['mainPrice'] as int,
      gender: map['gender'] as String,
      background: map['background'] as String,
      brand: map['brand'] as int,
      discountedPrice:
          map['discountedPrice'] != null ? map['discountedPrice'] as int : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory Product.fromJson(String source) =>
      Product.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Product(id: $id, title: $title, description: $description, mainPrice: $mainPrice, gender: $gender, background: $background, brand: $brand, discountedPrice: $discountedPrice)';
  }

  @override
  bool operator ==(covariant Product other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.title == title &&
        other.description == description &&
        other.mainPrice == mainPrice &&
        other.gender == gender &&
        other.background == background &&
        other.brand == brand &&
        other.discountedPrice == discountedPrice;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        title.hashCode ^
        description.hashCode ^
        mainPrice.hashCode ^
        gender.hashCode ^
        background.hashCode ^
        brand.hashCode ^
        discountedPrice.hashCode;
  }
}
