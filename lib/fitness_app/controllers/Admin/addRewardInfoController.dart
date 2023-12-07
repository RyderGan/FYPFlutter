import 'dart:convert';
import 'package:fitnessapp/fitness_app/services/api_connection.dart';
import 'package:fitnessapp/routes.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class addRewardInfoController extends GetxController {
  GlobalKey<FormState> addRewardInfoFormKey = GlobalKey<FormState>();

  late TextEditingController titleController,
      descriptionController,
      pointController;

  @override
  void onInit() {
    titleController = TextEditingController();
    descriptionController = TextEditingController();
    pointController = TextEditingController();
    super.onInit();
  }

  @override
  void onClose() {
    titleController.dispose();
    descriptionController.dispose();
    pointController.dispose();
    super.dispose();
  }

  Future<void> addReward() async {
    // ! is null check operator
    final isValid = addRewardInfoFormKey.currentState!.validate();
    if (!isValid) {
      return;
    } else {
      try {
        var res = await http.post(
          Uri.parse(Api.addReward),
          body: {
            'rewardTitle': titleController.text.trim(),
            'rewardDescription': descriptionController.text.trim(),
            'requiredPt': pointController.text.trim(),
          },
        );
        if (res.statusCode == 200) {
          var resBodyOfLogin = jsonDecode(res.body);
          if (resBodyOfLogin['success']) {
            print(resBodyOfLogin);
            Fluttertoast.showToast(msg: "Your reward info has been added.");
            //change reward info to local storage using Shared Preferences
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
