// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class Offer {
  final int id;
  final String title;
  final String background;
  final String colorCode;
  final String extraText;
  String? pagePath;
  String? productId;
  String? moreText;
  final String textColor;
  Offer({
    required this.id,
    required this.title,
    required this.background,
    required this.colorCode,
    required this.extraText,
    this.pagePath,
    this.productId,
    this.moreText,
    required this.textColor,
  });

  Offer copyWith({
    int? id,
    String? title,
    String? background,
    String? colorCode,
    String? extraText,
    String? pagePath,
    String? productId,
    String? moreText,
    String? textColor,
  }) {
    return Offer(
      id: id ?? this.id,
      title: title ?? this.title,
      background: background ?? this.background,
      colorCode: colorCode ?? this.colorCode,
      extraText: extraText ?? this.extraText,
      pagePath: pagePath ?? this.pagePath,
      productId: productId ?? this.productId,
      moreText: moreText ?? this.moreText,
      textColor: textColor ?? this.textColor,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'title': title,
      'background': background,
      'colorCode': colorCode,
      'extraText': extraText,
      'pagePath': pagePath,
      'productId': productId,
      'moreText': moreText,
      'textColor': textColor,
    };
  }

  factory Offer.fromMap(Map<String, dynamic> map) {
    return Offer(
      id: map['id'] as int,
      title: map['title'] as String,
      background: map['background'] as String,
      colorCode: map['colorCode'] as String,
      extraText: map['extraText'] as String,
      pagePath: map['pagePath'] != null ? map['pagePath'] as String : null,
      productId: map['productId'] != null ? map['productId'] as String : null,
      moreText: map['moreText'] != null ? map['moreText'] as String : null,
      textColor: map['textColor'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory Offer.fromJson(String source) =>
      Offer.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Offer(id: $id, title: $title, background: $background, colorCode: $colorCode, extraText: $extraText, pagePath: $pagePath, productId: $productId, moreText: $moreText, textColor: $textColor)';
  }

  @override
  bool operator ==(covariant Offer other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.title == title &&
        other.background == background &&
        other.colorCode == colorCode &&
        other.extraText == extraText &&
        other.pagePath == pagePath &&
        other.productId == productId &&
        other.moreText == moreText &&
        other.textColor == textColor;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        title.hashCode ^
        background.hashCode ^
        colorCode.hashCode ^
        extraText.hashCode ^
        pagePath.hashCode ^
        productId.hashCode ^
        moreText.hashCode ^
        textColor.hashCode;
  }
}
