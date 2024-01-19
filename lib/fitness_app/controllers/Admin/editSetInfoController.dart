import 'dart:convert';
import 'package:fitnessapp/fitness_app/models/Admin/checkpointModel.dart';
import 'package:fitnessapp/fitness_app/services/api_connection.dart';
import 'package:fitnessapp/routes.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class EditSetInfoController extends GetxController {
  GlobalKey<FormState> editSetInfoFormKey = GlobalKey<FormState>();
  late TextEditingController nameController, bonusPointsController;
  RxString type = ''.obs;

  @override
  void onClose() {
    nameController.dispose();
    bonusPointsController.dispose();
    super.dispose();
  }

  void setSetDetails(var arguments) {
    nameController = TextEditingController();
    nameController.text = arguments.name;
    bonusPointsController = TextEditingController();
    bonusPointsController.text = arguments.bonus_points.toString();
    type.value = arguments.type;
  }

  Future<void> updateSetInfo(var arguments) async {
    // ! is null check operator
    final isValid = editSetInfoFormKey.currentState!.validate();
    if (!isValid) {
      return;
    } else {
      try {
        var res = await http.post(
          Uri.parse(Api.updateSetInfo),
          body: {
            'name': nameController.text.trim(),
            'bonus_points': bonusPointsController.text.trim(),
            'type': type.value,
            'setID': arguments.id.toString(),
          },
        );
        if (res.statusCode == 200) {
          var resBodyOfLogin = jsonDecode(res.body);
          if (resBodyOfLogin['success']) {
            print(resBodyOfLogin);
            Fluttertoast.showToast(msg: "The set info has been updated.");
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

  Future<void> deleteSet(var arguments) async {
    var resultResponse = await Get.dialog(
      AlertDialog(
        backgroundColor: Colors.grey,
        title: const Text(
          "Delete Set",
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
      final isValid = editSetInfoFormKey.currentState!.validate();
      if (!isValid) {
        return;
      } else {
        try {
          var res = await http.post(
            Uri.parse(Api.deleteSet),
            body: {
              'setID': arguments.id.toString(),
            },
          );
          if (res.statusCode == 200) {
            var resBodyOfLogin = jsonDecode(res.body);
            if (resBodyOfLogin['success']) {
              print(resBodyOfLogin);
              Fluttertoast.showToast(msg: "Set is Deleted");
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
}
