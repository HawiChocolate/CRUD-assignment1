import '../../domain/entities/food_item.dart';
import '../../domain/repositories/food_repository.dart';
import '../datasources/food_remote_datasource.dart';
import '../models/food_item_model.dart';

class FoodRepositoryImpl implements FoodRepository {
  final FoodRemoteDatasource datasource;
  FoodRepositoryImpl({required this.datasource});

  @override
  Future<List<FoodItem>> getFoodItems() => datasource.getFoodItems();

  @override
  Future<FoodItem> getFoodItemById(int id) => datasource.getFoodItemById(id);

  @override
  Future<FoodItem> addFoodItem(FoodItem item) =>
      datasource.addFoodItem(FoodItemModel.fromEntity(item));

  @override
  Future<FoodItem> updateFoodItem(FoodItem item) =>
      datasource.updateFoodItem(FoodItemModel.fromEntity(item));

  @override
  Future<void> deleteFoodItem(int id) => datasource.deleteFoodItem(id);
}
