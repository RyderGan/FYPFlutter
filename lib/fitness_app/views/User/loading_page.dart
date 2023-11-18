import 'package:fitnessapp/fitness_app/preferences/current_user.dart';
import 'package:fitnessapp/fitness_app/preferences/user_preferences.dart';
import 'package:fitnessapp/fitness_app/views/User/drawer_header.dart';
import 'package:fitnessapp/fitness_app/views/User/home_fragment_screen.dart';
import 'package:fitnessapp/fitness_app/views/User/notification_fragment_screen.dart';
import 'package:fitnessapp/fitness_app/views/User/rankings_fragment_screen.dart';
import 'package:fitnessapp/fitness_app/views/User/rewards_fragment_screen.dart';
import 'package:fitnessapp/fitness_app/views/User/scan_qr_fragment_screen.dart';
import 'package:fitnessapp/fitness_app/views/User/settings_fragment_screen.dart';
import 'package:fitnessapp/routes.dart';
import 'package:fitnessapp/theme/colors.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:line_icons/line_icons.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoadingPage extends StatefulWidget {
  const LoadingPage({Key? key}) : super(key: key);

  @override
  _LoadingPageState createState() => _LoadingPageState();
}

class _LoadingPageState extends State<LoadingPage> {
  CurrentUser _currentUser = Get.put(CurrentUser());

  @override
  void initState() {
    super.initState();
  }

  loadPage() {
    getUserStatus().then((userStatus) {
      if (userStatus == null) {
        Fluttertoast.showToast(msg: "User not found");
      } else {
        Get.offAllNamed(Routes.root_app);
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
            title: Text("Loading"),
          ),
          backgroundColor: Colors.white,
          body: Container(
              child: Center(
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
