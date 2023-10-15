class CoffeeModel {
  final String name;
  final String type;
  final double price;
  final String image;
  final String description;

  CoffeeModel({
    required this.description,
    required this.image,
    required this.name,
    required this.price,
    required this.type,
  });

  factory CoffeeModel.fromJson(Map<String, dynamic> json) {
    return CoffeeModel(
      description: json["description"] as String? ?? "",
      image: json["image"] as String? ?? "",
      name: json["name"] as String? ?? "",
      price: json["price"] as double? ?? 0.0,
      type: json["type"] as String? ?? "",
    );
  }
}
