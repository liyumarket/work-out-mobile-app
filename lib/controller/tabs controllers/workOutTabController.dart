import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:work_out/controller/category_controller.dart';
import 'package:work_out/model/categories_response.dart';

class CustomTabBarController extends GetxController
    with GetTickerProviderStateMixin  {
  // TabController
  late TabController workOutTabController;
  final CategoryController _categoryController = Get.put(CategoryController());
  RxList<Message> categories = <Message>[].obs;
  // Tabs to show
  final List<Tab> workOutTabs = <Tab>[
    const Tab(
        child: Padding(
      padding: EdgeInsets.symmetric(horizontal: 10),
      child: Text("All"),
    )),
    const Tab(
        child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: Text("Popular"))),
    const Tab(
        child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: Text('Hard workout'))),
    const Tab(
        child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: Text('Full body'))),
    const Tab(
        child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: Text('Crossfit'))),
  ];
  void _updateTabs() {
    workOutTabs.clear();
    workOutTabs.add(
      const Tab(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 10),
          child: Text("All"),
        ),
      ),
    );
    for (var category in categories) {
      workOutTabs.add(
        Tab(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: Text(category.name??''),
          ),
        ),
      );
    }
    if (workOutTabController != null) {
      workOutTabController.dispose();
    }
    workOutTabController = TabController(vsync: this, length: workOutTabs.length);
    update();
  }

  @override
  void onInit() {
    // init on init hah
      workOutTabController = TabController(vsync: this, length: workOutTabs.length);
    categories.value = _categoryController.categories.value.message ?? [];
    _updateTabs();

    super.onInit();
  }

  @override
  void onClose() {
    // dispose
    workOutTabController.dispose();
    super.onClose();
  }
}
