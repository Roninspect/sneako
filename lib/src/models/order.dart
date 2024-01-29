// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:sneako/src/models/product.dart';

class ProductOrder {
  final String? id;
  final DateTime? order_date;
  final String uid;
  final String address;
  final int order_total;
  final String? trxId;
  final String orderStatus;
  ProductOrder({
    this.id,
    this.order_date,
    required this.uid,
    required this.address,
    required this.order_total,
    this.trxId,
    required this.orderStatus,
  });

  ProductOrder copyWith({
    String? id,
    DateTime? order_date,
    String? uid,
    String? address,
    int? order_total,
    String? trxId,
    String? orderStatus,
  }) {
    return ProductOrder(
      id: id ?? this.id,
      order_date: order_date ?? this.order_date,
      uid: uid ?? this.uid,
      address: address ?? this.address,
      order_total: order_total ?? this.order_total,
      trxId: trxId ?? this.trxId,
      orderStatus: orderStatus ?? this.orderStatus,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'uid': uid,
      'shipping_address': address,
      'order_total': order_total,
      'order_status': orderStatus,
    };
  }

  factory ProductOrder.fromMap(Map<String, dynamic> map) {
    return ProductOrder(
      id: map['id'] != null ? map['id'] as String : null,
      order_date: map['order_date'] != null
          ? DateTime.parse(map['order_date'] as String)
          : null,
      uid: map['uid'] as String,
      address: map['address'] as String,
      order_total: map['order_total'] as int,
      trxId: map['trxId'] as String,
      orderStatus: map['order_status'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory ProductOrder.fromJson(String source) =>
      ProductOrder.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Order(id: $id, order_date: $order_date, uid: $uid, address: $address, order_total: $order_total, trxId: $trxId, order_status: $orderStatus)';
  }

  @override
  bool operator ==(covariant ProductOrder other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.order_date == order_date &&
        other.uid == uid &&
        other.address == address &&
        other.order_total == order_total &&
        other.trxId == trxId &&
        other.orderStatus == orderStatus;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        order_date.hashCode ^
        uid.hashCode ^
        address.hashCode ^
        order_total.hashCode ^
        trxId.hashCode ^
        orderStatus.hashCode;
  }
}
