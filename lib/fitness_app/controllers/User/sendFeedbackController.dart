import 'dart:convert';
import 'package:fitnessapp/fitness_app/preferences/current_user.dart';
import 'package:fitnessapp/fitness_app/services/api_connection.dart';
import 'package:fitnessapp/routes.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class sendFeedbackController extends GetxController {
  GlobalKey<FormState> sendFeedbackFormKey = GlobalKey<FormState>();
  late TextEditingController titleController, descriptionController;

  CurrentUser _currentUser = Get.put(CurrentUser());

  @override
  void onInit() {
    super.onInit();
    titleController = TextEditingController();
    descriptionController = TextEditingController();
  }

  @override
  void onClose() {
    titleController.dispose();
    descriptionController.dispose();
    super.dispose();
  }

  String? validateTitle(String value) {
    if (titleController.text.trim().isEmpty) {
      return "Please fill in title";
    }
    return null;
  }

  String? validateDescription(String value) {
    if (descriptionController.text.trim().isEmpty) {
      return "Please fill in title";
    }
    return null;
  }

  Future<void> sendFeedback() async {
    // ! is null check operator
    final isValid = sendFeedbackFormKey.currentState!.validate();
    if (!isValid) {
      return;
    } else {
      try {
        // insert into database
        var res = await http.post(Uri.parse(Api.addFeedback), body: {
          "title": titleController.text.trim(),
          "description": descriptionController.text.trim(),
          "userID": _currentUser.user.id.toString(),
        });

        if (res.statusCode == 200) {
          var resBodyOfLogin = jsonDecode(res.body);
          if (resBodyOfLogin['success']) {
            Fluttertoast.showToast(msg: "Your feedback has been sent.");
            //navigate to home page
            Get.offAllNamed(Routes.root_app);
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
