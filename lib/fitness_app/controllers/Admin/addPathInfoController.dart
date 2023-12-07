import 'dart:convert';
import 'package:fitnessapp/fitness_app/models/Admin/rfidCheckpointModel.dart';
import 'package:fitnessapp/fitness_app/services/api_connection.dart';
import 'package:fitnessapp/routes.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class addPathInfoController extends GetxController {
  GlobalKey<FormState> addPathInfoFormKey = GlobalKey<FormState>();

  late TextEditingController nameController,
      fromCpIDController,
      toCpIDController,
      distanceController,
      elevationController,
      difficultyController;

  @override
  void onInit() {
    nameController = TextEditingController();
    fromCpIDController = TextEditingController();
    toCpIDController = TextEditingController();
    distanceController = TextEditingController();
    elevationController = TextEditingController();
    difficultyController = TextEditingController();
    super.onInit();
  }

  @override
  void onClose() {
    nameController.dispose();
    fromCpIDController.dispose();
    toCpIDController.dispose();
    distanceController.dispose();
    elevationController.dispose();
    difficultyController.dispose();
    super.dispose();
  }

  Future<void> addPath() async {
    String fromCpIDValue = "";
    String toCpIDValue = "";
    try {
      var res = await http.get(
        Uri.parse(Api.getRfidCheckpointList),
      );

      if (res.statusCode == 200) {
        var resBodyOfLogin = jsonDecode(res.body);
        if (resBodyOfLogin['success']) {
          List<RfidCheckpointModel> checkpoints =
              await resBodyOfLogin["rfidCheckpointList"]
                  .map<RfidCheckpointModel>(
                      (json) => RfidCheckpointModel.fromJson(json))
                  .toList();
          for (RfidCheckpointModel checkpoint in checkpoints) {
            if (checkpoint.name.toString() == fromCpIDController.text.trim()) {
              fromCpIDValue = checkpoint.rfid_checkpoint_id.toString();
            }
            if (checkpoint.name.toString() == toCpIDController.text.trim()) {
              toCpIDValue = checkpoint.rfid_checkpoint_id.toString();
            }
          }
        }
      }
    } catch (e) {
      print(e.toString());
      Fluttertoast.showToast(msg: e.toString());
    }

    // ! is null check operator
    final isValid = addPathInfoFormKey.currentState!.validate();
    if (!isValid) {
      return;
    } else {
      try {
        var res = await http.post(
          Uri.parse(Api.addPath),
          body: {
            'name': nameController.text.trim(),
            'fromCpID': fromCpIDValue,
            'toCpID': toCpIDValue,
            'distance': distanceController.text.trim(),
            'elevation': elevationController.text.trim(),
            'difficulty': difficultyController.text.trim(),
          },
        );
        if (res.statusCode == 200) {
          var resBodyOfLogin = jsonDecode(res.body);
          if (resBodyOfLogin['success']) {
            print(resBodyOfLogin);
            Fluttertoast.showToast(msg: "Your path info has been added.");
            //change path info to local storage using Shared Preferences
            //navigate to home page
            Get.offAllNamed(Routes.admin_root_app);
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
}
