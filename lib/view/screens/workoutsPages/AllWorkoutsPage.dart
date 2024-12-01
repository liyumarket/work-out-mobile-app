import 'package:delayed_display/delayed_display.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:work_out/controller/functionsController.dart';
import 'package:work_out/config/Colors.dart';
import 'package:work_out/config/text.dart';
import '../../../controller/userController/userController.dart';
import '../../../config/workouts lists/workouts Lists.dart';
import '../../../helpers/string_methods.dart';
import '../homepage/componenets/tabBarViewSections.dart';

// ignore: must_be_immutable
class AllWorkoutsPage extends StatelessWidget {
  AllWorkoutsPage({super.key, this.dataList});
  List? dataList;
  final FunctionsController controller = Get.put(FunctionsController());
  final userInformationController = Get.put(UserInformationController());
  @override
  Widget build(BuildContext context) {
    print( Get.arguments);
    return Scaffold(
      backgroundColor: AppColors.darkBlue,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(40),
        child: DelayedDisplay(
          slidingBeginOffset: const Offset(0.0, 0.1),
          delay: Duration(milliseconds: delay),
          child: AppBar(
            actions: [
              // Container(
              //   margin:
              //       const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
              //   child: AspectRatio(
              //     aspectRatio: 1,
              //     child: Avatar(
              //       onProfileImgTap: () {
              //         Get.to(() => const UserProfile());
              //       },
              //       networkImage:
              //           userInformationController.userProfileImg.value,
              //     ),
              //   ),
              // ),
            ],
            elevation: 0,
            iconTheme: const IconThemeData(
              color: Colors.white,
            ),
            backgroundColor: AppColors.darkBlue,
            title: Text(
              Get.arguments[0].toString(),
              style: const TextStyle(
                color: Colors.white,
              ),
            ),
          ),
        ),
      ),
      body: Column(
        children: [
          const SizedBox(
            height: 10,
          ),
          // DelayedDisplay(
          //   delay: Duration(milliseconds: delay + 100),
          //   slidingBeginOffset: const Offset(0.0, 0.1),
          //   child: MainWorkoutCard(
          //     isFavortite: false,
          //     sectionTitle: AppTexts.workoutOfDay,
          //     description: AppTexts.basedOnReviews,
          //     imagePath: controller.filterWorkoutWith(
          //         Get.arguments[1], "isWorkoutOfDay", "true")["imagePath"],
          //     cardTitle: controller.filterWorkoutWith(
          //         Get.arguments[1], "isWorkoutOfDay", "true")["workOutTitle"],
          //     filledStars: controller.filterWorkoutWith(
          //         Get.arguments[1], "isWorkoutOfDay", "true")["rating"],
          //     timeLeft: controller.filterWorkoutWith(Get.arguments[1],
          //         "isWorkoutOfDay", "true")["timeLeftInHour"],
          //     comments: controller.filterWorkoutWith(
          //         Get.arguments[1], "isWorkoutOfDay", "true")["comments"],
          //     durationInMinutes: controller.filterWorkoutWith(
          //         Get.arguments[1],
          //         "isWorkoutOfDay",
          //         "true")["durationInMinutes"],
          //     hasFreeTrial: controller.filterWorkoutWith(
          //         Get.arguments[1], "isWorkoutOfDay", "true")["hasFreeTrial"],
          //     movesNumber: controller.filterWorkoutWith(
          //         Get.arguments[1], "isWorkoutOfDay", "true")["movesNumber"],
          //     priceInDollars: controller.filterWorkoutWith(Get.arguments[1],
          //         "isWorkoutOfDay", "true")["priceInDollars"],
          //     setsNumber: controller.filterWorkoutWith(
          //         Get.arguments[1], "isWorkoutOfDay", "true")["setsNumber"],
          //     reviews: controller.filterWorkoutWith(
          //         Get.arguments[1], "isWorkoutOfDay", "true")["reviews"],
          //   ),
          // ),
          const SizedBox(
            height: 40,
          ),
          // DelayedDisplay(
          //   slidingBeginOffset: const Offset(0.0, 0.1),
          //   delay: Duration(milliseconds: delay + 100),
          //   child: TabBarViewSection(
          //     itemsToShow: WorkoutsList.allWorkoutsList.length,
          //     title: capitalize(
          //       AppTexts.withDiscounts,
          //     ),
          //     dataList: Get.arguments[1],
          //     hasSeeAllButton: false,
          //   ),
          // ),
          // const SizedBox(
          //   height: 40,
          // ),
          // DelayedDisplay(
          //   slidingBeginOffset: const Offset(0.0, 0.1),
          //   delay: Duration(milliseconds: delay + 200),
          //   child: MainWorkoutCard(
          //     isFavortite: false,
          //     sectionTitle: AppTexts.dailyFreeWorkout,
          //     description: AppTexts.choosedCarefully,
          //     imagePath: controller.filterWorkoutWith(
          //         Get.arguments[1], "dailyFreeWorkout", "true")["imagePath"],
          //     cardTitle: controller.filterWorkoutWith(Get.arguments[1],
          //         "dailyFreeWorkout", "true")["workOutTitle"],
          //     filledStars: controller.filterWorkoutWith(
          //         Get.arguments[1], "dailyFreeWorkout", "true")["rating"],
          //     timeLeft: controller.filterWorkoutWith(Get.arguments[1],
          //         "dailyFreeWorkout", "true")["timeLeftInHour"],
          //     comments: controller.filterWorkoutWith(
          //         Get.arguments[1], "dailyFreeWorkout", "true")["comments"],
          //     durationInMinutes: controller.filterWorkoutWith(
          //         Get.arguments[1],
          //         "dailyFreeWorkout",
          //         "true")["durationInMinutes"],
          //     hasFreeTrial: controller.filterWorkoutWith(Get.arguments[1],
          //         "dailyFreeWorkout", "true")["hasFreeTrial"],
          //     movesNumber: controller.filterWorkoutWith(Get.arguments[1],
          //         "dailyFreeWorkout", "true")["movesNumber"],
          //     priceInDollars: controller.filterWorkoutWith(Get.arguments[1],
          //         "dailyFreeWorkout", "true")["priceInDollars"],
          //     setsNumber: controller.filterWorkoutWith(
          //         Get.arguments[1], "dailyFreeWorkout", "true")["setsNumber"],
          //     reviews: controller.filterWorkoutWith(
          //         Get.arguments[1], "dailyFreeWorkout", "true")["reviews"],
          //   ),
          // ),

          const SizedBox(
            height: 5,
          ),
          Expanded(
            child: DelayedDisplay(
              slidingBeginOffset: const Offset(0.0, 0.1),
              delay: Duration(milliseconds: delay + 300),
              child: TabBarViewSection(
                itemsToShow: WorkoutsList.allWorkoutsList.length,
                title: capitalize(
                  AppTexts.allWorkouts,
                ),
                dataList: Get.arguments[1],
                hasSeeAllButton: false,
              ),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
        ],
      ),
    );
  }
}

class AllWorkoutsByCategoryPage extends StatelessWidget {
  AllWorkoutsByCategoryPage({super.key, required this.name});

