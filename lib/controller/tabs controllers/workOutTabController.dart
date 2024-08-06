import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:work_out/controller/category_controller.dart';
import 'package:work_out/model/categories_response.dart';
import 'package:work_out/model/video_by_category.dart';
import 'package:work_out/service/dio_service.dart';
import 'package:work_out/service/local_storage_service.dart';

class CustomTabBarController extends GetxController
    with GetTickerProviderStateMixin {
  // TabController
  late TabController workOutTabController;
  final CategoryController _categoryController = Get.put(CategoryController());
  final DioService _dioService = DioService(); // Your DioService instance
  RxList<Message> categories = <Message>[].obs;
  Rx<Message> selectedCategory = Message().obs;
  // Tabs to show
  RxList<Tab> workOutTabs = <Tab>[].obs;
  RxList<SingleVideo> videos = <SingleVideo>[].obs; // Store fetched videos

  void _initializeTabController() {
    if (workOutTabs.isNotEmpty) {
      workOutTabController =
          TabController(vsync: this, length: workOutTabs.length);
      workOutTabController.addListener(_onTabChange);
    }
  }

  void _updateTabs() {
    workOutTabs.clear();

    for (var category in categories) {
      workOutTabs.add(
        Tab(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: Text(category.name ?? ''),
          ),
        ),
      );
    }
    _fetchVideosByCategory(categories.first.id);
    selectedCategory.value = categories.first;
    _initializeTabController();
    update();
  }

  void _onTabChange() async {
    if (workOutTabController.indexIsChanging) {
      selectedCategory.value = categories[workOutTabController.index];
      final selectedCategoryId = categories[workOutTabController.index].id;
      await _fetchVideosByCategory(selectedCategoryId);
    }
  }

  Future<void> _fetchVideosByCategory(int? categoryId) async {
    try {
      String token = SharedPreferencesService().getValue('token');

      final response = await _dioService.getRequest(
          'http://128.140.107.116:4400/api/v1/admin/getAllVideosByCategory/$categoryId',
          headers: {'x-api-key': token});
      videos.value = VideoByCategory.fromJson(response.data).message ??
          []; // Update videos list
    } catch (e) {
      print('Error fetching videos: $e');
    }
  }

  @override
  void onInit() {
    super.onInit();
    categories.bindStream(_categoryController.categories.stream
        .map((data) => data.message ?? []));

    categories.listen((_) {
      if (categories.isNotEmpty) {
        _updateTabs();
      }
    });
  }

  @override
  void onClose() {
    if (workOutTabController != null) {
      workOutTabController.removeListener(_onTabChange);
      workOutTabController.dispose();
    }
    super.onClose();
  }
}
