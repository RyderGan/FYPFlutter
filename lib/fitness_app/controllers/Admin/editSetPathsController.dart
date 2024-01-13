import 'dart:convert';
import 'package:fitnessapp/fitness_app/models/Admin/pathModel.dart';
import 'package:fitnessapp/fitness_app/models/Admin/setModel.dart';
import 'package:fitnessapp/fitness_app/services/api_connection.dart';
import 'package:fitnessapp/routes.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class editSetPathsController extends GetxController {
  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onClose() {
    super.dispose();
  }

  Future<void> updateSetPaths(
      List<PathModel> currentPathList, SetModel set) async {
    List<String> path_list = [];
    for (PathModel path in currentPathList) {
      path_list.add(path.id.toString());
    }
    try {
      var res = await http.post(
        Uri.parse(Api.updateSetPaths),
        body: {
          'path_list':
              path_list.toString().replaceAll("[", "").replaceAll("]", ""),
          'setID': set.id.toString(),
        },
      );
      if (res.statusCode == 200) {
        var resBodyOfLogin = jsonDecode(res.body);
        print(resBodyOfLogin);
        if (resBodyOfLogin['success']) {
          print(resBodyOfLogin);
          Fluttertoast.showToast(msg: "Your set paths is updated.");
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
  //   String fromCpIDValue = "";
  //   String toCpIDValue = "";
  //   try {
  //     var res = await http.get(
  //       Uri.parse(Api.getpathList),
  //     );

  //     if (res.statusCode == 200) {
  //       var resBodyOfLogin = jsonDecode(res.body);
  //       if (resBodyOfLogin['success']) {
  //         List<PathModel> paths =
  //             await resBodyOfLogin["pathList"]
  //                 .map<PathModel>(
  //                     (json) => PathModel.fromJson(json))
  //                 .toList();
  //         for (PathModel path in paths) {
  //           if (path.name.toString() == fromCpIDController.text.trim()) {
  //             fromCpIDValue = path.id.toString();
  //           }
  //           if (path.name.toString() == toCpIDController.text.trim()) {
  //             toCpIDValue = path.id.toString();
  //           }
  //         }
  //       }
  //     }
  //   } catch (e) {
  //     print(e.toString());
  //     Fluttertoast.showToast(msg: e.toString());
  //   }
  //   // ! is null check operator
  //   final isValid = editSetInfoFormKey.currentState!.validate();
  //   if (!isValid) {
  //     return;
  //   } else {
  //     try {
  //       var res = await http.post(
  //         Uri.parse(Api.updateSetInfo),
  //         body: {
  //           'name': nameController.text.trim(),
  //           'fromCpID': fromCpIDValue,
  //           'toCpID': toCpIDValue,
  //           'distance': distanceController.text.trim(),
  //           'elevation': elevationController.text.trim(),
  //           'difficulty': difficultyController.text.trim(),
  //           'setID': arguments.id.toString(),
  //         },
  //       );
  //       if (res.statusCode == 200) {
  //         var resBodyOfLogin = jsonDecode(res.body);
  //         if (resBodyOfLogin['success']) {
  //           print(resBodyOfLogin);
  //           Fluttertoast.showToast(msg: "Your set info updated.");
  //           //change set info to local storage using Shared Preferences
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
