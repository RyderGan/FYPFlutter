import 'dart:convert';
import 'package:fitnessapp/fitness_app/models/User/visceralFatModel.dart';
import 'package:fitnessapp/fitness_app/preferences/current_user.dart';
import 'package:fitnessapp/fitness_app/services/api_connection.dart';
import 'package:fitnessapp/routes.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class visceralFatController extends GetxController {
  GlobalKey<FormState> addNewVisceralFatFormKey = GlobalKey<FormState>();
  GlobalKey<FormState> editVisceralFatFormKey = GlobalKey<FormState>();

  late TextEditingController ratingController, updateRatingController;
  //Map<String, TextEditingController> bmiEditingControllers = {};

  CurrentUser _currentUser = Get.put(CurrentUser());
  List<VisceralFatModel> allVisceralFats = <VisceralFatModel>[].obs;

  @override
  void onInit() {
    super.onInit();
    getUserAllVisceralFat();
    ratingController = TextEditingController();
    updateRatingController = TextEditingController();
  }

  @override
  void onClose() {
    ratingController.dispose();
    updateRatingController.dispose();
  }

  void clearFormContents() {
    ratingController.clear();
    updateRatingController.clear();
  }

  void addNewVisceralFat() async {
    final isValid = addNewVisceralFatFormKey.currentState!.validate();
    if (!isValid) {
      return;
    } else {
      try {
        var res = await http.post(
          Uri.parse(Api.addNewVisceralFat),
          body: {
            'userID': _currentUser.user.id.toString(),
            'rating': ratingController.text.trim().toString(),
          },
        );

        if (res.statusCode == 200) {
          var resBody = jsonDecode(res.body);
          if (resBody['success']) {
            Fluttertoast.showToast(msg: "One Visceral Fat added.");
            //refresh page
            clearFormContents();
            allVisceralFats.clear();
            getUserAllVisceralFat();
          } else {
            Fluttertoast.showToast(msg: resBody.toString());
          }
        }
      } catch (e) {
        print(e.toString());
        Fluttertoast.showToast(msg: e.toString());
      }
    }
  }

  void getUserAllVisceralFat() async {
    try {
      var res = await http.post(
        Uri.parse(Api.getUserAllVisceralFat),
        body: {
          'userID': _currentUser.user.id.toString(),
        },
      );

      if (res.statusCode == 200) {
        var resBody = jsonDecode(res.body);
        if (resBody['success']) {
          List<VisceralFatModel> visceralFats = await resBody["allVfData"]
              .map<VisceralFatModel>((json) => VisceralFatModel.fromJson(json))
              .toList();
          allVisceralFats.addAll(visceralFats);
        } else {
          List<VisceralFatModel> visceralFats = <VisceralFatModel>[];
          allVisceralFats.addAll(visceralFats);
        }
      }
    } catch (e) {
      print(e.toString());
      Fluttertoast.showToast(msg: e.toString());
    }
  }

  void updateUserVisceralFat(int vfID) async {
    // ! is null check operator
    final isValid = editVisceralFatFormKey.currentState!.validate();
    if (!isValid) {
      return;
    } else {
      try {
        var res = await http.post(
          Uri.parse(Api.updateVisceralFat),
          body: {
            'rating': updateRatingController.text.trim().toString(),
            'vfID': vfID.toString(),
          },
        );

        if (res.statusCode == 200) {
          var resBody = jsonDecode(res.body);
          if (resBody['success']) {
            Fluttertoast.showToast(msg: "Your visceral fat info updated.");
            //refresh page
            clearFormContents();
            allVisceralFats.clear();
            getUserAllVisceralFat();
          } else {
            Fluttertoast.showToast(msg: resBody.toString());
          }
        }
      } catch (e) {
        print(e.toString());
        Fluttertoast.showToast(msg: e.toString());
      }
    }
  }

  void deleteUserVisceralFat(int vfID) async {
    try {
      var res = await http.post(
        Uri.parse(Api.deleteUserVisceralFat),
        body: {
          'userID': _currentUser.user.id.toString(),
          'vfID': vfID.toString(),
        },
      );

      if (res.statusCode == 200) {
        var resBody = jsonDecode(res.body);
        if (resBody['success']) {
          Fluttertoast.showToast(msg: "One Visceral Fat deleted.");
          Get.offNamedUntil(
              Routes.blood_pressure_page, ModalRoute.withName('/root_app'));
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
