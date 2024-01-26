// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class Address {
  int? id;
  final String uid;
  final String name;
  final String address;
  final bool isDefault;
  Address({
    this.id,
    required this.uid,
    required this.name,
    required this.address,
    required this.isDefault,
  });
  Address copyWith({
    int? id,
    String? uid,
    String? name,
    String? address,
    bool? isDefault,
  }) {
    return Address(
      id: id ?? this.id,
      uid: uid ?? this.uid,
      name: name ?? this.name,
      address: address ?? this.address,
      isDefault: isDefault ?? this.isDefault,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'uid': uid,
      'name': name,
      'address': address,
      'isDefault': isDefault,
    };
  }

  factory Address.fromMap(Map<String, dynamic> map) {
    return Address(
      id: map['id'] as int,
      uid: map['uid'] as String,
      name: map['name'] as String,
      address: map['address'] as String,
      isDefault: map['isDefault'] as bool,
    );
  }

  String toJson() => json.encode(toMap());

  factory Address.fromJson(String source) =>
      Address.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Address(id: $id, uid: $uid, name: $name, address: $address, isDefault: $isDefault)';
  }

  @override
  bool operator ==(covariant Address other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.uid == uid &&
        other.name == name &&
        other.address == address &&
        other.isDefault == isDefault;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        uid.hashCode ^
        name.hashCode ^
        address.hashCode ^
        isDefault.hashCode;
  }
}
