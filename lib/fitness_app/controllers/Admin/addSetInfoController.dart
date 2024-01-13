import 'dart:convert';
import 'package:fitnessapp/fitness_app/models/Admin/checkpointModel.dart';
import 'package:fitnessapp/fitness_app/services/api_connection.dart';
import 'package:fitnessapp/routes.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class addSetInfoController extends GetxController {
  GlobalKey<FormState> addSetInfoFormKey = GlobalKey<FormState>();

  late TextEditingController nameController, bonusPointsController;

  @override
  void onInit() {
    nameController = TextEditingController();
    bonusPointsController = TextEditingController();
    super.onInit();
  }

  @override
  void onClose() {
    nameController.dispose();
    bonusPointsController.dispose();
    super.dispose();
  }

  Future<void> addSet() async {
    // ! is null check operator
    final isValid = addSetInfoFormKey.currentState!.validate();
    if (!isValid) {
      return;
    } else {
      try {
        var res = await http.post(
          Uri.parse(Api.addSet),
          body: {
            'name': nameController.text.trim(),
            'bonus_points': bonusPointsController.text.trim(),
          },
        );
        print(res.statusCode);
        if (res.statusCode == 200) {
          var resBodyOfLogin = jsonDecode(res.body);
          if (resBodyOfLogin['success']) {
            print(resBodyOfLogin);
            Fluttertoast.showToast(msg: "Your set info has been added.");
            //change set info to local storage using Shared Preferences
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
