// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class UserModel {
  final String id;
  final String username;
  final String email;
  String? profile;
  final String phone;
  final String shippingAddress;
  UserModel({
    required this.id,
    required this.username,
    required this.email,
    this.profile,
    required this.phone,
    required this.shippingAddress,
  });

  UserModel copyWith({
    String? id,
    String? username,
    String? email,
    String? profile,
    String? phone,
    String? shippingAddress,
  }) {
    return UserModel(
      id: id ?? this.id,
      username: username ?? this.username,
      email: email ?? this.email,
      profile: profile ?? this.profile,
      phone: phone ?? this.phone,
      shippingAddress: shippingAddress ?? this.shippingAddress,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'username': username,
      'email': email,
      'profile': profile,
      'phone': phone,
      'shippingAddress': shippingAddress,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      id: map['id'] as String,
      username: map['username'] as String,
      email: map['email'] as String,
      profile: map['profile'] != null ? map['profile'] as String : null,
      phone: map['phone'] as String,
      shippingAddress: map['shippingAddress'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory UserModel.fromJson(String source) =>
      UserModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'UserModel(id: $id, username: $username, email: $email, profile: $profile, phone: $phone, shippingAddress: $shippingAddress)';
  }

  @override
  bool operator ==(covariant UserModel other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.username == username &&
        other.email == email &&
        other.profile == profile &&
        other.phone == phone &&
        other.shippingAddress == shippingAddress;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        username.hashCode ^
        email.hashCode ^
        profile.hashCode ^
        phone.hashCode ^
        shippingAddress.hashCode;
  }
}
