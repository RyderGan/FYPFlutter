import 'dart:convert';
import 'package:fitnessapp/fitness_app/services/api_connection.dart';
import 'package:fitnessapp/routes.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class EditAboutUsInfoController extends GetxController {
  GlobalKey<FormState> editAboutUsInfoFormKey = GlobalKey<FormState>();

  late TextEditingController titleController,
      whoController,
      whoDetailsController,
      aimController,
      aimDetailsController,
      websiteNameController,
      websiteLinkController,
      facebookLinkController,
      instagramLinkController,
      latController,
      longController;

  @override
  void onClose() {
    titleController.dispose();
    whoController.dispose();
    whoDetailsController.dispose();
    aimController.dispose();
    aimDetailsController.dispose();
    websiteNameController.dispose();
    websiteLinkController.dispose();
    facebookLinkController.dispose();
    instagramLinkController.dispose();
    latController.dispose();
    longController.dispose();
    super.dispose();
  }

  void setAboutUsDetails(var arguments) {
    titleController = TextEditingController();
    titleController.text = arguments.title;
    whoController = TextEditingController();
    whoController.text = arguments.who;
    whoDetailsController = TextEditingController();
    whoDetailsController.text = arguments.whoDetails;
    aimController = TextEditingController();
    aimController.text = arguments.aim;
    aimDetailsController = TextEditingController();
    aimDetailsController.text = arguments.aimDetails;
    websiteNameController = TextEditingController();
    websiteNameController.text = arguments.websiteName;
    websiteLinkController = TextEditingController();
    websiteLinkController.text = arguments.websiteLink;
    facebookLinkController = TextEditingController();
    facebookLinkController.text = arguments.facebookLink;
    instagramLinkController = TextEditingController();
    instagramLinkController.text = arguments.instagramLink;
    latController = TextEditingController();
    latController.text = arguments.lat.toString();
    longController = TextEditingController();
    longController.text = arguments.long.toString();
  }

  Future<void> updateAboutUsInfo(var arguments) async {
    // ! is null check operator
    final isValid = editAboutUsInfoFormKey.currentState!.validate();
    if (!isValid) {
      return;
    } else {
      try {
        var res = await http.post(
          Uri.parse(Api.updateAboutUsInfo),
          body: {
            "title": titleController.text.trim(),
            "who": whoController.text.trim(),
            "whoDetails": whoDetailsController.text.trim(),
            "aim": aimController.text.trim(),
            "aimDetails": aimDetailsController.text.trim(),
            "websiteName": websiteNameController.text.trim(),
            "websiteLink": websiteLinkController.text.trim(),
            "facebookLink": facebookLinkController.text.trim(),
            "instagramLink": instagramLinkController.text.trim(),
            "lat": latController.text.toString(),
            "long": longController.text.toString(),
            "about_us_id": arguments.about_us_id.toString(),
          },
        );
        print(res.statusCode);
        if (res.statusCode == 200) {
          var resBodyOfLogin = jsonDecode(res.body);
          if (resBodyOfLogin['success']) {
            print(resBodyOfLogin);
            Fluttertoast.showToast(msg: "The About Us info has been updated.");
            //change aboutUs info to local storage using Shared Preferences
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
