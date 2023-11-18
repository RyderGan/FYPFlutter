import 'dart:convert';

import 'package:fitnessapp/fitness_app/models/User/bmiModel.dart';
import 'package:fitnessapp/fitness_app/preferences/current_user.dart';
import 'package:fitnessapp/fitness_app/services/api_connection.dart';
import 'package:fitnessapp/routes.dart';
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

  CurrentUser _currentUser = Get.put(CurrentUser());
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
            Get.offNamedUntil(
                Routes.bmi_page, ModalRoute.withName('/root_app'));
            //Get.offNamed(Routes.bmi_page);
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
    print(bmiID);
    print(updateWeightController.text.toString());
    print(updateHeightController.text.toString());
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
            Fluttertoast.showToast(msg: "Your bmi info updated.");
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
          Get.offNamedUntil(Routes.bmi_page, ModalRoute.withName('/root_app'));
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
