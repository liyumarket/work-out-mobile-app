import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:work_out/controller/category_controller.dart';

class CategoryList extends StatelessWidget {
  final CategoryController _categoryController = Get.put(CategoryController());

  CategoryList({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Categories'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            const SizedBox(
              height: 20,
            ),
            Obx(() {
              // Show loading indicator while fetching categories
              if (_categoryController.isLoading.value) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
        
              // Show error message if there’s an error
              if (_categoryController.errorMessage.isNotEmpty) {
                return Center(
                  child: Text(
                    _categoryController.errorMessage.value,
                    style: TextStyle(color: Colors.red),
                  ),
                );
              }
        
              // Display the list of categories once loaded
              if (_categoryController.categories.value.message != null) {
                final categories = _categoryController.categories.value.message!;
                return Expanded(
                  child: ListView.builder(
                    itemCount: categories.length,
                    itemBuilder: (context, index) {
                      final category = categories[index];
                      return Card(
                        elevation: 4,
                        color: Colors.white.withOpacity(.4),
                        child: ListTile(
                          leading: Icon(
                            Icons.sports_gymnastics,
                            size: 30,
                          ),
                          title: Text(
                            category.name ?? 'Unnamed Category',
                          ),
                          subtitle: Text(
                            category.description ?? '',
                          ),
                          trailing: Container(
                            margin: const EdgeInsets.only(right: 5),
                            padding: const EdgeInsets.symmetric(
                                horizontal: 12, vertical: 6),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: Colors.white.withOpacity(.1),
                            ),
                            child: Text(
                              '${category.price} Birr',
                              style: TextStyle(
                                  color: Theme.of(context).primaryColor),
                            ),
                          ),
                          onTap: () {
                            // Handle category item tap if needed
                          },
                        ),
                      );
                    },
                  ),
                );
              }
        
              // Handle empty state if there are no categories
              return Center(
                child: Text('No categories available'),
              );
            }),
          ],
        ),
      ),
    );
  }
}