  final String name;
  final FunctionsController controller = Get.put(FunctionsController());
  final userInformationController = Get.put(UserInformationController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.darkBlue,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(40),
        child: DelayedDisplay(
          slidingBeginOffset: const Offset(0.0, 0.1),
          delay: Duration(milliseconds: delay),
          child: AppBar(
            actions: [],
            elevation: 0,
            iconTheme: const IconThemeData(
              color: Colors.white,
            ),
            backgroundColor: AppColors.darkBlue,
            title: Text(
              Get.arguments[0].toString(),
              style: const TextStyle(
                color: Colors.white,
              ),
            ),
          ),
        ),
      ),
      body: Column(
        children: [
          const SizedBox(
            height: 10,
          ),
          const SizedBox(
            height: 40,
          ),
          const SizedBox(
            height: 5,
          ),
          Expanded(
            child: DelayedDisplay(
              slidingBeginOffset: const Offset(0.0, 0.1),
              delay: Duration(milliseconds: delay + 300),
              child: TabBarViewSection(
                itemsToShow: WorkoutsList.allWorkoutsList.length,
                title: capitalize(
                  AppTexts.allWorkouts,
                ),
                dataList: Get.arguments[1],
                hasSeeAllButton: false,
              ),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
        ],
      ),
    );
  }
}
