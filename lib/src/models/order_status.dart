// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class OrderStatus {
  final int? id;
  final String orderId;
  final bool ordered;
  final bool inTransit;
  final bool delivered;
  final bool cancelled;
  String? reason;
  OrderStatus({
    this.id,
    required this.orderId,
    required this.ordered,
    required this.inTransit,
    required this.delivered,
    required this.cancelled,
    required this.reason,
  });

  OrderStatus copyWith({
    int? id,
    String? orderId,
    bool? ordered,
    bool? inTransit,
    bool? delivered,
    bool? cancelled,
    String? reason,
  }) {
    return OrderStatus(
      id: id ?? this.id,
      orderId: orderId ?? this.orderId,
      ordered: ordered ?? this.ordered,
      inTransit: inTransit ?? this.inTransit,
      delivered: delivered ?? this.delivered,
      cancelled: cancelled ?? this.cancelled,
      reason: reason ?? this.reason,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'order_id': orderId,
      'ordered': ordered,
      'in_transit': inTransit,
      'delivered': delivered,
      'cancelled': cancelled,
      'reason': reason,
    };
  }

  factory OrderStatus.fromMap(Map<String, dynamic> map) {
    return OrderStatus(
      id: map['id'] != null ? map['id'] as int : null,
      orderId: map['order_id'] as String,
      ordered: map['ordered'] as bool,
      inTransit: map['in_transit'] as bool,
      delivered: map['delivered'] as bool,
      cancelled: map['cancelled'] as bool,
      reason: map['reason'] != null ? map['reason'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory OrderStatus.fromJson(String source) =>
      OrderStatus.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'OrderStatus(id: $id, orderId: $orderId, ordered: $ordered, inTransit: $inTransit, delivered: $delivered, cancelled: $cancelled, reason: $reason)';
  }

  @override
  bool operator ==(covariant OrderStatus other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.orderId == orderId &&
        other.ordered == ordered &&
        other.inTransit == inTransit &&
        other.delivered == delivered &&
        other.cancelled == cancelled &&
        other.reason == reason;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        orderId.hashCode ^
        ordered.hashCode ^
        inTransit.hashCode ^
        delivered.hashCode ^
        cancelled.hashCode ^
        reason.hashCode;
  }
}
