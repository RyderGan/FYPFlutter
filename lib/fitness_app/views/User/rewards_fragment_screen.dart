import 'package:fitnessapp/fitness_app/controllers/User/rewardsController.dart';
import 'package:fitnessapp/fitness_app/preferences/current_user.dart';
import 'package:fitnessapp/fitness_app/views/responsive_padding.dart';
import 'package:fitnessapp/theme/colors.dart';
import 'package:fitnessapp/theme/text_style.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RewardsFragmentScreen extends StatefulWidget {
  const RewardsFragmentScreen({Key? key}) : super(key: key);

  @override
  _RewardsFragmentScreenState createState() => _RewardsFragmentScreenState();
}

class _RewardsFragmentScreenState extends State<RewardsFragmentScreen> {
  final _rewardController = Get.put(rewardsController());
  CurrentUser _currentUser = Get.put(CurrentUser());

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
                displayUserPoint(),
                SizedBox(
                  height: 30,
                ),
                Text(
                  "Rewards",
                  style: TextStylePreset.bigTitle,
                ),
                SizedBox(
                  height: 15,
                ),
                displayAllRewards(),
              ],
            ),
          )));
    });
  }

  Container displayUserPoint() {
    return Container(
      alignment: Alignment.center,
      width: double.infinity,
      padding: EdgeInsets.only(left: 20, top: 10, right: 20, bottom: 10),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.all(Radius.circular(5.0)),
      ),
      child: Column(
        children: [
          Text(
            "User Points",
            style: TextStylePreset.bigTitle,
          ),
          SizedBox(
            height: 15,
          ),
          Obx(() {
            return Text(
              _rewardController.currentUserPoints.toString(),
              style: TextStylePreset.bigText,
            );
          }),
          SizedBox(
            height: 15,
          ),
        ],
      ),
    );
  }

  Obx displayAllRewards() {
    return Obx(() => ListView.builder(
          shrinkWrap: true,
          primary: false,
          itemCount: _rewardController.allRewards.length,
          scrollDirection: Axis.vertical,
          itemBuilder: (context, index) {
            return Card(
              color: primary,
              child: Padding(
                padding: EdgeInsets.all(10),
                child: ListTile(
                  title: Text(
                    _rewardController.allRewards[index].title,
                    style: TextStylePreset.bigText,
                  ),
                  subtitle: Text(
                    _rewardController.allRewards[index].description,
                    style: TextStylePreset.normalText,
                  ),
                  trailing: Container(
                    width: 125,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Text(
                            _rewardController.allRewards[index].required_pt
                                    .toString() +
                                "pt",
                            style: TextStylePreset.normalText,
                          ),
                        ),
                        Expanded(
                          child: InkWell(
                            onTap: () {
                              _rewardController.claimReward(
                                  _rewardController.allRewards[index].reward_id,
                                  _rewardController
                                      .allRewards[index].required_pt);
                            },
                            child: claimButton(),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        ));
  }

  Container claimButton() {
    return Container(
      height: 40,
      width: 50,
      decoration: BoxDecoration(
          gradient: LinearGradient(colors: [fourthColor, thirdColor]),
          borderRadius: BorderRadius.circular(30)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "Claim",
            style: TextStylePreset.btnSmallText,
          )
        ],
      ),
    );
  }
}
