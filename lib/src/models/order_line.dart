// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:sneako/src/models/product_attributes.dart';

class OrderLine {
  final int? id;
  final DateTime? ordered_at;
  final String order_id;
  final int pa_id;
  final int quantity;
  final int price;
  ProductAttribute? productAttribute;
  OrderLine({
    this.id,
    this.ordered_at,
    required this.order_id,
    required this.pa_id,
    required this.quantity,
    required this.price,
    this.productAttribute,
  });

  OrderLine copyWith({
    int? id,
    DateTime? ordered_at,
    String? order_id,
    int? pa_id,
    int? quantity,
    int? price,
    OrderLine? orderline,
    ProductAttribute? productAttribute,
  }) {
    return OrderLine(
      id: id ?? this.id,
      ordered_at: ordered_at ?? this.ordered_at,
      order_id: order_id ?? this.order_id,
      pa_id: pa_id ?? this.pa_id,
      quantity: quantity ?? this.quantity,
      price: price ?? this.price,
      productAttribute: productAttribute ?? this.productAttribute,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'order_id': order_id,
      'pa_id': pa_id,
      'quantity': quantity,
      'price': price,
    };
  }

  factory OrderLine.fromMap(Map<String, dynamic> map) {
    return OrderLine(
        id: map['id'] != null ? map['id'] as int : null,
        ordered_at: map['ordered_at'] != null
            ? DateTime.parse(map['ordered_at'] as String)
            : null,
        order_id: map['order_id'] as String,
        pa_id: map['pa_id'] as int,
        quantity: map['quantity'] as int,
        price: map['price'] as int,
        productAttribute: ProductAttribute.fromMap(map['product_attributes']));
  }

  String toJson() => json.encode(toMap());

  factory OrderLine.fromJson(String source) =>
      OrderLine.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'OrderLine(id: $id, ordered_at: $ordered_at, order_id: $order_id, pa_id: $pa_id, quantity: $quantity, price: $price)';
  }

  @override
  bool operator ==(covariant OrderLine other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.ordered_at == ordered_at &&
        other.order_id == order_id &&
        other.pa_id == pa_id &&
        other.quantity == quantity &&
        other.price == price &&
        other.productAttribute == productAttribute;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        ordered_at.hashCode ^
        order_id.hashCode ^
        pa_id.hashCode ^
        quantity.hashCode ^
        productAttribute.hashCode ^
        price.hashCode;
  }
}
