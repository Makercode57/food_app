class Product {
  final String name;
  final int price;
  final String imageUrl;
  final String category;
  bool isFavorite;
  double rating;
  List<String> ingredients;
  Map<String, String> nutritionInfo;
  String description;  
  List<String> tags;   

  Product({
    required this.name,
    required this.price,
    required this.imageUrl,
    required this.category,
    this.isFavorite = false,
    this.rating = 0.0,
    this.ingredients = const [],
    this.nutritionInfo = const {},
    this.description = '', 
    this.tags = const [],  
  });

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'price': price,
      'imageUrl': imageUrl,
      'category': category,
      'isFavorite': isFavorite,
      'rating': rating,
      'ingredients': ingredients,
      'nutritionInfo': nutritionInfo,
      'description': description, 
      'tags': tags,               
    };
  }

  factory Product.fromMap(Map<String, dynamic> map) {
    return Product(
      name: map['name'],
      price: map['price'],
      imageUrl: map['imageUrl'],
      category: map['category'],
      isFavorite: map['isFavorite'] ?? false,
      rating: (map['rating'] ?? 0.0).toDouble(),
      ingredients: List<String>.from(map['ingredients'] ?? []),
      nutritionInfo: Map<String, String>.from(map['nutritionInfo'] ?? {}),
      description: map['description'] ?? '', 
      tags: List<String>.from(map['tags'] ?? []), 
    );
  }
}
