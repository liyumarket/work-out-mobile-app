import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:work_out/config/Colors.dart';
import 'package:work_out/controller/category_controller.dart';
import 'package:work_out/controller/tabs%20controllers/workOutTabController.dart';
import 'package:work_out/view/screens/workoutsPages/AllWorkoutsPage.dart';

class CategoryList extends StatelessWidget {
  final CategoryController _categoryController = Get.put(CategoryController());
  final CustomTabBarController videoController =
      Get.find<CustomTabBarController>();
  CategoryList({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.darkBlue.withOpacity(0.07),
        title: const Text(
          'Categories',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            stops: const [0.45, 1],
            begin: Alignment.bottomCenter,
            end: Alignment.topCenter,
            colors: [
              AppColors.darkBlue,
              AppColors.darkBlue.withOpacity(0.05),
            ],
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              const SizedBox(
                height: 20,
              ),
              Obx(() {
                // Show loading indicator while fetching categories
                if (_categoryController.isLoading.value) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }

                // Show error message if there’s an error
                if (_categoryController.errorMessage.isNotEmpty) {
                  return Center(
                    child: Text(
                      _categoryController.errorMessage.value,
                      style: const TextStyle(color: Colors.red),
                    ),
                  );
                }

                // Display the list of categories once loaded
                if (_categoryController.categories.value.message != null) {
                  final categories =
                      _categoryController.categories.value.message!;
                  return Expanded(
                    child: ListView.builder(
                      itemCount: categories.length,
                      itemBuilder: (context, index) {
                        final category = categories[index];
                        return Card(
                          elevation: 4,
                          color: Colors.white.withOpacity(.4),
                          child: ListTile(
                            leading: const Icon(
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
                            onTap: () async {
                              await CustomTabBarController()
                                  .fetchVideosByCategory(category.id);
                            
                              Get.to(() => AllWorkoutsPage(), arguments: [
                                category.name,
                                 videoController.videos
                              ]);
                            },
                          ),
                        );
                      },
                    ),
                  );
                }

                // Handle empty state if there are no categories
                return const Center(
                  child: Text('No categories available'),
                );
              }),
            ],
          ),
        ),
      ),
    );
  }
}
