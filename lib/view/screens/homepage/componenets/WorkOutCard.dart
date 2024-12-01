import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:work_out/config/Colors.dart';
import 'package:work_out/service/local_storage_service.dart';
import 'package:work_out/view/screens/homepage/componenets/token_image.dart';
import 'package:work_out/view/screens/work%20out%20details/video_player.dart';

import '../../work out details/workOutDetails.dart';

class WorkOutCard extends StatelessWidget {
  WorkOutCard({
    super.key,
    required this.title,
    required this.imagePath,
    required this.listCollection,
    required this.index,
    required this.videoUrl,
    this.id,
  });

  String title;
  String imagePath;
  final String videoUrl;
  final int? id;
  List listCollection;
  int index;

  @override
  Widget build(BuildContext context) {
    String token = SharedPreferencesService().getValue('token');

    return GestureDetector(
      onTap: () {
        Get.to(VideoPlayerWidget(
          videoUrl: videoUrl,
        ));
        // Get.to(WorkOutDetails(
        //   workOutTitle: title,
        //   overlayedImg: '',
        //   timeLeftInHour: listCollection[index]["timeLeftInHour"] ?? "?",
        //   movesNumber: listCollection[index]["movesNumber"] ?? "?",
        //   setsNumber: listCollection[index]["setsNumber"] ?? "?",
        //   durationInMinutes: listCollection[index]["durationInMinutes"] ?? "?",
        //   rating: listCollection[index]["rating"] ?? "?",
        //   description: listCollection[index]["description"] ?? "?",
        //   reviews: listCollection[index]["reviews"] ?? "?",
        //   comments: listCollection[index]["comments"] ?? "?",
        //   priceInDollars: listCollection[index]["priceInDollars"] ?? "?",
        //   hasFreeTrial: listCollection[index]["hasFreeTrial"] ?? "?",
        // ));
      },
      child: Container(
        margin: const EdgeInsets.only(right: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Container(
                  color: AppColors.darkBlue,
                  width: 130,
                  height: 130,
                  child: TokenImage(
                    imageUrl:
                        'http://128.140.107.116:4400/api/v1/admin/image/${id}',
                  )),
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              title,
              style: TextStyle(
                color: Colors.white.withOpacity(0.75),
                fontSize: 13,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
