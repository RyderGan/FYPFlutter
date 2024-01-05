import 'dart:convert';
import 'package:fitnessapp/fitness_app/services/api_connection.dart';
import 'package:fitnessapp/routes.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class editRewardInfoController extends GetxController {
  GlobalKey<FormState> editRewardInfoFormKey = GlobalKey<FormState>();

  late TextEditingController titleController,
      descriptionController,
      pointController;
  RxString gender = ''.obs;


  @override
  void onClose() {
    titleController.dispose();
    descriptionController.dispose();
    pointController.dispose();
    super.dispose();
  }

  void setRewardDetails(var arguments) {
    titleController = TextEditingController();
    titleController.text = arguments.title;
    descriptionController = TextEditingController();
    descriptionController.text = arguments.description;
    pointController = TextEditingController();
    pointController.text = arguments.required_pt.toString();
  }

  Future<void> updateRewardInfo(var arguments) async {
    // ! is null check operator
    final isValid = editRewardInfoFormKey.currentState!.validate();
    if (!isValid) {
      return;
    } else {
      try {
        var res = await http.post(
          Uri.parse(Api.updateRewardInfo),
          body: {
            'rewardTitle': titleController.text.trim(),
            'rewardDescription': descriptionController.text.trim(),
            'requiredPt': pointController.text.trim(),
            'rewardId': arguments.reward_id.toString(),
          },
        );
        if (res.statusCode == 200) {
          var resBodyOfLogin = jsonDecode(res.body);
          if (resBodyOfLogin['success']) {
            print(resBodyOfLogin);
            Fluttertoast.showToast(msg: "Your reward info updated.");
            //change reward info to local storage using Shared Preferences
            //navigate to home page
            Get.offAllNamed(Routes.admin_root_app);
          } else {
            print(resBodyOfLogin);
            Fluttertoast.showToast(msg: "Error occurred");
          }
        }
      } catch (e) {
        print(e.toString());
        Fluttertoast.showToast(msg: e.toString());
      }
    }
  }

  Future<void> deleteReward(var arguments) async {
    var resultResponse = await Get.dialog(
      AlertDialog(
        backgroundColor: Colors.grey,
        title: const Text(
          "Delete Reward",
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        content: const Text(
          "Are you sure?\nThis cannot be undone.",
        ),
        actions: [
          TextButton(
            onPressed: () {
              Get.back(result: "delete");
            },
            child: const Text(
              "Yes",
              style: TextStyle(
                color: Colors.black,
              ),
            ),
          ),
          TextButton(
            onPressed: () {
              Get.back();
            },
            child: const Text(
              "No",
              style: TextStyle(
                color: Colors.black,
              ),
            ),
          ),
        ],
      ),
    );

    if (resultResponse == 'delete') {
      final isValid = editRewardInfoFormKey.currentState!.validate();
      if (!isValid) {
        return;
      } else {
        try {
          var res = await http.post(
            Uri.parse(Api.deleteReward),
            body: {
              'rewardID': arguments.reward_id.toString(),
            },
          );
          if (res.statusCode == 200) {
            var resBodyOfLogin = jsonDecode(res.body);
            if (resBodyOfLogin['success']) {
              print(resBodyOfLogin);
              Fluttertoast.showToast(msg: "Reward is Deleted");
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
}
