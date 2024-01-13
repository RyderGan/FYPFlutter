import 'dart:convert';
import 'package:fitnessapp/fitness_app/models/User/rewardModel.dart';
import 'package:fitnessapp/fitness_app/models/User/userModel.dart';
import 'package:fitnessapp/fitness_app/preferences/current_user.dart';
import 'package:fitnessapp/fitness_app/services/api_connection.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class rewardsController extends GetxController {
  final CurrentUser _currentUser = Get.put(CurrentUser());
  List<RewardModel> allRewards = <RewardModel>[].obs;
  RxInt currentUserPoints = 0.obs;

  @override
  void onInit() {
    super.onInit();
    getAllRewards();
    getCurrentUserPoints();
  }

  @override
  void onClose() {
    super.dispose();
  }

  void refreshList() {
    getCurrentUserPoints();
  }

  void getAllRewards() async {
    try {
      var res = await http.get(
        Uri.parse(Api.getAllRewards),
      );

      if (res.statusCode == 200) {
        var resBodyOfLogin = jsonDecode(res.body);
        if (resBodyOfLogin['success']) {
          List<RewardModel> rewards = await resBodyOfLogin["allRewardData"]
              .map<RewardModel>((json) => RewardModel.fromJson(json))
              .toList();
          allRewards.addAll(rewards);
        } else {
          List<RewardModel> bmis = <RewardModel>[];
          allRewards.addAll(bmis);
        }
      }
    } catch (e) {
      print(e.toString());
      Fluttertoast.showToast(msg: e.toString());
    }
  }

  void claimReward(int rewardID, int rewardPoints) async {
    var resultResponse = await Get.dialog(
      AlertDialog(
        backgroundColor: Colors.grey,
        title: const Text(
          "Claim Reward",
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        content: const Text(
          "Are you sure?\nThis cannot be undone.",
        ),
        actions: [
          TextButton(
            onPressed: () {
              Get.back(result: "claimed");
            },
            child: const Text(
              "Yes",
              style: TextStyle(
                color: Colors.black,
              ),
            ),
          ),
          TextButton(
            onPressed: () {
              Get.back();
            },
            child: const Text(
              "No",
              style: TextStyle(
                color: Colors.black,
              ),
            ),
          ),
        ],
      ),
    );

    if (resultResponse == 'claimed') {
      if (checkUserPointIsSufficient(rewardPoints)) {
        //Claim Reward
        try {
          var res = await http.post(
            Uri.parse(Api.claimReward),
            body: {
              'userID': _currentUser.user.id.toString(),
              'rewardID': rewardID.toString(),
              'rewardPoints': rewardPoints.toString(),
            },
          );

          if (res.statusCode == 200) {
            var resBody = jsonDecode(res.body);
            if (resBody['success']) {
              //update user points
              //Add to Claim Reward
              try {
                var res = await http.post(
                  Uri.parse(Api.addClaimReward),
                  body: {
                    'userID': _currentUser.user.id.toString(),
                    'rewardID': rewardID.toString(),
                  },
                );

                if (res.statusCode == 200) {
                  var resBody = jsonDecode(res.body);
                  if (resBody['success']) {
                    //update user points
                    getCurrentUserPoints();
                    Fluttertoast.showToast(msg: "Reward claimed successfully");
                  } else {
                    Fluttertoast.showToast(msg: resBody.toString());
                  }
                }
              } catch (e) {
                print(e.toString());
                Fluttertoast.showToast(msg: e.toString());
              }
            } else {
              Fluttertoast.showToast(msg: resBody.toString());
            }
          }
        } catch (e) {
          print(e.toString());
          Fluttertoast.showToast(msg: e.toString());
        }
      } else {
        Fluttertoast.showToast(msg: "Insufficient user points.");
      }
    }
  }

  void getCurrentUserPoints() async {
    try {
      var res = await http.post(
        Uri.parse(Api.getUserDetails),
        body: {
          'userID': _currentUser.user.id.toString(),
        },
      );

      if (res.statusCode == 200) {
        var resBody = jsonDecode(res.body);
        if (resBody['success']) {
          UserModel userInfo = UserModel.fromJson(resBody["userData"]);
          currentUserPoints.value = userInfo.rewardPoint;
        } else {
          Fluttertoast.showToast(msg: resBody.toString());
        }
      }
    } catch (e) {
      print(e.toString());
      Fluttertoast.showToast(msg: e.toString());
    }
  }

  bool checkUserPointIsSufficient(int rewardPoints) {
    if (currentUserPoints >= rewardPoints) {
      return true;
    } else {
      return false;
    }
  }
}
