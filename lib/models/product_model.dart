class Product {
  final int id;
  final String imageUrl;
  final String name;
  final String category;
  final int price;
  final double rate;

  Product({
    required this.id,
    required this.imageUrl,
    required this.name,
    required this.category,
    required this.price,
    required this.rate,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: int.parse(json['id']),
      imageUrl: json['image_url'] ?? '',
      name: json['name'] ?? '',
      category: json['category'] ?? '',
      price: int.parse(json['price']),
      rate: json['rate'] != null ? double.parse(json['rate']) : 0.0,
    );
  }
}