import 'dart:convert';
import 'package:fitnessapp/fitness_app/models/User/userModel.dart';
import 'package:fitnessapp/fitness_app/services/api_connection.dart';
import 'package:fitnessapp/routes.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class EditRfidBandInfoController extends GetxController {
  GlobalKey<FormState> editRfidBandInfoFormKey = GlobalKey<FormState>();
  late TextEditingController nameController, userIDController, uidController;

  @override
  void onInit() {
    userIDController = TextEditingController();
    super.onInit();
  }

  @override
  void onClose() {
    nameController.dispose();
    userIDController.dispose();
    uidController.dispose();
    super.dispose();
  }

  void setRfidBandDetails(var arguments) {
    nameController = TextEditingController();
    nameController.text = arguments.name;
    uidController = TextEditingController();
    uidController.text = arguments.uid;
  }

  Future<void> updateRfidBandInfo(var arguments) async {
    String userIDValue = "";
    if (userIDController.text.trim() == "Select user ID") {
      userIDValue = "0";
    } else {
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
    }
    // ! is null check operator
    final isValid = editRfidBandInfoFormKey.currentState!.validate();
    if (!isValid) {
      return;
    } else {
      try {
        var res = await http.post(
          Uri.parse(Api.updateRfidBandInfo),
          body: {
            'rfidBandUid': uidController.text.trim(),
            'rfidBandName': nameController.text.trim(),
            'userID': userIDValue,
            'rfidBandID': arguments.rfid_band_id.toString(),
          },
        );
        if (res.statusCode == 200) {
          var resBodyOfLogin = jsonDecode(res.body);
          if (resBodyOfLogin['success']) {
            print(resBodyOfLogin);
            Fluttertoast.showToast(
                msg: "The RFID Band info is has been updated.");
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

  Future<void> deleteRfidBand(var arguments) async {
    var resultResponse = await Get.dialog(
      AlertDialog(
        backgroundColor: Colors.grey,
        title: const Text(
          "Delete RFID Band",
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
      final isValid = editRfidBandInfoFormKey.currentState!.validate();
      if (!isValid) {
        return;
      } else {
        try {
          var res = await http.post(
            Uri.parse(Api.deleteRfidBand),
            body: {
              'rfidBandID': arguments.rfid_band_id.toString(),
            },
          );
          if (res.statusCode == 200) {
            var resBodyOfLogin = jsonDecode(res.body);
            if (resBodyOfLogin['success']) {
              print(resBodyOfLogin);
              Fluttertoast.showToast(msg: "Rfid Band is Deleted");
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
}
