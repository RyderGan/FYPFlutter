import 'dart:convert';
import 'package:fitnessapp/fitness_app/services/api_connection.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class resetPasswordController extends GetxController {
  GlobalKey<FormState> resetPasswordFormKey = GlobalKey<FormState>();
  late TextEditingController emailController,
      passwordController,
      confirmPasswordController;
  //CurrentUser _currentUser = Get.put(CurrentUser());

  @override
  void onInit() {
    super.onInit();
    emailController = TextEditingController();
    passwordController = TextEditingController();
    confirmPasswordController = TextEditingController();
  }

  @override
  void onClose() {
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
  }

  String? validateEmail(String value) {
    if (!GetUtils.isEmail(value)) {
      return "Provide valid email";
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

  void resetUserPasswordAction() async {
    final isValid = resetPasswordFormKey.currentState!.validate();
    if (!isValid) {
      return;
    } else {
      try {
        var res = await http.post(
          Uri.parse(Api.validateResetPassword),
          body: {
            'password': passwordController.text.trim(),
            'email': emailController.text.trim(),
          },
        );

        if (res.statusCode == 200) {
          var resBody = jsonDecode(res.body);
          if (resBody['passwordSame']) {
            Fluttertoast.showToast(
                msg: "New password is the same as current password.");
          } else {
            //check email exist in db
            checkEmailExist();
          }
        }
      } catch (e) {
        print(e.toString());
        Fluttertoast.showToast(msg: e.toString());
      }
    }
  }

  void checkEmailExist() async {
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
          //reset password
          resetUserPassword();
        } else {
          Fluttertoast.showToast(msg: "Email not found");
        }
      }
    } catch (e) {
      print(e.toString());
      Fluttertoast.showToast(msg: e.toString());
    }
  }

  void resetUserPassword() async {
    try {
      // insert into database
      var res = await http.post(Uri.parse(Api.resetPassword), body: {
        "password": passwordController.text.trim(),
        'email': emailController.text.trim(),
      });

      if (res.statusCode == 200) {
        var resBodyOfLogin = jsonDecode(res.body);
        if (resBodyOfLogin['success']) {
          Fluttertoast.showToast(msg: "Your password resetted.");
          //navigate to home page
          Get.back();
        } else {
          Fluttertoast.showToast(msg: "Wrong email or error occurred");
        }
      }
    } catch (e) {
      print(e.toString());
      Fluttertoast.showToast(msg: e.toString());
    }
  }
}
