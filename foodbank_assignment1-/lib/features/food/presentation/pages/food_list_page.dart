import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../provider/food_provider.dart';
import '../widgets/food_item_card.dart';
import 'add_food_page.dart';
import 'food_detail_page.dart';
import 'search_food_page.dart';
import 'about_page.dart';

class FoodListPage extends StatelessWidget {
  const FoodListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Food Bank'),
        backgroundColor: Colors.green,
        foregroundColor: Colors.white,
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            tooltip: 'Search',
            onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const SearchFoodPage()),
            ),
          ),
          IconButton(
            icon: const Icon(Icons.info_outline),
            tooltip: 'About',
            onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const AboutPage()),
            ),
          ),
        ],
      ),
      body: Consumer<FoodProvider>(
        builder: (context, provider, _) {
          // Show success snackbar
          if (provider.successMessage.isNotEmpty) {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(provider.successMessage),
                  backgroundColor: Colors.green,
                ),
              );
              provider.clearMessages();
            });
          }

          // Show error snackbar
          if (provider.status == FoodStatus.error) {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(provider.errorMessage),
                  backgroundColor: Colors.red,
                ),
              );
            });
          }

          if (provider.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (provider.status == FoodStatus.error) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.error_outline, size: 48, color: Colors.red),
                  const SizedBox(height: 12),
                  Text('Error: ${provider.errorMessage}'),
                  const SizedBox(height: 12),
                  ElevatedButton(
                    onPressed: () => provider.loadFoodItems(),
                    child: const Text('Retry'),
                  ),
                ],
              ),
            );
          }

          if (provider.items.isEmpty) {
            return const Center(
              child: Text('No food items yet. Add one!'),
            );
          }

          return ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: provider.items.length,
            itemBuilder: (context, index) {
              final item = provider.items[index];
              return FoodItemCard(
                item: item,
                onTap: () async {
                  await Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => FoodDetailPage(itemId: item.id),
                    ),
                  );
                  if (context.mounted) {
                    provider.loadFoodItems();
                  }
                },
                onDelete: () {
                  showDialog(
                    context: context,
                    builder: (_) => AlertDialog(
                      title: const Text('Delete Item'),
                      content: Text('Delete "${item.name}"?'),
                      actions: [
                        TextButton(
                          onPressed: () => Navigator.pop(context),
                          child: const Text('Cancel'),
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                            provider.deleteFoodItem(item.id);
                          },
                          child: const Text('Delete',
                              style: TextStyle(color: Colors.red)),
                        ),
                      ],
                    ),
                  );
                },
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.green,
        foregroundColor: Colors.white,
        onPressed: () async {
          await Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => const AddFoodPage()),
          );
          if (context.mounted) {
            context.read<FoodProvider>().loadFoodItems();
          }
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
