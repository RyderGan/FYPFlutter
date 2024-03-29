import 'dart:convert';

import 'package:fitnessapp/fitness_app/models/User/bmiModel.dart';
import 'package:fitnessapp/fitness_app/preferences/current_user.dart';
import 'package:fitnessapp/fitness_app/services/api_connection.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class bmiController extends GetxController {
  GlobalKey<FormState> addNewBmiFormKey = GlobalKey<FormState>();
  GlobalKey<FormState> editBmiFormKey = GlobalKey<FormState>();

  late final TextEditingController weightController,
      heightController,
      updateWeightController,
      updateHeightController;
  //Map<String, TextEditingController> bmiEditingControllers = {};

  final CurrentUser _currentUser = Get.put(CurrentUser());
  List<BmiModel> allBmis = <BmiModel>[].obs;

  @override
  void onInit() {
    super.onInit();
    getUserAllBmi();
    weightController = TextEditingController();
    heightController = TextEditingController();
    updateWeightController = TextEditingController();
    updateHeightController = TextEditingController();
    //initialize dynamic Controllers
    // for (var i = 0; i < allBmis.length - 1; i++) {
    //   var textEditingController = new TextEditingController();
    //   bmiEditingControllers.putIfAbsent(
    //       allBmis[i].bmiID.toString(), () => textEditingController);
    // }
  }

  @override
  void onClose() {
    weightController.dispose();
    heightController.dispose();
    updateWeightController.dispose();
    updateHeightController.dispose();
    allBmis.clear();
    super.dispose();
  }

  void clearFormContents() {
    weightController.clear();
    heightController.clear();
    updateWeightController.clear();
    updateHeightController.clear();
  }

  void addNewBmi() async {
    final isValid = addNewBmiFormKey.currentState!.validate();
    if (!isValid) {
      return;
    } else {
      try {
        var res = await http.post(
          Uri.parse(Api.addNewBmi),
          body: {
            'userID': _currentUser.user.id.toString(),
            'weight': weightController.text.trim().toString(),
            'height': heightController.text.trim().toString(),
          },
        );

        if (res.statusCode == 200) {
          var resBodyOfLogin = jsonDecode(res.body);
          if (resBodyOfLogin['success']) {
            Fluttertoast.showToast(msg: "One Bmi added.");
            //refresh page
            clearFormContents();
            allBmis.clear();
            getUserAllBmi();
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

  void getUserAllBmi() async {
    try {
      var res = await http.post(
        Uri.parse(Api.getUserAllBmi),
        body: {
          'userID': _currentUser.user.id.toString(),
        },
      );

      if (res.statusCode == 200) {
        var resBodyOfLogin = jsonDecode(res.body);
        if (resBodyOfLogin['success']) {
          List<BmiModel> bmis = await resBodyOfLogin["allBmiData"]
              .map<BmiModel>((json) => BmiModel.fromJson(json))
              .toList();
          allBmis.addAll(bmis);
        } else {
          List<BmiModel> bmis = <BmiModel>[];
          allBmis.addAll(bmis);
        }
      }
    } catch (e) {
      print(e.toString());
      Fluttertoast.showToast(msg: e.toString());
    }
  }

  void updateUserBmi(int bmiID) async {
    // ! is null check operator
    final isValid = editBmiFormKey.currentState!.validate();
    if (!isValid) {
      return;
    } else {
      try {
        var res = await http.post(
          Uri.parse(Api.updateBmi),
          body: {
            'update_bmiID': bmiID.toString(),
            'update_weight': updateWeightController.text.toString(),
            'update_height': updateHeightController.text.toString(),
          },
        );

        if (res.statusCode == 200) {
          var resBodyOfLogin = jsonDecode(res.body);
          if (resBodyOfLogin['success']) {
            Fluttertoast.showToast(msg: "Your bmi info has been updated.");
            //refresh page
            clearFormContents();
            allBmis.clear();
            getUserAllBmi();
            // Get.offNamedUntil(
            //     Routes.bmi_page, ModalRoute.withName('/root_app'));
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

  void deleteUserBmi(int bmiID) async {
    var resultResponse = await Get.dialog(
      AlertDialog(
        backgroundColor: Colors.grey,
        title: const Text(
          "Delete BMI",
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
              Get.back(result: "deleted");
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

    if (resultResponse == 'deleted') {
      try {
        var res = await http.post(
          Uri.parse(Api.deleteUserBmi),
          body: {
            'userID': _currentUser.user.id.toString(),
            'bmiID': bmiID.toString(),
          },
        );

        if (res.statusCode == 200) {
          var resBodyOfLogin = jsonDecode(res.body);
          if (resBodyOfLogin['success']) {
            Fluttertoast.showToast(msg: "One Bmi deleted.");
            //refresh page
            clearFormContents();
            allBmis.clear();
            getUserAllBmi();
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
