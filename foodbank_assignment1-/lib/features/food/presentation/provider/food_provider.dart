import 'package:flutter/foundation.dart';
import '../../domain/entities/food_item.dart';
import '../../domain/repositories/food_repository.dart';
import '../../data/models/food_item_model.dart';

enum FoodStatus { initial, loading, success, error }

class FoodProvider extends ChangeNotifier {
  final FoodRepository repository;

  FoodProvider({required this.repository});

  List<FoodItem> _items = [];
  FoodItem? _selectedItem;
  FoodStatus _status = FoodStatus.initial;
  String _errorMessage = '';
  String _successMessage = '';

  List<FoodItem> get items => _items;
  FoodItem? get selectedItem => _selectedItem;
  FoodStatus get status => _status;
  String get errorMessage => _errorMessage;
  String get successMessage => _successMessage;
  bool get isLoading => _status == FoodStatus.loading;

  Future<void> loadFoodItems() async {
    _status = FoodStatus.loading;
    _errorMessage = '';
    notifyListeners();
    try {
      _items = await repository.getFoodItems();
      _status = FoodStatus.success;
    } catch (e) {
      _errorMessage = e.toString();
      _status = FoodStatus.error;
    }
    notifyListeners();
  }

  Future<void> loadFoodItemById(int id) async {
    _status = FoodStatus.loading;
    _selectedItem = null;
    _errorMessage = '';
    notifyListeners();
    try {
      _selectedItem = await repository.getFoodItemById(id);
      _status = FoodStatus.success;
    } catch (e) {
      _errorMessage = e.toString();
      _status = FoodStatus.error;
    }
    notifyListeners();
  }

  Future<bool> addFoodItem(FoodItem item) async {
    _status = FoodStatus.loading;
    _errorMessage = '';
    notifyListeners();
    try {
      await repository.addFoodItem(item);
      _successMessage = 'Item added successfully!';
      await loadFoodItems();
      return true;
    } catch (e) {
      _errorMessage = e.toString();
      _status = FoodStatus.error;
      notifyListeners();
      return false;
    }
  }

  Future<bool> updateFoodItem(FoodItem item) async {
    _status = FoodStatus.loading;
    _errorMessage = '';
    notifyListeners();
    try {
      await repository.updateFoodItem(item);
      _successMessage = 'Item updated successfully!';
      await loadFoodItems();
      return true;
    } catch (e) {
      _errorMessage = e.toString();
      _status = FoodStatus.error;
      notifyListeners();
      return false;
    }
  }

  Future<bool> deleteFoodItem(int id) async {
    _status = FoodStatus.loading;
    _errorMessage = '';
    notifyListeners();
    try {
      await repository.deleteFoodItem(id);
      _successMessage = 'Item deleted successfully!';
      await loadFoodItems();
      return true;
    } catch (e) {
      _errorMessage = e.toString();
      _status = FoodStatus.error;
      notifyListeners();
      return false;
    }
  }

  void clearMessages() {
    _successMessage = '';
    _errorMessage = '';
  }
}
