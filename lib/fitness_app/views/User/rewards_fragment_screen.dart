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
  final CurrentUser _currentUser = Get.put(CurrentUser());

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return ResponsivePadding(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: RefreshIndicator(
          child: SafeArea(child: getBody()),
          onRefresh: () {
            return Future.delayed(
              Duration(seconds: 1),
              () {
                //Refresh List
                _rewardController.refreshList();
              },
            );
          },
        ),
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
                SizedBox(
                  height: 15,
                ),
                displayUserPoint(),
                const SizedBox(
                  height: 30,
                ),
                const Text(
                  "Rewards",
                  style: TextStylePreset.bigTitle,
                ),
                const SizedBox(
                  height: 15,
                ),
                displayAllRewards(),
              ],
            ),
          )));
    });
  }

  MaterialButton refreshButton() {
    return MaterialButton(
      minWidth: double.infinity,
      height: 50,
      color: secondary,
      child: new Text('Refresh',
          style: new TextStyle(fontSize: 20, color: Colors.white)),
      onPressed: () {
        _rewardController.refreshList();
      },
    );
  }

  Container displayUserPoint() {
    return Container(
      alignment: Alignment.center,
      width: double.infinity,
      padding: const EdgeInsets.only(left: 20, top: 10, right: 20, bottom: 10),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey),
        borderRadius: const BorderRadius.all(Radius.circular(5.0)),
      ),
      child: Column(
        children: [
          const Text(
            "User Points",
            style: TextStylePreset.bigTitle,
          ),
          const SizedBox(
            height: 15,
          ),
          Obx(() {
            return Text(
              _rewardController.currentUserPoints.toString(),
              style: TextStylePreset.bigText,
            );
          }),
          const SizedBox(
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
                padding: const EdgeInsets.all(10),
                child: ListTile(
                  title: Text(
                    _rewardController.allRewards[index].title,
                    style: TextStylePreset.bigText,
                  ),
                  subtitle: Text(
                    _rewardController.allRewards[index].description,
                    style: TextStylePreset.normalText,
                  ),
                  trailing: SizedBox(
                    width: 125,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Text(
                            "${_rewardController.allRewards[index].required_pt}pt",
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
          gradient: const LinearGradient(colors: [fourthColor, thirdColor]),
          borderRadius: BorderRadius.circular(30)),
      child: const Row(
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
