import 'dart:async';
import 'dart:convert';
import 'package:fitnessapp/fitness_app/models/User/stepCountModel.dart';
import 'package:fitnessapp/fitness_app/preferences/current_user.dart';
import 'package:fitnessapp/fitness_app/services/api_connection.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class stepCountController extends GetxController {
  final CurrentUser _currentUser = Get.put(CurrentUser());
  int totalStepCount = 0;
  RxInt finalStepCount = 0.obs;
  int totalStepCountsBeforeToday = 0;
  List<StepCountModel> allStepCounts = <StepCountModel>[].obs;
  List<StepCountModel> allPreviousStepCounts = <StepCountModel>[];

  @override
  void onInit() {
    getUserLastStepCount();
    Timer(const Duration(seconds: 2), () {
      getUserStepCount();
    });
    getUserAllStepCounts();
    super.onInit();
  }

  @override
  void onClose() {
    allStepCounts.clear();
    super.dispose();
  }

  void getUserStepCount() async {
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
          totalStepCount = userInfo.stepCount;
          finalStepCount.value = totalStepCount - totalStepCountsBeforeToday;
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
          //Current step counts
          List<StepCountModel> stepCounts = await resBody["allStepCountData"]
              .map<StepCountModel>((json) => StepCountModel.fromJson(json))
              .toList();
          List<StepCountModel> previousStepCounts =
              await resBody["allPreviousStepCounts"]
                  .map<StepCountModel>((json) => StepCountModel.fromJson(json))
                  .toList();
          for (int i = 0; i < previousStepCounts.length; i++) {
            stepCounts[i].stepCount -= previousStepCounts[i].stepCount;
          }
          // adjust all step counts values
          // for (int i = 0; i < allPreviousStepCounts.length; i++) {
          //   stepCounts[i].stepCount -= allPreviousStepCounts[i].stepCount;
          //   print(stepCounts[i].stepCount);
          // }
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
