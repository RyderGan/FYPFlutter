import 'dart:async';
import 'dart:convert';
import 'dart:math';
//import 'package:fitnessapp/fitness_app/controllers/User/rankingsController.dart';
import 'package:fitnessapp/fitness_app/models/User/bloodPressureModel.dart';
import 'package:fitnessapp/fitness_app/models/User/bmiModel.dart';
import 'package:fitnessapp/fitness_app/models/User/stepCountModel.dart';
import 'package:fitnessapp/fitness_app/models/User/visceralFatModel.dart';
import 'package:fitnessapp/fitness_app/preferences/current_user.dart';
import 'package:fitnessapp/fitness_app/services/api_connection.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:pedometer/pedometer.dart';

class homeController extends GetxController {
  //GlobalKey<FormState> changeUserInfoFormKey = GlobalKey<FormState>();

  //late TextEditingController fullNameController,
  RxInt userID = 0.obs;
  int stepCount = 0;
  int lastStepCounts = 0;
  RxInt totalStepCount = 0.obs;
  RxDouble bmi = 0.0.obs;
  RxInt systolicPressure = 0.obs;
  RxInt diastolicPressure = 0.obs;
  RxInt visceralFat = 0.obs;
  late Stream<StepCount> _stepCountStream;
  CurrentUser _currentUser = Get.put(CurrentUser());
  //rankingsController _rankingController = Get.put(rankingsController());
  Timer? timer;
  DateTime savedTimestamp = new DateTime.now();

  @override
  void onInit() {
    super.onInit();
    initStepCount();
    getUserStepCount();
    getUserBmi();
    getUserBloodPressure();
    getUserVisceralFat();
    //update step count every x seconds
    timer = Timer.periodic(
        Duration(seconds: 10), (Timer t) => updateUserStepCount(stepCount));
  }

  @override
  void onClose() {
    timer?.cancel();
    super.dispose();
  }

  /// Handle step count changed
  Future<void> initStepCount() async {
    _stepCountStream = await Pedometer.stepCountStream;
    _stepCountStream.listen(onStepCount).onError(onStepCountError);
  }

  void onStepCount(StepCount event) {
    stepCount = event.steps;
  }

  void onStepCountError(error) {
    print('onStepCountError: $error');
    stepCount = -1;
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
          lastStepCounts = int.parse(totalStepCounts);
        } else {
          Fluttertoast.showToast(msg: resBody.toString());
        }
      }
    } catch (e) {
      print(e.toString());
      Fluttertoast.showToast(msg: e.toString());
    }
  }

  Future<void> updateUserStepCount(int stepCount) async {
    try {
      var res = await http.post(
        Uri.parse(Api.updateStepCount),
        body: {
          'stepCount': stepCount.toString(),
          'userID': _currentUser.user.id.toString(),
        },
      );

      if (res.statusCode == 200) {
        var resBody = jsonDecode(res.body);
        if (resBody['success']) {
          getUserStepCount();
          Fluttertoast.showToast(msg: "Step counts updated");
        } else {
          Fluttertoast.showToast(msg: resBody.toString());
        }
      }
    } catch (e) {
      print(e.toString());
      Fluttertoast.showToast(msg: e.toString());
    }
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
          totalStepCount.value = stepCount - lastStepCounts;
        } else {
          Fluttertoast.showToast(msg: resBody.toString());
        }
      }
    } catch (e) {
      print(e.toString());
      Fluttertoast.showToast(msg: e.toString());
    }
  }

  void getUserBmi() async {
    try {
      var res = await http.post(
        Uri.parse(Api.getUserBmi),
        body: {
          'user_id': _currentUser.user.id.toString(),
        },
      );

      if (res.statusCode == 200) {
        var resBody = jsonDecode(res.body);
        if (resBody['success']) {
          BmiModel bmiInfo = BmiModel.fromJson(resBody['bmiData']);
          double weight = bmiInfo.weight.toDouble();
          double height = bmiInfo.height.toDouble();
          bmi.value = weight / pow(height / 100, 2);
        } else {
          Fluttertoast.showToast(msg: resBody.toString());
        }
      }
    } catch (e) {
      print(e.toString());
      Fluttertoast.showToast(msg: e.toString());
    }
  }

  void getUserBloodPressure() async {
    try {
      var res = await http.post(
        Uri.parse(Api.getUserBloodPressure),
        body: {
          'userID': _currentUser.user.id.toString(),
        },
      );

      if (res.statusCode == 200) {
        var resBody = jsonDecode(res.body);
        if (resBody['success']) {
          BloodPressureModel bloodPressureInfo =
              BloodPressureModel.fromJson(resBody['bloodPressureData']);
          systolicPressure.value = bloodPressureInfo.systolic;
          diastolicPressure.value = bloodPressureInfo.diastolic;
        } else {
          Fluttertoast.showToast(msg: resBody.toString());
        }
      }
    } catch (e) {
      print(e.toString());
      Fluttertoast.showToast(msg: e.toString());
    }
  }

  void getUserVisceralFat() async {
    try {
      var res = await http.post(
        Uri.parse(Api.getUserVisceralFat),
        body: {
          'user_id': _currentUser.user.id.toString(),
        },
      );

      if (res.statusCode == 200) {
        var resBody = jsonDecode(res.body);
        if (resBody['success']) {
          VisceralFatModel visceralFatInfo =
              VisceralFatModel.fromJson(resBody['visceralFatData']);
          visceralFat.value = visceralFatInfo.rating;
        } else {
          Fluttertoast.showToast(msg: resBody.toString());
        }
      }
    } catch (e) {
      print(e.toString());
      Fluttertoast.showToast(msg: e.toString());
    }
  }
}
