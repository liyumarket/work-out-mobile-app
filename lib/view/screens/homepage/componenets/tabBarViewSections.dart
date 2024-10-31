import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:work_out/controller/functionsController.dart';
import 'package:work_out/config/images%20sources.dart';
import 'package:work_out/model/video_by_category.dart';

import '../../../../config/text.dart';
import '../../../../helpers/string_methods.dart';
import '../../workoutsPages/AllWorkoutsPage.dart';
import 'WorkOutCard.dart';

class TabBarViewSection extends StatelessWidget {
  TabBarViewSection({
    Key? key,
    required this.title,
    required this.dataList,
    this.itemsToShow = 3,
    this.hasSeeAllButton = true,
  }) : super(key: key);
  String title;
  List<SingleVideo> dataList;
  bool hasSeeAllButton;
  int itemsToShow;
  final FunctionsController controller = Get.put(FunctionsController());
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(
          height: 10,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              title,
              style: const TextStyle(
                fontSize: 33,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            GestureDetector(
              onTap: () {
                Get.to(AllWorkoutsPage(), arguments: [title, dataList]);
              },
              child: Visibility(
                visible: hasSeeAllButton,
                child: Container(
                  margin: const EdgeInsets.only(right: 5),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.white.withOpacity(.1),
                  ),
                  child: Text(
                    capitalize(AppTexts.seeAll),
                    style: TextStyle(color: Theme.of(context).primaryColor),
                  ),
                ),
              ),
            ),
          ],
        ),
        const SizedBox(
          height: 20,
        ),
        dataList.isEmpty
            ? const Center(
                child: Text(
                  'we are adding workouts visit after a while',
                  style: TextStyle(color: Colors.white),
                ),
              )
            : SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                physics: const BouncingScrollPhysics(),
                child: Obx(() => Wrap(
                      children: [
                        ...List.generate(
                           dataList.length,
                          (index) => WorkOutCard(
                              index: index,
                              listCollection: dataList,
                              title: capitalize(
                                dataList[index].title ??
                                    AppTexts.somethingWrong,
                              ),
                              videoUrl:
                                  'http://128.140.107.116:4400/api/v1/admin/video/${dataList[index].id}',
                              imagePath: dataList[index].image ??
                                  ImgSrc.noImgAvailable),
                        )
                      ],
                    )),
              )
      ],
    );
  }
}
