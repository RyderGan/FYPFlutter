import 'dart:async';
import 'dart:convert';
import 'dart:math';
import 'package:fitnessapp/fitness_app/controllers/User/loginController.dart';
import 'package:fitnessapp/fitness_app/models/User/bloodPressureModel.dart';
import 'package:fitnessapp/fitness_app/models/User/bmiModel.dart';
import 'package:fitnessapp/fitness_app/models/User/stepCountModel.dart';
import 'package:fitnessapp/fitness_app/models/User/userModel.dart';
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
  RxInt stepCount = 0.obs;
  RxDouble bmi = 0.0.obs;
  RxInt systolicPressure = 0.obs;
  RxInt diastolicPressure = 0.obs;
  RxInt visceralFat = 0.obs;
  late Stream<StepCount> _stepCountStream;
  CurrentUser _currentUser = Get.put(CurrentUser());

  @override
  void onInit() {
    super.onInit();
    //initStepCount();
    //getUserStepCount();
    getUserBmi();
  }

  @override
  void onClose() {
    //fullNameController.dispose();
  }

  /// Handle step count changed
  void initStepCount() {
    _stepCountStream = Pedometer.stepCountStream;
    _stepCountStream.listen(onStepCount).onError(onStepCountError);
  }

  void onStepCount(StepCount event) {
    print(event);
    stepCount.value = event.steps;
  }

  void onStepCountError(error) {
    print('onStepCountError: $error');
    stepCount.value = -1;
  }

  Future<void> updateUserStepCount() async {
    try {
      var res = await http.post(
        Uri.parse(Api.updateStepCount),
        body: {
          'stepCount': stepCount.value.toString(),
          'userID': _currentUser.user.id.toString(),
        },
      );

      if (res.statusCode == 200) {
        var resBody = jsonDecode(res.body);
        if (resBody['success']) {
          Fluttertoast.showToast(msg: "Step counts updated");
        } else {
          //update user email
          Fluttertoast.showToast(msg: resBody.toString());
        }
      }
    } catch (e) {
      print(e.toString());
      Fluttertoast.showToast(msg: e.toString());
    }
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
          stepCount.value = userInfo.stepCount;
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
}
