import 'dart:convert';
import 'package:fitnessapp/fitness_app/models/Admin/rfidCheckpointModel.dart';
import 'package:fitnessapp/fitness_app/services/api_connection.dart';
import 'package:fitnessapp/routes.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class EditPathInfoController extends GetxController {
  GlobalKey<FormState> editPathInfoFormKey = GlobalKey<FormState>();
  late TextEditingController nameController,
      fromCpIDController,
      toCpIDController,
      distanceController,
      elevationController,
      difficultyController;

  @override
  void onInit() {
    fromCpIDController = TextEditingController();
    toCpIDController = TextEditingController();
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

  void setPathDetails(var arguments) {
    nameController = TextEditingController();
    nameController.text = arguments.name;
    distanceController = TextEditingController();
    distanceController.text = arguments.distance.toString();
    elevationController = TextEditingController();
    elevationController.text = arguments.elevation.toString();
    difficultyController = TextEditingController();
    difficultyController.text = arguments.difficulty.toString();
  }

  Future<void> updatePathInfo(var arguments) async {
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
    final isValid = editPathInfoFormKey.currentState!.validate();
    if (!isValid) {
      return;
    } else {
      try {
        var res = await http.post(
          Uri.parse(Api.updatePathInfo),
          body: {
            'name': nameController.text.trim(),
            'fromCpID': fromCpIDValue,
            'toCpID': toCpIDValue,
            'distance': distanceController.text.trim(),
            'elevation': elevationController.text.trim(),
            'difficulty': difficultyController.text.trim(),
            'pathID': arguments.path_id.toString(),
          },
        );
        if (res.statusCode == 200) {
          var resBodyOfLogin = jsonDecode(res.body);
          if (resBodyOfLogin['success']) {
            print(resBodyOfLogin);
            Fluttertoast.showToast(msg: "Your path info updated.");
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

  Future<void> deletePath(var arguments) async {
    var resultResponse = await Get.dialog(
      AlertDialog(
        backgroundColor: Colors.grey,
        title: const Text(
          "Delete Path",
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
      final isValid = editPathInfoFormKey.currentState!.validate();
      if (!isValid) {
        return;
      } else {
        try {
          var res = await http.post(
            Uri.parse(Api.deletePath),
            body: {
              'pathID': arguments.path_id.toString(),
            },
          );
          if (res.statusCode == 200) {
            var resBodyOfLogin = jsonDecode(res.body);
            if (resBodyOfLogin['success']) {
              print(resBodyOfLogin);
              Fluttertoast.showToast(msg: "Path is Deleted");
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
}
