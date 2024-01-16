import 'dart:convert';
import 'package:fitnessapp/fitness_app/services/api_connection.dart';
import 'package:flutter/material.dart';
import 'package:fitnessapp/fitness_app/models/User/userModel.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class registerController extends GetxController {
  GlobalKey<FormState> registerFormKey = GlobalKey<FormState>();
  late TextEditingController nameController,
      emailController,
      passwordController,
      userTypeController,
      genderController,
      dobController;

  var name = '';
  var email = '';
  var password = '';
  RxString userTypeValue = ''.obs;
  RxString gender = ''.obs;
  var dob = '';
  RxBool emailExist = false.obs;

  @override
  void onInit() {
    super.onInit();
    nameController = TextEditingController();
    emailController = TextEditingController();
    passwordController = TextEditingController();
    dobController = TextEditingController();
  }

  @override
  void onClose() {
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    dobController.dispose();
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

  void registerAction() async {
    // ! is null check operator
    final isValid = registerFormKey.currentState!.validate();

    if (!isValid) {
      return;
    } else {
      try {
        var res = await http.post(
          Uri.parse(Api.validateEmail),
          body: {'email': emailController.text.trim()},
        );
        if (res.statusCode == 200) {
          var resBody = jsonDecode(res.body);
          if (resBody['emailFound']) {
            Fluttertoast.showToast(
                msg:
                    "Email is already been taken by someone, try another email.");
          } else {
            //register user
            registerUser();
          }
        }
      } catch (e) {
        print(e.toString());
        Fluttertoast.showToast(msg: e.toString());
      }
    }
  }

  void registerUser() async {
    try {
      var res = await http.post(Uri.parse(Api.signUp), body: {
        "full_name": nameController.text.trim(),
        "email": emailController.text.trim(),
        "user_password": passwordController.text.trim(),
        "user_type": userTypeValue.value.trim(),
        "gender": gender.toString(),
        "dateOfBirth": dobController.text.trim(),
      });
      if (res.statusCode == 200) {
        print(jsonDecode(res.body));
        var resBodyOfSignUp = jsonDecode(res.body);
        if (resBodyOfSignUp['success']) {
          Fluttertoast.showToast(msg: "SignUp Successfully.");
          Get.back();
        } else {
          Fluttertoast.showToast(msg: "Error occurred, try it again.");
        }
      }
    } catch (e) {
      print(e.toString());
      Fluttertoast.showToast(msg: e.toString());
    }
  }
}
