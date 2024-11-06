class Item {
  Item(
      {required this.image,
      required this.name,
      required this.category,
      required this.price,
      required this.description,
      required this.quantity});

  final String image;

  final String name;
  final double price;
  final String description;
  final String category;
  int quantity;

  factory Item.fromJson(Map<String, dynamic> json) {
    return Item(
      quantity: 0,
      image: json['image'],
      description: json['description'] ?? '',
      price: double.parse(json['price'].toString()),
      name: json['title'],
      category: json['category'] ?? '',
    );
  }
}
