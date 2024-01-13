import 'dart:convert';
import 'package:fitnessapp/fitness_app/models/Admin/claimRewardModel.dart';
import 'package:fitnessapp/fitness_app/models/Admin/rewardModel.dart';
import 'package:fitnessapp/fitness_app/models/Admin/userModel.dart';
import 'package:fitnessapp/fitness_app/services/api_connection.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class claimRewardController extends GetxController {
  List<UserModel> userList = <UserModel>[].obs;
  List<ClaimRewardModel> unclaimedRewardList = <ClaimRewardModel>[].obs;
  List<ClaimRewardModel> claimedRewardList = <ClaimRewardModel>[].obs;
  List<RewardModel> rewardList = <RewardModel>[].obs;
  @override
  void onInit() {
    super.onInit();
    getClaimReward();
    getAllRewards();
    getUserList();
  }

  @override
  void onClose() {
    unclaimedRewardList.clear();
    claimedRewardList.clear();
    rewardList.clear();
    userList.clear;
    super.dispose();
  }

  RewardModel getRewardDetails(int rewardID) {
    RewardModel rewardFound = new RewardModel(0, '', '', 0, '');
    for (RewardModel reward in rewardList) {
      if (reward.id == rewardID) {
        rewardFound = reward;
      }
    }
    return rewardFound;
  }

  UserModel getUserDetails(int userID) {
    UserModel userFound = new UserModel(0, '', '', '', '', '', '', 0, '');
    for (UserModel user in userList) {
      if (user.id == userID) {
        userFound = user;
      }
    }
    return userFound;
  }

  void getClaimReward() async {
    try {
      var res = await http.get(
        Uri.parse(Api.getClaimRewardList),
      );

      if (res.statusCode == 200) {
        var resBodyOfLogin = jsonDecode(res.body);
        if (resBodyOfLogin['success']) {
          List<ClaimRewardModel> claimRewards =
              await resBodyOfLogin["claimRewardList"]
                  .map<ClaimRewardModel>(
                      (json) => ClaimRewardModel.fromJson(json))
                  .toList();
          for (ClaimRewardModel claimReward in claimRewards) {
            if (claimReward.status == "unclaimed") {
              unclaimedRewardList.add(claimReward);
            } else if (claimReward.status == "claimed") {
              claimedRewardList.add(claimReward);
            }
          }
        } else {
          List<ClaimRewardModel> claimRewards = <ClaimRewardModel>[];
          unclaimedRewardList.addAll(claimRewards);
          claimedRewardList.addAll(claimRewards);
        }
      }
    } catch (e) {
      print(e.toString());
      Fluttertoast.showToast(msg: e.toString());
    }
  }

  void getAllRewards() async {
    try {
      var res = await http.get(
        Uri.parse(Api.getRewardList),
      );

      if (res.statusCode == 200) {
        var resBodyOfLogin = jsonDecode(res.body);
        if (resBodyOfLogin['success']) {
          List<RewardModel> rewards = await resBodyOfLogin["rewardList"]
              .map<RewardModel>((json) => RewardModel.fromJson(json))
              .toList();
          rewardList.addAll(rewards);
        } else {
          List<RewardModel> rewards = <RewardModel>[];
          rewardList.addAll(rewards);
        }
      }
    } catch (e) {
      print(e.toString());
      Fluttertoast.showToast(msg: e.toString());
    }
  }

  void getUserList() async {
    try {
      var res = await http.get(
        Uri.parse(Api.getUserList),
      );

      if (res.statusCode == 200) {
        var resBodyOfLogin = jsonDecode(res.body);
        if (resBodyOfLogin['success']) {
          List<UserModel> users = await resBodyOfLogin["userList"]
              .map<UserModel>((json) => UserModel.fromJson(json))
              .toList();
          userList.addAll(users);
        } else {
          List<UserModel> users = <UserModel>[];
          userList.addAll(users);
        }
      }
    } catch (e) {
      print(e.toString());
      Fluttertoast.showToast(msg: e.toString());
    }
  }
}
