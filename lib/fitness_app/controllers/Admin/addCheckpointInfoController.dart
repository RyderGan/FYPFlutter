import 'dart:convert';
import 'package:fitnessapp/fitness_app/services/api_connection.dart';
import 'package:fitnessapp/routes.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class addCheckpointInfoController extends GetxController {
  GlobalKey<FormState> addCheckpointInfoFormKey = GlobalKey<FormState>();

  late TextEditingController nameController,
      descriptionController,
      locationController;

  @override
  void onInit() {
    nameController = TextEditingController();
    descriptionController = TextEditingController();
    locationController = TextEditingController();
    super.onInit();
  }

  @override
  void onClose() {
    nameController.dispose();
    descriptionController.dispose();
    locationController.dispose();
    super.dispose();
  }

  Future<void> addCheckpoint() async {
    // ! is null check operator
    final isValid = addCheckpointInfoFormKey.currentState!.validate();
    if (!isValid) {
      return;
    } else {
      try {
        var res = await http.post(
          Uri.parse(Api.addRfidCheckpoint),
          body: {
            'name': nameController.text.trim(),
            'description': descriptionController.text.trim(),
            'location': locationController.text.trim(),
          },
        );
        if (res.statusCode == 200) {
          var resBodyOfLogin = jsonDecode(res.body);
          if (resBodyOfLogin['success']) {
            print(resBodyOfLogin);
            Fluttertoast.showToast(msg: "Your checkpoint info has been added.");
            //change checkpoint info to local storage using Shared Preferences
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
