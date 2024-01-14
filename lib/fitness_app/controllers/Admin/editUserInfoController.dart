import 'dart:convert';
import 'package:fitnessapp/fitness_app/services/api_connection.dart';
import 'package:fitnessapp/routes.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class editUserInfoController extends GetxController {
  GlobalKey<FormState> editUserInfoFormKey = GlobalKey<FormState>();

  late TextEditingController fullNameController,
      genderController,
      emailController,
      dobController,
      rewardPointsController;
  RxString gender = ''.obs;

  @override
  void onClose() {
    fullNameController.dispose();
    emailController.dispose();
    dobController.dispose();
    rewardPointsController.dispose();
    super.dispose();
  }

  void setUserDetails(var arguments) {
    fullNameController = TextEditingController();
    fullNameController.text = arguments.fullName;
    emailController = TextEditingController();
    emailController.text = arguments.email;
    gender.value = arguments.gender;
    dobController = TextEditingController();
    dobController.text = arguments.dateOfBirth;
    rewardPointsController = TextEditingController();
    rewardPointsController.text = arguments.rewardPoint.toString();
  }

  String? validateEmail(String value) {
    if (!GetUtils.isEmail(value)) {
      return "Provide valid email";
    }
    return null;
  }

  Future<void> updateUserInfo(var arguments) async {
    // ! is null check operator
    final isValid = editUserInfoFormKey.currentState!.validate();
    if (!isValid) {
      return;
    } else {
      try {
        var res = await http.post(
          Uri.parse(Api.adminUpdateUserInfo),
          body: {
            'full_name': fullNameController.text.trim(),
            'email': emailController.text.trim(),
            'gender': gender.value,
            'dob': dobController.text.trim(),
            'rewardPoint': rewardPointsController.text.trim(),
            'userID': arguments.id.toString(),
          },
        );

        if (res.statusCode == 200) {
          var resBodyOfLogin = jsonDecode(res.body);
          if (resBodyOfLogin['success']) {
            print(resBodyOfLogin);
            Fluttertoast.showToast(msg: "Your user info updated.");
            //change user info to local storage using Shared Preferences
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

  Future<void> deleteUser(var arguments) async {
    var resultResponse = await Get.dialog(
      AlertDialog(
        backgroundColor: Colors.grey,
        title: const Text(
          "Delete User",
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
      final isValid = editUserInfoFormKey.currentState!.validate();
      if (!isValid) {
        return;
      } else {
        try {
          var res = await http.post(
            Uri.parse(Api.deleteUser),
            body: {
              'userID': arguments.id.toString(),
            },
          );

          if (res.statusCode == 200) {
            var resBodyOfLogin = jsonDecode(res.body);
            if (resBodyOfLogin['success']) {
              print(resBodyOfLogin);
              Fluttertoast.showToast(msg: "User is Deleted");
              //change user info to local storage using Shared Preferences
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
