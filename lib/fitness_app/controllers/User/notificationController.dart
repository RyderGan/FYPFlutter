import 'dart:convert';

import 'package:fitnessapp/fitness_app/models/User/notificationModel.dart';
import 'package:fitnessapp/fitness_app/preferences/current_user.dart';
import 'package:fitnessapp/fitness_app/services/api_connection.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class notificationController extends GetxController {
  List<NotificationModel> allNotifications = <NotificationModel>[].obs;
  CurrentUser _currentUser = Get.put(CurrentUser());

  @override
  void onInit() {
    getUserAllNotifications();
    super.onInit();
  }

  @override
  void onClose() {
    super.dispose();
  }

  void refreshList() {
    allNotifications.clear();
    getUserAllNotifications();
  }

  void addUserNotification(String msg) async {
    try {
      var res = await http.post(
        Uri.parse(Api.addNotification),
        body: {'userID': _currentUser.user.id.toString(), 'msg': msg},
      );

      if (res.statusCode == 200) {
        var resBodyOfLogin = jsonDecode(res.body);
        if (resBodyOfLogin['success']) {
          //Fluttertoast.showToast(msg: "Notification added.");
        } else {
          Fluttertoast.showToast(msg: "Error occurred");
        }
      }
    } catch (e) {
      print(e.toString());
      Fluttertoast.showToast(msg: e.toString());
    }
  }

  void getUserAllNotifications() async {
    try {
      var res = await http.post(
        Uri.parse(Api.getAllUserNotifications),
        body: {
          'userID': _currentUser.user.id.toString(),
        },
      );

      if (res.statusCode == 200) {
        var resBody = jsonDecode(res.body);
        if (resBody['success']) {
          List<NotificationModel> notifications =
              await resBody["allNotifications"]
                  .map<NotificationModel>(
                      (json) => NotificationModel.fromJson(json))
                  .toList();
          allNotifications.addAll(notifications);
        } else {
          List<NotificationModel> notifications = <NotificationModel>[];
          allNotifications.addAll(notifications);
        }
      }
    } catch (e) {
      print(e.toString());
      Fluttertoast.showToast(msg: e.toString());
    }
  }

  void markAsRead(int notifyID) async {
    try {
      var res = await http.post(
        Uri.parse(Api.markNotificationAsRead),
        body: {
          'userID': _currentUser.user.id.toString(),
          'notifyID': notifyID.toString(),
        },
      );

      if (res.statusCode == 200) {
        var resBody = jsonDecode(res.body);
        if (resBody['success']) {
          Fluttertoast.showToast(msg: "One notification is read.");
          //refresh page
          allNotifications.clear();
          getUserAllNotifications();
        } else {
          Fluttertoast.showToast(msg: resBody.toString());
        }
      }
    } catch (e) {
      print(e.toString());
      Fluttertoast.showToast(msg: e.toString());
    }
  }

  void unmarkAsRead(int notifyID) async {
    try {
      var res = await http.post(
        Uri.parse(Api.unmarkNotificationAsRead),
        body: {
          'userID': _currentUser.user.id.toString(),
          'notifyID': notifyID.toString(),
        },
      );

      if (res.statusCode == 200) {
        var resBody = jsonDecode(res.body);
        if (resBody['success']) {
          Fluttertoast.showToast(msg: "One notification is unread.");
          //refresh page
          allNotifications.clear();
          getUserAllNotifications();
        } else {
          Fluttertoast.showToast(msg: resBody.toString());
        }
      }
    } catch (e) {
      print(e.toString());
      Fluttertoast.showToast(msg: e.toString());
    }
  }

  void deleteUserNotification(int notifyID) async {
    var resultResponse = await Get.dialog(
      AlertDialog(
        backgroundColor: Colors.grey,
        title: Text(
          "Delete Notification",
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        content: Text(
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
          Uri.parse(Api.deleteOneNotification),
          body: {
            'userID': _currentUser.user.id.toString(),
            'notifyID': notifyID.toString(),
          },
        );

        if (res.statusCode == 200) {
          var resBody = jsonDecode(res.body);
          if (resBody['success']) {
            Fluttertoast.showToast(msg: "One notification deleted.");
            //refresh page
            allNotifications.clear();
            getUserAllNotifications();
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
