import 'dart:convert';
import 'package:fitnessapp/fitness_app/models/Admin/rewardModel.dart';
import 'package:fitnessapp/fitness_app/services/api_connection.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class rewardsListController extends GetxController {
  List<RewardModel> rewardsList = <RewardModel>[].obs;

  @override
  void onInit() {
    super.onInit();
    getPathList();
  }

  void refreshList() {
    rewardsList.clear();
    getPathList();
  }

  @override
  void onClose() {
    rewardsList.clear();
    super.dispose();
  }

  void getPathList() async {
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
          rewardsList.addAll(rewards);
        } else {
          List<RewardModel> rewards = <RewardModel>[];
          rewardsList.addAll(rewards);
        }
      }
    } catch (e) {
      print(e.toString());
      Fluttertoast.showToast(msg: e.toString());
    }
  }
}
