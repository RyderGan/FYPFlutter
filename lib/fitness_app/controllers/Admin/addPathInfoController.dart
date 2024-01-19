import 'dart:convert';
import 'package:fitnessapp/fitness_app/models/Admin/checkpointModel.dart';
import 'package:fitnessapp/fitness_app/services/api_connection.dart';
import 'package:fitnessapp/routes.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class addPathInfoController extends GetxController {
  GlobalKey<FormState> addPathInfoFormKey = GlobalKey<FormState>();

  late TextEditingController nameController,
      distanceController,
      elevationController,
      difficultyController,
      pointsController,
      timeLimitController,
      typeController;

  @override
  void onInit() {
    nameController = TextEditingController();
    distanceController = TextEditingController();
    elevationController = TextEditingController();
    difficultyController = TextEditingController();
    pointsController = TextEditingController();
    timeLimitController = TextEditingController();
    typeController = TextEditingController();
    super.onInit();
  }

  @override
  void onClose() {
    nameController.dispose();
    distanceController.dispose();
    elevationController.dispose();
    difficultyController.dispose();
    pointsController.dispose();
    timeLimitController.dispose();
    typeController.dispose();
    super.dispose();
  }

  Future<void> addPath() async {
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
            'distance': distanceController.text.trim(),
            'elevation': elevationController.text.trim(),
            'difficulty': difficultyController.text.trim(),
            'points': pointsController.text.trim(),
            'time_limit': timeLimitController.text.trim(),
            'type': typeController.text.trim(),
          },
        );
        if (res.statusCode == 200) {
          var resBodyOfLogin = jsonDecode(res.body);
          if (resBodyOfLogin['success']) {
            print(resBodyOfLogin);
            Fluttertoast.showToast(msg: "The path info has been added.");
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
