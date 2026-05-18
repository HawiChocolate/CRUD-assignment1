import 'package:equatable/equatable.dart';

class FoodItem extends Equatable {
  final int id;
  final String name;
  final String description;
  final String category;
  final int quantity;
  final String imageUrl;

  const FoodItem({
    required this.id,
    required this.name,
    required this.description,
    required this.category,
    required this.quantity,
    required this.imageUrl,
  });

  @override
  List<Object> get props =>
      [id, name, description, category, quantity, imageUrl];
}
