// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class ProductColor {
  final int id;
  final String colorCode;
  final String name;
  ProductColor({
    required this.id,
    required this.colorCode,
    required this.name,
  });

  ProductColor copyWith({
    int? id,
    String? colorCode,
    String? name,
  }) {
    return ProductColor(
      id: id ?? this.id,
      colorCode: colorCode ?? this.colorCode,
      name: name ?? this.name,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'colorCode': colorCode,
      'name': name,
    };
  }

  factory ProductColor.fromMap(Map<String, dynamic> map) {
    return ProductColor(
      id: map['id'] as int,
      colorCode: map['colorCode'] as String,
      name: map['name'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory ProductColor.fromJson(String source) =>
      ProductColor.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'Color(id: $id, colorCode: $colorCode, name: $name)';

  @override
  bool operator ==(covariant ProductColor other) {
    if (identical(this, other)) return true;

    return other.id == id && other.colorCode == colorCode && other.name == name;
  }

  @override
  int get hashCode => id.hashCode ^ colorCode.hashCode ^ name.hashCode;
}
