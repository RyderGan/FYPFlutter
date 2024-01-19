import 'dart:convert';
import 'package:fitnessapp/fitness_app/models/Admin/checkpointModel.dart';
import 'package:fitnessapp/fitness_app/models/Admin/pathModel.dart';
import 'package:fitnessapp/fitness_app/services/api_connection.dart';
import 'package:fitnessapp/routes.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class editPathCheckpointsController extends GetxController {
  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onClose() {
    super.dispose();
  }

  Future<void> updatePathCheckpoints(
      List<CheckpointModel> currentCheckpointList, PathModel path) async {
    List<String> checkpoint_list = [];
    for (CheckpointModel checkpoint in currentCheckpointList) {
      checkpoint_list.add(checkpoint.id.toString());
    }
    try {
      var res = await http.post(
        Uri.parse(Api.updatePathCheckpoints),
        body: {
          'checkpoint_list': checkpoint_list
              .toString()
              .replaceAll("[", "")
              .replaceAll("]", ""),
          'pathID': path.id.toString(),
        },
      );
      if (res.statusCode == 200) {
        var resBodyOfLogin = jsonDecode(res.body);
        print(resBodyOfLogin);
        if (resBodyOfLogin['success']) {
          print(resBodyOfLogin);
          Fluttertoast.showToast(
              msg: "The path checkpoints is has been updated.");
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
  //   String fromCpIDValue = "";
  //   String toCpIDValue = "";
  //   try {
  //     var res = await http.get(
  //       Uri.parse(Api.getCheckpointList),
  //     );

  //     if (res.statusCode == 200) {
  //       var resBodyOfLogin = jsonDecode(res.body);
  //       if (resBodyOfLogin['success']) {
  //         List<CheckpointModel> checkpoints =
  //             await resBodyOfLogin["checkpointList"]
  //                 .map<CheckpointModel>(
  //                     (json) => CheckpointModel.fromJson(json))
  //                 .toList();
  //         for (CheckpointModel checkpoint in checkpoints) {
  //           if (checkpoint.name.toString() == fromCpIDController.text.trim()) {
  //             fromCpIDValue = checkpoint.id.toString();
  //           }
  //           if (checkpoint.name.toString() == toCpIDController.text.trim()) {
  //             toCpIDValue = checkpoint.id.toString();
  //           }
  //         }
  //       }
  //     }
  //   } catch (e) {
  //     print(e.toString());
  //     Fluttertoast.showToast(msg: e.toString());
  //   }
  //   // ! is null check operator
  //   final isValid = editPathInfoFormKey.currentState!.validate();
  //   if (!isValid) {
  //     return;
  //   } else {
  //     try {
  //       var res = await http.post(
  //         Uri.parse(Api.updatePathInfo),
  //         body: {
  //           'name': nameController.text.trim(),
  //           'fromCpID': fromCpIDValue,
  //           'toCpID': toCpIDValue,
  //           'distance': distanceController.text.trim(),
  //           'elevation': elevationController.text.trim(),
  //           'difficulty': difficultyController.text.trim(),
  //           'pathID': arguments.path_id.toString(),
  //         },
  //       );
  //       if (res.statusCode == 200) {
  //         var resBodyOfLogin = jsonDecode(res.body);
  //         if (resBodyOfLogin['success']) {
  //           print(resBodyOfLogin);
  //           Fluttertoast.showToast(msg: "The path info has been updated.");
  //           //change path info to local storage using Shared Preferences
  //           //navigate to home page
  //           Get.offAllNamed(Routes.admin_root_app);
  //         } else {
  //           Fluttertoast.showToast(msg: "Error occurred");
  //         }
  //       }
  //     } catch (e) {
  //       print(e.toString());
  //       Fluttertoast.showToast(msg: e.toString());
  //     }
  //   }
  // }
}
