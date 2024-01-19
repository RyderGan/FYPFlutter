import 'dart:convert';
import 'package:fitnessapp/fitness_app/models/User/userModel.dart';
import 'package:fitnessapp/fitness_app/preferences/current_user.dart';
import 'package:fitnessapp/fitness_app/preferences/user_preferences.dart';
import 'package:fitnessapp/fitness_app/services/api_connection.dart';
import 'package:fitnessapp/routes.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class changeUserInfoController extends GetxController {
  GlobalKey<FormState> changeUserInfoFormKey = GlobalKey<FormState>();

  late TextEditingController fullNameController,
      genderController,
      dobController;

  final CurrentUser _currentUser = Get.put(CurrentUser());
  RxString gender = ''.obs;

  @override
  void onInit() {
    super.onInit();
    getUserInfo();
    fullNameController = TextEditingController();
    dobController = TextEditingController();
  }

  @override
  void onClose() {
    super.dispose();
  }

  void getUserInfo() async {
    try {
      var res = await http.post(
        Uri.parse(Api.getUserDetails),
        body: {
          'userID': _currentUser.user.id.toString(),
        },
      );

      if (res.statusCode == 200) {
        var resBodyOfLogin = jsonDecode(res.body);
        if (resBodyOfLogin['success']) {
          Fluttertoast.showToast(msg: "Your user info has been updated.");
          UserModel userInfo = UserModel.fromJson(resBodyOfLogin["userData"]);
          fullNameController.text = userInfo.fullName;
          gender.value = userInfo.gender;
          dobController.text = userInfo.dateOfBirth;
        } else {
          Fluttertoast.showToast(msg: "Error occurred");
        }
      }
    } catch (e) {
      print(e.toString());
      Fluttertoast.showToast(msg: e.toString());
    }
  }

  Future<void> updateUserInfo() async {
    // ! is null check operator
    final isValid = changeUserInfoFormKey.currentState!.validate();
    if (!isValid) {
      return;
    } else {
      try {
        var res = await http.post(
          Uri.parse(Api.updateUserInfo),
          body: {
            'full_name': fullNameController.text.trim(),
            'gender': gender.value,
            'dob': dobController.text.trim(),
            'userID': _currentUser.user.id.toString(),
          },
        );

        if (res.statusCode == 200) {
          var resBodyOfLogin = jsonDecode(res.body);
          if (resBodyOfLogin['success']) {
            Fluttertoast.showToast(msg: "Your user info has been updated.");
            UserModel userInfo = UserModel.fromJson(resBodyOfLogin["userData"]);
            //change user info to local storage using Shared Preferences
            await RememberUserPrefs.storeUserData(userInfo);
            //navigate to home page
            Get.back();
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
