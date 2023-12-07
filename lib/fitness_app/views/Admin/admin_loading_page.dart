import 'package:fitnessapp/fitness_app/preferences/current_user.dart';
import 'package:fitnessapp/routes.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AdminLoadingPage extends StatefulWidget {
  const AdminLoadingPage({Key? key}) : super(key: key);

  @override
  _AdminLoadingPageState createState() => _AdminLoadingPageState();
}

class _AdminLoadingPageState extends State<AdminLoadingPage> {
  final CurrentUser _currentUser = Get.put(CurrentUser());

  @override
  void initState() {
    super.initState();
  }

  loadPage() {
    getUserStatus().then((userStatus) {
      if (userStatus == null) {
        Fluttertoast.showToast(msg: "User not found");
      } else if (_currentUser.user.userType == 'Admin') {
        Get.offAllNamed(Routes.admin_root_app);
      } else {
        Get.offAllNamed(Routes.loading);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: getBody(),
    );
  }

  Widget getBody() {
    return GetBuilder(
      init: CurrentUser(),
      initState: (currentState) {
        _currentUser.getUserInfo();
        loadPage();
      },
      builder: (controller) {
        return Scaffold(
          appBar: AppBar(
            centerTitle: true,
            title: const Text("Loading"),
          ),
          backgroundColor: Colors.white,
          body: Container(
              child: const Center(
            child: CircularProgressIndicator(),
          )),
        );
      },
    );
  }

  Future<String?> getUserStatus() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? userStatus = prefs.getString("currentUser");
    print("==On Load Check ==");
    print(userStatus);
    return userStatus;
  }
}
