import 'dart:convert';

import 'package:fitnessapp/fitness_app/models/User/bloodPressureModel.dart';
import 'package:fitnessapp/fitness_app/preferences/current_user.dart';
import 'package:fitnessapp/fitness_app/services/api_connection.dart';
import 'package:fitnessapp/routes.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class bloodPressureController extends GetxController {
  GlobalKey<FormState> addNewBloodPressureFormKey = GlobalKey<FormState>();
  GlobalKey<FormState> editBloodPressureFormKey = GlobalKey<FormState>();

  late TextEditingController systolicController,
      diastolicController,
      updateSystolicController,
      updateDiastolicController;
  //Map<String, TextEditingController> bmiEditingControllers = {};

  CurrentUser _currentUser = Get.put(CurrentUser());
  List<BloodPressureModel> allBloodPressures = <BloodPressureModel>[].obs;

  @override
  void onInit() {
    super.onInit();
    getUserAllBloodPressure();
    systolicController = TextEditingController();
    diastolicController = TextEditingController();
    updateSystolicController = TextEditingController();
    updateDiastolicController = TextEditingController();
    //initialize dynamic Controllers
    // for (var i = 0; i < allBmis.length - 1; i++) {
    //   var textEditingController = new TextEditingController();
    //   bmiEditingControllers.putIfAbsent(
    //       allBmis[i].bmiID.toString(), () => textEditingController);
    // }
  }

  @override
  void onClose() {
    systolicController.dispose();
    diastolicController.dispose();
    updateSystolicController.dispose();
    updateDiastolicController.dispose();
  }

  void clearFormContents() {
    systolicController.clear();
    diastolicController.clear();
    updateSystolicController.clear();
    updateDiastolicController.clear();
  }

  void addNewBloodPressure() async {
    final isValid = addNewBloodPressureFormKey.currentState!.validate();
    if (!isValid) {
      return;
    } else {
      try {
        var res = await http.post(
          Uri.parse(Api.addNewBloodPressure),
          body: {
            'userID': _currentUser.user.id.toString(),
            'systolic': systolicController.text.trim().toString(),
            'diastolic': diastolicController.text.trim().toString(),
          },
        );

        if (res.statusCode == 200) {
          var resBody = jsonDecode(res.body);
          if (resBody['success']) {
            Fluttertoast.showToast(msg: "One Blood pressure added.");
            //refresh page
            clearFormContents();
            allBloodPressures.clear();
            getUserAllBloodPressure();
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

  void getUserAllBloodPressure() async {
    try {
      var res = await http.post(
        Uri.parse(Api.getUserAllBloodPressure),
        body: {
          'userID': _currentUser.user.id.toString(),
        },
      );

      if (res.statusCode == 200) {
        var resBody = jsonDecode(res.body);
        if (resBody['success']) {
          List<BloodPressureModel> bmis = await resBody["allBloodPressureData"]
              .map<BloodPressureModel>(
                  (json) => BloodPressureModel.fromJson(json))
              .toList();
          allBloodPressures.addAll(bmis);
        } else {
          List<BloodPressureModel> bmis = <BloodPressureModel>[];
          allBloodPressures.addAll(bmis);
        }
      }
    } catch (e) {
      print(e.toString());
      Fluttertoast.showToast(msg: e.toString());
    }
  }

  void updateUserBloodPressure(int bpID) async {
    // ! is null check operator
    final isValid = editBloodPressureFormKey.currentState!.validate();
    if (!isValid) {
      return;
    } else {
      try {
        var res = await http.post(
          Uri.parse(Api.updateBloodPressure),
          body: {
            'systolic': updateSystolicController.text.trim().toString(),
            'diastolic': updateDiastolicController.text.trim().toString(),
            'bpID': bpID.toString(),
          },
        );

        if (res.statusCode == 200) {
          var resBody = jsonDecode(res.body);
          if (resBody['success']) {
            Fluttertoast.showToast(msg: "Your blood pressure info updated.");
            //refresh page
            clearFormContents();
            allBloodPressures.clear();
            getUserAllBloodPressure();
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

  void deleteUserBloodPressure(int bpID) async {
    try {
      var res = await http.post(
        Uri.parse(Api.deleteUserBloodPressure),
        body: {
          'userID': _currentUser.user.id.toString(),
          'bpID': bpID.toString(),
        },
      );

      if (res.statusCode == 200) {
        var resBody = jsonDecode(res.body);
        if (resBody['success']) {
          Fluttertoast.showToast(msg: "One Blood Pressure deleted.");
          Get.offNamedUntil(
              Routes.blood_pressure_page, ModalRoute.withName('/root_app'));
        } else {
          Fluttertoast.showToast(msg: "Error occurred");
        }
      }
    } catch (e) {
      print(e.toString());
      Fluttertoast.showToast(msg: e.toString());
    }
  }
}
