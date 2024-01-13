import 'dart:convert';
import 'package:fitnessapp/fitness_app/controllers/Admin/claimRewardController.dart';
import 'package:fitnessapp/fitness_app/models/User/rewardModel.dart';
import 'package:fitnessapp/fitness_app/views/responsive_padding.dart';
import 'package:fitnessapp/theme/colors.dart';
import 'package:fitnessapp/theme/text_style.dart';
import 'package:fitnessapp/routes.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:fitnessapp/fitness_app/services/api_connection.dart';
import 'package:http/http.dart' as http;

class ClaimRewardPage extends StatefulWidget {
  const ClaimRewardPage({Key? key}) : super(key: key);

  @override
  _ClaimRewardPageState createState() => _ClaimRewardPageState();
}

class _ClaimRewardPageState extends State<ClaimRewardPage> {
  final _claimRewardController = Get.put(claimRewardController());

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return ResponsivePadding(
      child: Scaffold(
        backgroundColor: white,
        body: RefreshIndicator(
          child: SafeArea(child: getBody()),
          onRefresh: () {
            return Future.delayed(
              Duration(seconds: 1),
              () {
                //Refresh List
                _claimRewardController.refreshList();
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
                      Text(
                        "Rewards to Give Out",
                        style: TextStylePreset.bigTitle,
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      newTable(),
                      const SizedBox(
                        height: 15,
                      ),
                      Text(
                        "Claimed Rewards",
                        style: TextStylePreset.bigTitle,
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      claimedTable(),
                    ],
                  ))));
    });
  }

  Widget newTable() {
    return Obx(() => ListView.builder(
          shrinkWrap: true,
          primary: false,
          itemCount: _claimRewardController.newRewardList.length,
          scrollDirection: Axis.vertical,
          itemBuilder: (context, index) {
            return Card(
              color: Colors.blue.shade100,
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: ListTile(
                  title: Text(
                    _claimRewardController
                        .getUserDetails(
                            _claimRewardController.newRewardList[index].user_id)
                        .fullName,
                    style: TextStylePreset.bigText,
                  ),
                  subtitle: Text(
                    _claimRewardController
                        .getRewardDetails(_claimRewardController
                            .newRewardList[index].reward_id)
                        .title,
                    style: TextStylePreset.normalText,
                  ),
                  trailing: SizedBox(
                    width: 125,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Text(
                            "${_claimRewardController.newRewardList[index].status}",
                            style: const TextStyle(height: 5, fontSize: 10),
                          ),
                        ),
                        Expanded(
                          child: InkWell(
                            onTap: () {
                              Get.toNamed(Routes.view_claim_reward, arguments: [
                                _claimRewardController.newRewardList[index],
                                _claimRewardController.getUserDetails(
                                    _claimRewardController
                                        .newRewardList[index].user_id),
                                _claimRewardController.getRewardDetails(
                                    _claimRewardController
                                        .newRewardList[index].reward_id)
                              ]);
                            },
                            child: viewButton(),
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

  Widget claimedTable() {
    return Obx(() => ListView.builder(
          shrinkWrap: true,
          primary: false,
          itemCount: _claimRewardController.claimedRewardList.length,
          scrollDirection: Axis.vertical,
          itemBuilder: (context, index) {
            return Card(
              color: Colors.blue.shade100,
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: ListTile(
                  title: Text(
                    _claimRewardController
                        .getUserDetails(_claimRewardController
                            .claimedRewardList[index].user_id)
                        .fullName,
                    style: TextStylePreset.bigText,
                  ),
                  subtitle: Text(
                    _claimRewardController
                        .getRewardDetails(_claimRewardController
                            .claimedRewardList[index].reward_id)
                        .title,
                    style: TextStylePreset.normalText,
                  ),
                  trailing: SizedBox(
                    width: 125,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Text(
                            "${_claimRewardController.claimedRewardList[index].status}",
                            style: const TextStyle(height: 5, fontSize: 10),
                          ),
                        ),
                        Expanded(
                          child: InkWell(
                            onTap: () {
                              Get.toNamed(Routes.view_claim_reward, arguments: [
                                _claimRewardController.claimedRewardList[index],
                                _claimRewardController.getUserDetails(
                                    _claimRewardController
                                        .claimedRewardList[index].user_id),
                                _claimRewardController.getRewardDetails(
                                    _claimRewardController
                                        .claimedRewardList[index].reward_id)
                              ]);
                            },
                            child: viewButton(),
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

  Container viewButton() {
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
            "View",
            style: TextStylePreset.btnSmallText,
          )
        ],
      ),
    );
  }

  // List<DataRow> getRows(List<UserModel> students) =>
  //     students.map((UserModel student) {
  //       final cells = ["#"+, student.fullName, student.rewardPoint];
  //       return DataRow(cells: getCells(cells));
  //     }).toList();
}
