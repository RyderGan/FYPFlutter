import 'dart:convert';
import 'package:fitnessapp/fitness_app/models/User/userModel.dart';
import 'package:fitnessapp/fitness_app/preferences/current_user.dart';
import 'package:fitnessapp/fitness_app/services/api_connection.dart';
import 'package:fitnessapp/routes.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class sendNotificationController extends GetxController {
  GlobalKey<FormState> sendNotificationFormKey = GlobalKey<FormState>();
  late TextEditingController userIDController, messageController;

  final CurrentUser _currentUser = Get.put(CurrentUser());

  @override
  void onInit() {
    super.onInit();
    userIDController = TextEditingController();
    messageController = TextEditingController();
  }

  @override
  void onClose() {
    userIDController.dispose();
    messageController.dispose();
    super.dispose();
  }

  String? validateDescription(String value) {
    if (messageController.text.trim().isEmpty) {
      return "Please fill in title";
    }
    return null;
  }

  Future<void> sendNotification() async {
    String userIDValue = "";
    try {
      var res = await http.get(
        Uri.parse(Api.getUserList),
      );

      if (res.statusCode == 200) {
        var resBodyOfLogin = jsonDecode(res.body);
        if (resBodyOfLogin['success']) {
          List<UserModel> users = await resBodyOfLogin["userList"]
              .map<UserModel>((json) => UserModel.fromJson(json))
              .toList();
          for (UserModel user in users) {
            if (user.email.toString() == userIDController.text.trim()) {
              userIDValue = user.id.toString();
            }
          }
        }
      }
    } catch (e) {
      print(e.toString());
      Fluttertoast.showToast(msg: e.toString());
    }

    // ! is null check operator
    final isValid = sendNotificationFormKey.currentState!.validate();
    if (!isValid) {
      return;
    } else {
      try {
        var res = await http.post(
          Uri.parse(Api.addNotification),
          body: {
            'userID': userIDValue,
            'msg': messageController.text.trim(),
          },
        );
        print(res.statusCode);
        if (res.statusCode == 200) {
          var resBodyOfLogin = jsonDecode(res.body);
          if (resBodyOfLogin['success']) {
            print(resBodyOfLogin);
            Fluttertoast.showToast(msg: "Your message has been sent.");
            //change rfidBand info to local storage using Shared Preferences
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
