import 'package:flutter/material.dart';

class FoodDetail {
  String? name;
  List<Attribute>? attributes;
  String? picture;
  String? pictureAlt;
  String? description;
  ColorScheme? colorScheme;
  Color? textColor;

  FoodDetail(
      {this.name,
      this.attributes,
      this.picture,
      this.description,
      this.textColor,
      this.colorScheme,
      this.pictureAlt});

  @override
  String toString() {
    return 'FoodDetail(title: $name, attributes: $attributes, picture: $picture, description: $description,backgroundColor:$colorScheme';
  }

  factory FoodDetail.fromJson(Map<String, dynamic> json) => FoodDetail(
      name: json['title'] as String?,
      attributes: json['attributes'] as List<Attribute>?,
      picture: json['picture'] as String?,
      description: json['description'] as String?,
      colorScheme: json['colorScheme'] as ColorScheme?);

  Map<String, dynamic> toJson() => {
        'title': name,
        'attributes': attributes,
        'picture': picture,
        'description': description,
      };

  FoodDetail copyWith({
    String? name,
    List<Attribute>? attributes,
    String? picture,
    String? description,
    String? method,
  }) {
    return FoodDetail(
      name: name ?? this.name,
      attributes: attributes ?? this.attributes,
      picture: picture ?? this.picture,
      description: description ?? this.description,
    );
  }
}

class Attribute {
  final Icon icon;
  final String title;
  Attribute({required this.icon, required this.title});
}
