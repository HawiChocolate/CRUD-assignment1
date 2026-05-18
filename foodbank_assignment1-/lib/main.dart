import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'core/theme/app_theme.dart';
import 'features/food/data/datasources/food_remote_datasource.dart';
import 'features/food/data/repositories/food_repository_impl.dart';
import 'features/food/presentation/provider/food_provider.dart';
import 'features/food/presentation/pages/food_list_page.dart';

void main() {
  runApp(const FoodBankApp());
}

class FoodBankApp extends StatelessWidget {
  const FoodBankApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => FoodProvider(
        repository: FoodRepositoryImpl(
          datasource: FoodRemoteDatasourceImpl(),
        ),
      )..loadFoodItems(),
      child: MaterialApp(
        title: 'Food Bank',
        debugShowCheckedModeBanner: false,
        theme: AppTheme.lightTheme,
        home: const FoodListPage(),
      ),
    );
  }
}
