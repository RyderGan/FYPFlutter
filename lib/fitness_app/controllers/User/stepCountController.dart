import 'dart:convert';
import 'package:fitnessapp/fitness_app/models/User/stepCountModel.dart';
import 'package:fitnessapp/fitness_app/preferences/current_user.dart';
import 'package:fitnessapp/fitness_app/services/api_connection.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class stepCountController extends GetxController {
  CurrentUser _currentUser = Get.put(CurrentUser());
  int stepCount = 0;
  RxInt totalStepCounts = 0.obs;
  int totalStepCountsBeforeToday = 0;
  List<StepCountModel> allStepCounts = <StepCountModel>[].obs;

  @override
  void onInit() {
    super.onInit();
    getUserStepCount();
    getUserAllStepCounts();
  }

  @override
  void onClose() {
    allStepCounts.clear();
    super.dispose();
  }

  void getUserStepCount() async {
    getUserLastStepCount();
    try {
      var res = await http.post(
        Uri.parse(Api.getUserStepCount),
        body: {
          'userID': _currentUser.user.id.toString(),
        },
      );

      if (res.statusCode == 200) {
        var resBody = jsonDecode(res.body);
        if (resBody['success']) {
          StepCountModel userInfo =
              StepCountModel.fromJson(resBody["stepCountData"]);
          stepCount = userInfo.stepCount;
          totalStepCounts.value = stepCount - totalStepCountsBeforeToday;
        } else {
          Fluttertoast.showToast(msg: resBody.toString());
        }
      }
    } catch (e) {
      print(e.toString());
      Fluttertoast.showToast(msg: e.toString());
    }
  }

  void getUserLastStepCount() async {
    try {
      var res = await http.post(
        Uri.parse(Api.getUserLastStepCount),
        body: {
          'userID': _currentUser.user.id.toString(),
        },
      );

      if (res.statusCode == 200) {
        var resBody = jsonDecode(res.body);
        if (resBody['success']) {
          String totalStepCounts = await resBody["LastStepCount"];
          totalStepCountsBeforeToday = int.parse(totalStepCounts);
        } else {
          Fluttertoast.showToast(msg: resBody.toString());
        }
      }
    } catch (e) {
      print(e.toString());
      Fluttertoast.showToast(msg: e.toString());
    }
  }

  void getUserAllStepCounts() async {
    try {
      var res = await http.post(
        Uri.parse(Api.getUserAllStepCounts),
        body: {
          'userID': _currentUser.user.id.toString(),
        },
      );

      if (res.statusCode == 200) {
        var resBody = jsonDecode(res.body);
        if (resBody['success']) {
          List<StepCountModel> stepCounts = await resBody["allStepCountData"]
              .map<StepCountModel>((json) => StepCountModel.fromJson(json))
              .toList();
          allStepCounts.addAll(stepCounts);
        } else {
          List<StepCountModel> stepCounts = <StepCountModel>[];
          allStepCounts.addAll(stepCounts);
        }
      }
    } catch (e) {
      print(e.toString());
      Fluttertoast.showToast(msg: e.toString());
    }
  }
}
