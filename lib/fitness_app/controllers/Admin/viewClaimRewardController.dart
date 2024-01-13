import 'dart:convert';
import 'package:fitnessapp/fitness_app/preferences/current_user.dart';
import 'package:fitnessapp/fitness_app/services/api_connection.dart';
import 'package:fitnessapp/routes.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class viewClaimRewardController extends GetxController {
  GlobalKey<FormState> viewClaimRewardFormKey = GlobalKey<FormState>();
  late TextEditingController titleController,
      descriptionController,
      userNameController,
      userEmailController,
      statusController;
  var claimRewardID = 0;
  final CurrentUser _currentUser = Get.put(CurrentUser());

  @override
  void onInit() {
    super.onInit();
    titleController = TextEditingController();
    descriptionController = TextEditingController();
    userNameController = TextEditingController();
    userEmailController = TextEditingController();
    statusController = TextEditingController();
  }

  @override
  void onClose() {
    titleController.dispose();
    descriptionController.dispose();
    userNameController.dispose();
    userEmailController.dispose();
    statusController.dispose();
    super.dispose();
  }

  void setUserDetails(
      var claim_reward_arguments, var user_arguments, var reward_arguments) {
    titleController.text = reward_arguments.title;
    descriptionController.text = reward_arguments.description;
    userNameController.text = user_arguments.fullName;
    userEmailController.text = user_arguments.email;
    statusController.text = claim_reward_arguments.status;
    claimRewardID = claim_reward_arguments.id;
  }

  String? validateTitle(String value) {
    if (titleController.text.trim().isEmpty) {
      return "Please fill in title";
    }
    return null;
  }

  String? validateDescription(String value) {
    if (descriptionController.text.trim().isEmpty) {
      return "Please fill in title";
    }
    return null;
  }

  Future<void> deleteClaimReward() async {
    var resultResponse = await Get.dialog(
      AlertDialog(
        backgroundColor: Colors.grey,
        title: const Text(
          "Delete ClaimReward",
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
      try {
        // delete claimReward
        var res = await http.post(Uri.parse(Api.deleteClaimReward), body: {
          "claimRewardID": claimRewardID.toString(),
        });
        if (res.statusCode == 200) {
          var resBodyOfLogin = jsonDecode(res.body);
          if (resBodyOfLogin['success']) {
            Fluttertoast.showToast(msg: "ClaimReward Deleted!");
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

  Future<void> claimReward() async {
    var resultResponse = await Get.dialog(
      AlertDialog(
        backgroundColor: Colors.grey,
        title: const Text(
          "Claim Reward",
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
              Get.back(result: "claim");
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

    if (resultResponse == 'claim') {
      try {
        // delete claimReward
        var res = await http.post(Uri.parse(Api.adminClaimReward), body: {
          "claimRewardID": claimRewardID.toString(),
        });
        if (res.statusCode == 200) {
          var resBodyOfLogin = jsonDecode(res.body);
          if (resBodyOfLogin['success']) {
            Fluttertoast.showToast(msg: "Reward has been set to claimed!");
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
