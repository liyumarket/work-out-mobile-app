import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomTabBarController extends GetxController
    with GetSingleTickerProviderStateMixin {
  // TabController
  late TabController workOutTabController;

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

  @override
  void onInit() {
    // init on init hah
    workOutTabController =
        TabController(vsync: this, length: workOutTabs.length);
    super.onInit();
  }

  @override
  void onClose() {
    // dispose
    workOutTabController.dispose();
    super.onClose();
  }
}
