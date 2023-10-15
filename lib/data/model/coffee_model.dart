import 'package:flutter/material.dart';

class CoffeeModel {
  String id;
  String name;
  double price;
  String picture;
  String pictureAlt;
  String description;

  CoffeeModel(
      {
        required this.id,
        required this.name,
      required this.price,
      required this.picture,
      required this.description,
      required this.pictureAlt});

  @override
  String toString() {
    return 'FoodDetail(title: $name, picture: $picture, description: $description, price: $price, pictureAlt: $pictureAlt, id: $id';
  }

  factory CoffeeModel.fromJson(Map<String, dynamic> json) => CoffeeModel(
    id: json["id"] as String? ?? "",
        name: json['title'] as String? ?? "",
        picture: json['picture'] as String? ?? "",
        description: json['description'] as String? ?? "",
        price: json["price"] as double? ?? 0.0,
        pictureAlt: json["picture_alt"] as String? ?? "",
      );

  Map<String, dynamic> toJson() => {
    'id': id,
        'name': name,
        'price': price,
        'picture': picture,
        'picture_alt': pictureAlt,
        'description': description,
      };

  CoffeeModel copyWith({
    String? id,
    String? name,
    double? price,
    String? picture,
    String? pictureAlt,
    String? description,
  }) {
    return CoffeeModel(
      id: id ?? this.id,
      name: name ?? this.name,
      price: price ?? this.price,
      picture: picture ?? this.picture,
      pictureAlt: pictureAlt ?? this.pictureAlt,
      description: description ?? this.description,
    );
  }
}

class Attribute {
  final Icon icon;
  final String title;

  Attribute({required this.icon, required this.title});
}
