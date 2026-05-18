import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/food_item_model.dart';

abstract class FoodRemoteDatasource {
  Future<List<FoodItemModel>> getFoodItems();
  Future<FoodItemModel> getFoodItemById(int id);
  Future<FoodItemModel> addFoodItem(FoodItemModel item);
  Future<FoodItemModel> updateFoodItem(FoodItemModel item);
  Future<void> deleteFoodItem(int id);
}

class FoodRemoteDatasourceImpl implements FoodRemoteDatasource {
  static const String _baseUrl = 'https://jsonplaceholder.typicode.com';

  final http.Client _client;

  FoodRemoteDatasourceImpl({http.Client? client})
      : _client = client ?? http.Client();

  @override
  Future<List<FoodItemModel>> getFoodItems() async {
    final response = await _client.get(
      Uri.parse('$_baseUrl/posts'),
      headers: {'Content-Type': 'application/json'},
    );
    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      return data.map((e) => FoodItemModel.fromJson(e)).toList();
    }
    throw Exception('Failed to load items. Status: ${response.statusCode}');
  }

  @override
  Future<FoodItemModel> getFoodItemById(int id) async {
    final response = await _client.get(
      Uri.parse('$_baseUrl/posts/$id'),
      headers: {'Content-Type': 'application/json'},
    );
    if (response.statusCode == 200) {
      return FoodItemModel.fromJson(json.decode(response.body));
    }
    throw Exception('Failed to load item. Status: ${response.statusCode}');
  }

  @override
  Future<FoodItemModel> addFoodItem(FoodItemModel item) async {
    final response = await _client.post(
      Uri.parse('$_baseUrl/posts'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(item.toJson()),
    );
    if (response.statusCode == 201) {
      return FoodItemModel.fromJson(json.decode(response.body));
    }
    throw Exception('Failed to add item. Status: ${response.statusCode}');
  }

  @override
  Future<FoodItemModel> updateFoodItem(FoodItemModel item) async {
    final response = await _client.put(
      Uri.parse('$_baseUrl/posts/${item.id}'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(item.toJson()),
    );
    if (response.statusCode == 200) {
      return FoodItemModel.fromJson(json.decode(response.body));
    }
    throw Exception('Failed to update item. Status: ${response.statusCode}');
  }

  @override
  Future<void> deleteFoodItem(int id) async {
    final response = await _client.delete(
      Uri.parse('$_baseUrl/posts/$id'),
      headers: {'Content-Type': 'application/json'},
    );
    if (response.statusCode != 200) {
      throw Exception('Failed to delete item. Status: ${response.statusCode}');
    }
  }
}
