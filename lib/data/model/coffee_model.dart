class CoffeeModel {
  String name;
  String description;
  double price;
  String type;
  String image;

  CoffeeModel({
    required this.name,
    required this.description,
    required this.price,
    required this.type,
    required this.image,
  });

  CoffeeModel copyWith({
    String? name,
    String? description,
    double? price,
    String? type,
    String? image,
  }) =>
      CoffeeModel(
        name: name ?? this.name,
        description: description ?? this.description,
        price: price ?? this.price,
        type: type ?? this.type,
        image: image ?? this.image,
      );

  factory CoffeeModel.fromJson(Map<String, dynamic> json) => CoffeeModel(
        name: json["name"] as String? ?? "",
        description: json["description"] as String? ?? "",
        price: json["price"] as double? ?? 0.0,
        type: json["type"] as String? ?? "",
        image: json["image"] as String? ?? "",
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "description": description,
        "price": price,
        "type": type,
        "image": image,
      };
}
