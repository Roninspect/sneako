// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class Brand {
  final int id;
  final String name;
  final String logo;
  Brand({
    required this.id,
    required this.name,
    required this.logo,
  });

  Brand copyWith({
    int? id,
    String? name,
    String? logo,
  }) {
    return Brand(
      id: id ?? this.id,
      name: name ?? this.name,
      logo: logo ?? this.logo,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'logo': logo,
    };
  }

  factory Brand.fromMap(Map<String, dynamic> map) {
    return Brand(
      id: map['id'] as int,
      name: map['name'] as String,
      logo: map['logo'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory Brand.fromJson(String source) =>
      Brand.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'Brand(id: $id, name: $name, logo: $logo)';

  @override
  bool operator ==(covariant Brand other) {
    if (identical(this, other)) return true;

    return other.id == id && other.name == name && other.logo == logo;
  }

  @override
  int get hashCode => id.hashCode ^ name.hashCode ^ logo.hashCode;
}
