import 'dart:convert';
import 'package:fitnessapp/fitness_app/preferences/current_user.dart';
import 'package:fitnessapp/fitness_app/services/api_connection.dart';
import 'package:fitnessapp/routes.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class viewFeedbackController extends GetxController {
  GlobalKey<FormState> viewFeedbackFormKey = GlobalKey<FormState>();
  late TextEditingController titleController, descriptionController;
  var feedbackID = 0;
  final CurrentUser _currentUser = Get.put(CurrentUser());

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

  void setUserDetails(var arguments) {
    titleController = TextEditingController();
    titleController.text = arguments.title;
    descriptionController = TextEditingController();
    descriptionController.text = arguments.description;
    feedbackID = arguments.feedbackID;
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

  Future<void> deleteFeedback() async {
    var resultResponse = await Get.dialog(
      AlertDialog(
        backgroundColor: Colors.grey,
        title: const Text(
          "Delete Feedback",
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
      try {
        // delete feedback
        var res = await http.post(Uri.parse(Api.deleteFeedback), body: {
          "feedbackID": feedbackID.toString(),
        });
        if (res.statusCode == 200) {
          var resBodyOfLogin = jsonDecode(res.body);
          if (resBodyOfLogin['success']) {
            Fluttertoast.showToast(msg: "Feedback Deleted!");
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
