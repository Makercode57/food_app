class FoodItem {
  final String name;
  final double price;
  final String imageUrl;
  final String category;

  FoodItem({
    required this.name,
    required this.price,
    required this.imageUrl,
    required this.category,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is FoodItem &&
          runtimeType == other.runtimeType &&
          name == other.name;

  @override
  int get hashCode => name.hashCode;
}