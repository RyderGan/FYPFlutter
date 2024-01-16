import 'dart:async';
import 'dart:convert';
import 'package:fitnessapp/fitness_app/models/Admin/checkpointModel.dart';
import 'package:fitnessapp/fitness_app/models/Admin/pathModel.dart';
import 'package:fitnessapp/fitness_app/models/Admin/rfidBandModel.dart';
import 'package:fitnessapp/fitness_app/models/Admin/userModel.dart';
import 'package:fitnessapp/fitness_app/models/Admin/feedbackModel.dart';
import 'package:fitnessapp/fitness_app/models/Admin/rewardModel.dart';
import 'package:fitnessapp/fitness_app/services/api_connection.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class AdminHomeController extends GetxController {
  RxInt userCount = 0.obs;
  RxInt rfidBandCount = 0.obs;
  RxInt feedbackCount = 0.obs;
  RxInt checkpointCount = 0.obs;
  RxInt pathCount = 0.obs;
  RxInt rewardCount = 0.obs;
  //rankingsController _rankingController = Get.put(rankingsController());
  Timer? timer;
  DateTime savedTimestamp = DateTime.now();

  @override
  void onInit() {
    super.onInit();
    getUserCount();
    getRfidBandCount();
    getFeedbackCount();
    getCheckpointCount();
    getPathCount();
    getRewardCount();
  }

  void refreshList() {
    userCount = 0.obs;
    rfidBandCount = 0.obs;
    feedbackCount = 0.obs;
    checkpointCount = 0.obs;
    pathCount = 0.obs;
    rewardCount = 0.obs;
    getUserCount();
    getRfidBandCount();
    getFeedbackCount();
    getCheckpointCount();
    getPathCount();
    getRewardCount();
  }

  @override
  void onClose() {
    timer?.cancel();
    super.dispose();
  }

  void getUserCount() async {
    try {
      var res = await http.post(Uri.parse(Api.getUserList));

      var resBodyOfLogin = jsonDecode(res.body);
      if (resBodyOfLogin['success']) {
        List<UserModel> students = await resBodyOfLogin["userList"]
            .map<UserModel>((json) => UserModel.fromJson(json))
            .toList();
        userCount.value = students.length;
      } else {
        List<UserModel> students = <UserModel>[];
        userCount.value = students.length;
      }
    } catch (e) {
      print(e.toString());
      Fluttertoast.showToast(msg: e.toString());
    }
  }

  void getRfidBandCount() async {
    try {
      var res = await http.post(Uri.parse(Api.getRfidBandList));

      var resBodyOfLogin = jsonDecode(res.body);
      if (resBodyOfLogin['success']) {
        List<RfidBandModel> rfidBands = await resBodyOfLogin["rfidBandList"]
            .map<RfidBandModel>((json) => RfidBandModel.fromJson(json))
            .toList();
        rfidBandCount.value = rfidBands.length;
      } else {
        List<RfidBandModel> rfidBands = <RfidBandModel>[];
        rfidBandCount.value = rfidBands.length;
      }
    } catch (e) {
      print(e.toString());
      Fluttertoast.showToast(msg: e.toString());
    }
  }

  void getFeedbackCount() async {
    try {
      var res = await http.post(Uri.parse(Api.getFeedbackList));
      var resBodyOfLogin = jsonDecode(res.body);
      if (resBodyOfLogin['success']) {
        List<FeedbackModel> feedback = await resBodyOfLogin["feedbackList"]
            .map<FeedbackModel>((json) => FeedbackModel.fromJson(json))
            .toList();
        feedbackCount.value = feedback.length;
      } else {
        List<FeedbackModel> feedback = <FeedbackModel>[];
        feedbackCount.value = feedback.length;
      }
    } catch (e) {
      print(e.toString());
      Fluttertoast.showToast(msg: e.toString());
    }
  }

  void getCheckpointCount() async {
    try {
      var res = await http.post(Uri.parse(Api.getCheckpointList));

      var resBodyOfLogin = jsonDecode(res.body);
      if (resBodyOfLogin['success']) {
        List<CheckpointModel> checkpoints =
            await resBodyOfLogin["checkpointList"]
                .map<CheckpointModel>((json) => CheckpointModel.fromJson(json))
                .toList();
        checkpointCount.value = checkpoints.length;
      } else {
        List<CheckpointModel> checkpoints = <CheckpointModel>[];
        checkpointCount.value = checkpoints.length;
      }
    } catch (e) {
      print(e.toString());
      Fluttertoast.showToast(msg: e.toString());
    }
  }

  void getPathCount() async {
    try {
      var res = await http.post(Uri.parse(Api.getPathList));

      var resBodyOfLogin = jsonDecode(res.body);
      if (resBodyOfLogin['success']) {
        List<PathModel> paths = await resBodyOfLogin["pathList"]
            .map<PathModel>((json) => PathModel.fromJson(json))
            .toList();
        pathCount.value = paths.length;
      } else {
        List<PathModel> paths = <PathModel>[];
        pathCount.value = paths.length;
      }
    } catch (e) {
      print(e.toString());
      Fluttertoast.showToast(msg: e.toString());
    }
  }

  void getRewardCount() async {
    try {
      var res = await http.post(Uri.parse(Api.getRewardList));

      var resBodyOfLogin = jsonDecode(res.body);
      if (resBodyOfLogin['success']) {
        List<RewardModel> rewards = await resBodyOfLogin["rewardList"]
            .map<RewardModel>((json) => RewardModel.fromJson(json))
            .toList();
        rewardCount.value = rewards.length;
      } else {
        List<RewardModel> rewards = <RewardModel>[];
        rewardCount.value = rewards.length;
      }
    } catch (e) {
      print(e.toString());
      Fluttertoast.showToast(msg: e.toString());
    }
  }
}
