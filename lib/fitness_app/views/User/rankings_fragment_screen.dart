import 'package:fitnessapp/fitness_app/controllers/User/rankingsController.dart';
import 'package:fitnessapp/fitness_app/views/responsive_padding.dart';
import 'package:fitnessapp/routes.dart';
import 'package:fitnessapp/theme/colors.dart';
import 'package:fitnessapp/theme/text_style.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RankingsFragmentScreen extends StatefulWidget {
  const RankingsFragmentScreen({Key? key}) : super(key: key);

  @override
  _RankingsFragmentScreenState createState() => _RankingsFragmentScreenState();
}

class _RankingsFragmentScreenState extends State<RankingsFragmentScreen> {
  final _rankingsController = Get.put(rankingsController());

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return ResponsivePadding(
      child: Scaffold(
        backgroundColor: white,
        body: SafeArea(child: getBody()),
      ),
    );
  }

  Widget getBody() {
    return LayoutBuilder(builder: (context, constraints) {
      return ConstrainedBox(
          constraints: BoxConstraints(
            minHeight: constraints.maxHeight,
          ),
          child: SingleChildScrollView(
              child: Container(
                  padding: const EdgeInsets.all(20),
                  height: MediaQuery.of(context).size.height,
                  child: Column(
                    children: [
                      displayTopThreeStaffs(),
                      const SizedBox(
                        height: 15,
                      ),
                      displayTopThreeStudents(),
                    ],
                  ))));
    });
  }

  Container displayTopThreeStaffs() {
    return Container(
      alignment: Alignment.topLeft,
      width: double.infinity,
      padding: const EdgeInsets.only(left: 20, top: 10, right: 20, bottom: 10),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey),
        borderRadius: const BorderRadius.all(Radius.circular(5.0)),
      ),
      child: Column(
        children: [
          const Text(
            "Staff Rankings",
            style: TextStylePreset.bigTitle,
          ),
          const SizedBox(
            height: 45,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Image.asset(
                "assets/icons/gold_trophy.png",
                height: 50,
                width: 50,
                fit: BoxFit.contain,
              ),
              const SizedBox(
                width: 15,
              ),
              SizedBox(
                width: 185,
                child: Obx(() {
                  return Text(
                    _rankingsController.firstStaff.value.fullName,
                    style: TextStylePreset.bigText,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                  );
                }),
              ),
              const SizedBox(
                width: 15,
              ),
              Flexible(
                  child: SizedBox(
                width: 45,
                child: Obx(() {
                  return Text(
                    _rankingsController.firstStaff.value.rewardPoint.toString(),
                    style: TextStylePreset.bigText,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                  );
                }),
              )),
            ],
          ),
          const SizedBox(
            height: 15,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Image.asset(
                "assets/icons/silver_trophy.png",
                height: 50,
                width: 50,
                fit: BoxFit.contain,
              ),
              const SizedBox(
                width: 15,
              ),
              SizedBox(
                width: 185,
                child: Obx(() {
                  return Text(
                    _rankingsController.secondStaff.value.fullName,
                    style: TextStylePreset.bigText,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                  );
                }),
              ),
              const SizedBox(
                width: 15,
              ),
              Flexible(
                  child: SizedBox(
                width: 45,
                child: Obx(() {
                  return Text(
                    _rankingsController.secondStaff.value.rewardPoint
                        .toString(),
                    style: TextStylePreset.bigText,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                  );
                }),
              )),
            ],
          ),
          const SizedBox(
            height: 15,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Image.asset(
                "assets/icons/silver_trophy.png",
                height: 50,
                width: 50,
                fit: BoxFit.contain,
              ),
              const SizedBox(
                width: 15,
              ),
              SizedBox(
                width: 185,
                child: Obx(() {
                  return Text(
                    _rankingsController.thirdStaff.value.fullName,
                    style: TextStylePreset.bigText,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                  );
                }),
              ),
              const SizedBox(
                width: 15,
              ),
              Flexible(
                  child: SizedBox(
                width: 45,
                child: Obx(() {
                  return Text(
                    _rankingsController.thirdStaff.value.rewardPoint.toString(),
                    style: TextStylePreset.bigText,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                  );
                }),
              )),
            ],
          ),
          const SizedBox(
            height: 15,
          ),
          seeAllStaffsButton(),
        ],
      ),
    );
  }

  MaterialButton seeAllStaffsButton() {
    return MaterialButton(
      minWidth: double.infinity,
      height: 50,
      color: primary,
      child: const Text('See all staffs',
          style: TextStyle(fontSize: 20, color: Colors.white)),
      onPressed: () {
        Get.toNamed(Routes.staff_ranking_page);
      },
    );
  }

  Container displayTopThreeStudents() {
    return Container(
      alignment: Alignment.topLeft,
      width: double.infinity,
      padding: const EdgeInsets.only(left: 20, top: 10, right: 20, bottom: 10),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey),
        borderRadius: const BorderRadius.all(Radius.circular(5.0)),
      ),
      child: Column(
        children: [
          const Text(
            "Student Rankings",
            style: TextStylePreset.bigTitle,
          ),
          const SizedBox(
            height: 30,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Image.asset(
                "assets/icons/gold_trophy.png",
                height: 50,
                width: 50,
                fit: BoxFit.contain,
              ),
              const SizedBox(
                width: 15,
              ),
              SizedBox(
                width: 185,
                child: Obx(() {
                  return Text(
                    _rankingsController.firstStudent.value.fullName,
                    style: TextStylePreset.bigText,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                  );
                }),
              ),
              const SizedBox(
                width: 15,
              ),
              Flexible(
                  child: SizedBox(
                width: 45,
                child: Obx(() {
                  return Text(
                    _rankingsController.firstStudent.value.rewardPoint
                        .toString(),
                    style: TextStylePreset.bigText,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                  );
                }),
              )),
            ],
          ),
          const SizedBox(
            height: 15,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Image.asset(
                "assets/icons/silver_trophy.png",
                height: 50,
                width: 50,
                fit: BoxFit.contain,
              ),
              const SizedBox(
                width: 15,
              ),
              SizedBox(
                width: 185,
                child: Obx(() {
                  return Text(
                    _rankingsController.secondStudent.value.fullName,
                    style: TextStylePreset.bigText,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                  );
                }),
              ),
              const SizedBox(
                width: 15,
              ),
              Flexible(
                  child: SizedBox(
                width: 45,
                child: Obx(() {
                  return Text(
                    _rankingsController.secondStudent.value.rewardPoint
                        .toString(),
                    style: TextStylePreset.bigText,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                  );
                }),
              )),
            ],
          ),
          const SizedBox(
            height: 15,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Image.asset(
                "assets/icons/bronze_trophy.png",
                height: 50,
                width: 50,
                fit: BoxFit.contain,
              ),
              const SizedBox(
                width: 15,
              ),
              SizedBox(
                width: 185,
                child: Obx(() {
                  return Text(
                    _rankingsController.thirdStudent.value.fullName,
                    style: TextStylePreset.bigText,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                  );
                }),
              ),
              const SizedBox(
                width: 15,
              ),
              Flexible(
                  child: SizedBox(
                width: 45,
                child: Obx(() {
                  return Text(
                    _rankingsController.thirdStudent.value.rewardPoint
                        .toString(),
                    style: TextStylePreset.bigText,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                  );
                }),
              )),
            ],
          ),
          const SizedBox(
            height: 15,
          ),
          seeAllStudentsButton(),
        ],
      ),
    );
  }

  MaterialButton seeAllStudentsButton() {
    return MaterialButton(
      minWidth: double.infinity,
      height: 50,
      color: secondary,
      child: const Text('See all students',
          style: TextStyle(fontSize: 20, color: Colors.white)),
      onPressed: () {
        Get.toNamed(Routes.student_ranking_page);
      },
    );
  }
}
