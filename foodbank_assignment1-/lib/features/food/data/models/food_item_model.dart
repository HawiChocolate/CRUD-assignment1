import '../../domain/entities/food_item.dart';

class FoodItemModel extends FoodItem {
  const FoodItemModel({
    required super.id,
    required super.name,
    required super.description,
    required super.category,
    required super.quantity,
    required super.imageUrl,
  });

  factory FoodItemModel.fromJson(Map<String, dynamic> json) {
    return FoodItemModel(
      id: json['id'] ?? 0,
      name: json['title'] ?? 'Unknown Item',
      description: json['description'] ?? 'No description available',
      category: json['category'] ?? 'Food Bank Item',
      quantity: json['stock'] ?? 20,
      imageUrl: (json['images'] != null && (json['images'] as List).isNotEmpty)
          ? json['images'][0]
          : json['thumbnail'] ?? 'https://picsum.photos/300/200',
    );
  }

  Map<String, dynamic> toJson() => {
        'title': name,
        'description': description,
        'category': category,
        'price': 9.99, // DummyJSON requires this field
        'stock': quantity,
      };

  static FoodItemModel fromEntity(FoodItem item) => FoodItemModel(
        id: item.id,
        name: item.name,
        description: item.description,
        category: item.category,
        quantity: item.quantity,
        imageUrl: item.imageUrl,
      );
}
