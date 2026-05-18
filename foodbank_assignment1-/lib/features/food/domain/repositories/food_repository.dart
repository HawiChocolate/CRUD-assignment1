import '../entities/food_item.dart';

abstract class FoodRepository {
  Future<List<FoodItem>> getFoodItems();
  Future<FoodItem> getFoodItemById(int id);
  Future<FoodItem> addFoodItem(FoodItem item);
  Future<FoodItem> updateFoodItem(FoodItem item);
  Future<void> deleteFoodItem(int id);
}
