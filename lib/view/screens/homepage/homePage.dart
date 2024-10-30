import 'package:delayed_display/delayed_display.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:work_out/config/Colors.dart';
import 'package:work_out/controller/category_controller.dart';
import 'package:work_out/service/local_storage_service.dart';

import '../../../controller/functionsController.dart';
import '../../../controller/tabs controllers/workOutTabController.dart';
import '../../../config/images sources.dart';
import '../../../helpers/string_methods.dart';
import '../../widgets/general_widgets/screen_background_image.dart';
import 'componenets/HomePageSearchBar.dart';
import 'componenets/find_your_workout.dart';
import 'componenets/playButton.dart';
import 'componenets/tabBarViewSections.dart';

class HomePage extends StatefulWidget {
  HomePage({
    Key? key,
  }) : super(key: key);

  final String bgImg = ImgSrc().randomFromAssetsList();
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {


  final CategoryController _categoryController = Get.put(CategoryController());
  final CustomTabBarController _tabx = Get.put(CustomTabBarController());
@override
  void initState() {
    // TODO: implement initState
    print('home called');
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
      children: [
        BackgroundImage(
          backgroundImage: widget.bgImg,
        ),
        Container(
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
          width: double.infinity,
          child: SingleChildScrollView(
            child: ConstrainedBox(
              constraints: BoxConstraints(
                maxHeight: MediaQuery.of(context).size.height,
                maxWidth: MediaQuery.of(context).size.width,
              ),
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    const SizedBox(
                      height: 30,
                    ),
                   Align(
                    alignment: Alignment.topRight,
                     child: IconButton(onPressed: (){
                      Get.offAndToNamed('/');
                      SharedPreferencesService().removeValue('token');
                     }, icon: Icon(Icons.logout,color: Colors.white,size: 40,)),
                   ),
                    const SizedBox(
                      height: 55,
                    ),
                    DelayedDisplay(
                      delay: Duration(milliseconds: delay + 100),
                      child: PlayButton(),
                    ),
                    const SizedBox(
                      height: 55,
                    ),
                   
                  
                    SizedBox(
                      height: 45,
                      child: DelayedDisplay(
                        delay: Duration(milliseconds: delay + 300),
                        child: const HomePageSearchBar(),
                      ),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    SizedBox(
                      height: 40,
                      child: DelayedDisplay(
                        delay: Duration(
                          milliseconds: delay + 400,
                        ),
                        child: Obx(() {
                          // Ensure workOutTabController is initialized
                          if (_tabx.workOutTabs.isNotEmpty) {
                            return TabBar(
                              labelColor: Colors.white,
                              labelStyle: const TextStyle(color: Colors.white),
                              unselectedLabelColor: Colors.white,
                              unselectedLabelStyle:
                                  const TextStyle(color: Colors.white),
                              labelPadding:
                                  const EdgeInsets.symmetric(horizontal: 5),
                              isScrollable: true,
                              indicator: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                border: Border.all(
                                  color: Theme.of(context).primaryColor,
                                  width: 2,
                                ),
                              ),
                              controller: _tabx.workOutTabController,
                              tabs: _tabx.workOutTabs,
                            );
                          } else {
                            // Handle case when tabs are not yet initialized
                            return const Center(
                              child: CircularProgressIndicator(),
                            );
                          }
                        }),
                      ),
                    ),
                    Expanded(
                      child: DelayedDisplay(
                        delay: Duration(milliseconds: delay + 600),
                        child: Obx(() => _tabx.workOutTabs.isNotEmpty
                            ? TabBarView(
                                controller: _tabx.workOutTabController,
                                children: [
                                  Center(
                                    child: TabBarViewSection(
                                      title: capitalize(
                                        _tabx.selectedCategory.value.name ?? '',
                                      ),
                                      dataList: _tabx.videos,
                                    ),
                                  ),
                                ],
                              )
                            : const SizedBox()),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    ));
  }
}
