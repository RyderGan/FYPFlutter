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

class changeUserLoginDetailsController extends GetxController {
  GlobalKey<FormState> changeUserEmailFormKey = GlobalKey<FormState>();
  GlobalKey<FormState> changeUserPasswordFormKey = GlobalKey<FormState>();
  late TextEditingController emailController,
      passwordController,
      confirmPasswordController;
  CurrentUser _currentUser = Get.put(CurrentUser());

  @override
  void onInit() {
    super.onInit();
    getUserInfo();
    emailController = TextEditingController();
    passwordController = TextEditingController();
    confirmPasswordController = TextEditingController();
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
          Fluttertoast.showToast(msg: "Your user info updated.");
          UserModel userInfo = UserModel.fromJson(resBodyOfLogin["userData"]);
          emailController.text = _currentUser.user.email;
        } else {
          Fluttertoast.showToast(msg: "Error occurred");
        }
      }
    } catch (e) {
      print(e.toString());
      Fluttertoast.showToast(msg: e.toString());
    }
  }

  String? validateEmail(String value) {
    if (!GetUtils.isEmail(value)) {
      return "Provide valid email";
    } else if (_currentUser.user.email == emailController.text.trim()) {
      return "Provide different email";
    }
    return null;
  }

  // ? is nullable
  String? validatePassword(String value) {
    if (value.isNotEmpty && value.length < 6) {
      return "Password must be of 6 characters";
    } else if (passwordController.text.trim() !=
        confirmPasswordController.text.trim()) {
      return "Password and confirm password are not the same.";
    }
    return null;
  }

  Future<void> changeUserEmail() async {
    // ! is null check operator
    final isValid = changeUserEmailFormKey.currentState!.validate();
    if (!isValid) {
      return;
    } else {
      try {
        var res = await http.post(
          Uri.parse(Api.validateEmail),
          body: {
            'email': emailController.text.trim(),
          },
        );

        if (res.statusCode == 200) {
          var resBody = jsonDecode(res.body);
          if (resBody['emailFound']) {
            Fluttertoast.showToast(
                msg:
                    "Email is already been taken by someone, try another email.");
          } else {
            //update user email
            updateUserEmail();
            Get.back();
          }
        }
      } catch (e) {
        print(e.toString());
        Fluttertoast.showToast(msg: e.toString());
      }
    }
  }

  void updateUserEmail() async {
    try {
      // insert into database
      var res = await http.post(Uri.parse(Api.updateUserEmail), body: {
        "email": emailController.text.trim(),
        'userID': _currentUser.user.id.toString(),
      });

      if (res.statusCode == 200) {
        var resBodyOfLogin = jsonDecode(res.body);
        if (resBodyOfLogin['success']) {
          Fluttertoast.showToast(msg: "Your email updated.");
          UserModel userInfo = UserModel.fromJson(resBodyOfLogin["userData"]);
          //change user info to local storage using Shared Preferences
          await RememberUserPrefs.storeUserData(userInfo);
          //navigate to home page
          Get.offNamed(Routes.root_app);
        } else {
          Fluttertoast.showToast(msg: "Error occurred");
        }
      }
    } catch (e) {
      print(e.toString());
      Fluttertoast.showToast(msg: e.toString());
    }
  }

  void changeUserPassword() async {
    final isValid = changeUserPasswordFormKey.currentState!.validate();
    if (!isValid) {
      return;
    } else {
      try {
        var res = await http.post(
          Uri.parse(Api.validatePassword),
          body: {
            'password': passwordController.text.trim(),
            'userID': _currentUser.user.id.toString(),
          },
        );

        if (res.statusCode == 200) {
          var resBody = jsonDecode(res.body);
          if (resBody['passwordSame']) {
            Fluttertoast.showToast(
                msg: "New password is the same as current password.");
          } else {
            //update user email
            updateUserPassword();
          }
        }
      } catch (e) {
        print(e.toString());
        Fluttertoast.showToast(msg: e.toString());
      }
    }
  }

  void updateUserPassword() async {
    try {
      // insert into database
      var res = await http.post(Uri.parse(Api.updateUserPassword), body: {
        "password": passwordController.text.trim(),
        'userID': _currentUser.user.id.toString(),
      });

      if (res.statusCode == 200) {
        var resBodyOfLogin = jsonDecode(res.body);
        if (resBodyOfLogin['success']) {
          Fluttertoast.showToast(msg: "Your password updated.");
          UserModel userInfo = UserModel.fromJson(resBodyOfLogin["userData"]);
          //change user info to local storage using Shared Preferences
          await RememberUserPrefs.storeUserData(userInfo);
          //navigate to home page
          Get.offNamed(Routes.root_app);
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
