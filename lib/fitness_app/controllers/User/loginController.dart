import 'dart:convert';

import 'package:fitnessapp/fitness_app/models/User/userModel.dart';
import 'package:fitnessapp/fitness_app/preferences/user_preferences.dart';
import 'package:fitnessapp/fitness_app/services/api_connection.dart';
import 'package:fitnessapp/routes.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class loginController extends GetxController {
  GlobalKey<FormState> loginFormKey = GlobalKey<FormState>();
  late TextEditingController emailController, passwordController;
  var email = '';
  var password = '';
  RxString userType = ''.obs;

  @override
  void onInit() {
    super.onInit();
    emailController = TextEditingController();
    passwordController = TextEditingController();
  }

  @override
  void onClose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  String? validateEmail(String value) {
    if (!GetUtils.isEmail(value)) {
      return "Provide valid email";
    }
    return null;
  }

  // ? is nullable
  String? validatePassword(String value) {
    if (value.length < 6) {
      return "Password must be of 6 characters";
    }
    return null;
  }

  void loginUser() async {
    try {
      // insert into database
      var res = await http.post(Uri.parse(Api.login), body: {
        "email": emailController.text.trim(),
        "password": passwordController.text.trim(),
        "user_type": userType.value.trim(),
      });

      if (res.statusCode == 200) {
        var resBodyOfLogin = jsonDecode(res.body);
        if (resBodyOfLogin['success']) {
          Fluttertoast.showToast(msg: "You are logged-in.");
          UserModel userInfo = UserModel.fromJson(resBodyOfLogin["userData"]);
          //save user info to local storage using Shared Preferences
          await RememberUserPrefs.storeUserData(userInfo);
          //navigate to home page
          Get.offAllNamed(Routes.loading);
          //Get.offAllNamed(Routes.root_app);
        } else {
          Fluttertoast.showToast(msg: "Incorrect credentials, try again.");
        }
      }
    } catch (e) {
      print(e.toString());
      Fluttertoast.showToast(msg: e.toString());
    }
  }

  void loginProcess() {
    // ! is null check operator
    final isValid = loginFormKey.currentState!.validate();
    if (!isValid) {
      return;
    } else {
      loginUser();
    }
  }
}
