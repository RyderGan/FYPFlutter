import 'dart:convert';
import 'package:fitnessapp/fitness_app/models/Admin/userModel.dart';
import 'package:fitnessapp/fitness_app/services/api_connection.dart';
import 'package:fitnessapp/routes.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class addRfidBandInfoController extends GetxController {
  GlobalKey<FormState> addRfidBandInfoFormKey = GlobalKey<FormState>();

  late TextEditingController nameController, userIDController, uidController;

  @override
  void onInit() {
    nameController = TextEditingController();
    userIDController = TextEditingController();
    uidController = TextEditingController();
    super.onInit();
  }

  @override
  void onClose() {
    nameController.dispose();
    userIDController.dispose();
    uidController.dispose();
    super.dispose();
  }

  Future<void> addRfidBand() async {
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
    final isValid = addRfidBandInfoFormKey.currentState!.validate();
    if (!isValid) {
      return;
    } else {
      try {
        var res = await http.post(
          Uri.parse(Api.addRfidBand),
          body: {
            'rfidBandUid': uidController.text.trim(),
            'rfidBandName': nameController.text.trim(),
            'userID': userIDValue,
          },
        );
        if (res.statusCode == 200) {
          var resBodyOfLogin = jsonDecode(res.body);
          if (resBodyOfLogin['success']) {
            print(resBodyOfLogin);
            Fluttertoast.showToast(msg: "Your RFID Band info has been added.");
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
