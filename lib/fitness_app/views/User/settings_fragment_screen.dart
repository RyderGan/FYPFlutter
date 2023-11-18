import 'package:fitnessapp/fitness_app/preferences/current_user.dart';
import 'package:fitnessapp/fitness_app/views/responsive_padding.dart';
import 'package:fitnessapp/routes.dart';
import 'package:fitnessapp/theme/colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SettingsFragmentScreen extends StatefulWidget {
  const SettingsFragmentScreen({Key? key}) : super(key: key);

  @override
  _SettingsFragmentScreenState createState() => _SettingsFragmentScreenState();
}

class _SettingsFragmentScreenState extends State<SettingsFragmentScreen> {
  CurrentUser _currentUser = Get.put(CurrentUser());

  @override
  Widget build(BuildContext context) {
    return ResponsivePadding(
      child: Scaffold(
        backgroundColor: white,
        body: SafeArea(child: getBody()),
      ),
    );
  }

  Widget getBody() {
    return LayoutBuilder(builder: (context, constraints) {
      return ConstrainedBox(
          constraints: BoxConstraints(
            minHeight: constraints.maxHeight,
          ),
          child: SingleChildScrollView(
            child: Container(
              padding: const EdgeInsets.all(20),
              height: MediaQuery.of(context).size.height,
              child: Column(
                children: [
                  userSettingsTitle(),
                  SizedBox(
                    height: 15,
                  ),
                  changeUserInfoButton(),
                  SizedBox(
                    height: 15,
                  ),
                  changeUserEmailPasswordButton(),
                  SizedBox(
                    height: 45,
                  ),
                  aboutUsButton(),
                  SizedBox(
                    height: 15,
                  ),
                  sendFeedbackButton(),
                  SizedBox(
                    height: 75,
                  ),
                  appInfo(),
                ],
              ),
            ),
          ));
    });
  }

  Container userSettingsTitle() {
    return Container(
      child: Text(
        "User Settings",
        style: TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.bold,
          color: primary,
        ),
      ),
    );
  }

  MaterialButton changeUserInfoButton() {
    return MaterialButton(
      minWidth: double.infinity,
      height: 50,
      color: primary,
      child: new Text('Change User info',
          style: new TextStyle(fontSize: 20, color: Colors.white)),
      onPressed: () {
        Get.toNamed(Routes.change_userInfo);
      },
    );
  }

  MaterialButton changeUserEmailPasswordButton() {
    return MaterialButton(
      minWidth: double.infinity,
      height: 50,
      color: primary,
      child: new Text('Change Email & Password',
          style: new TextStyle(fontSize: 20, color: Colors.white)),
      onPressed: () {
        Get.toNamed(Routes.change_userLogin);
      },
    );
  }

  MaterialButton aboutUsButton() {
    return MaterialButton(
      minWidth: double.infinity,
      height: 50,
      color: secondary,
      child: new Text('About Us',
          style: new TextStyle(fontSize: 20, color: Colors.white)),
      onPressed: () {
        Get.toNamed(Routes.about_us);
      },
    );
  }

  MaterialButton sendFeedbackButton() {
    return MaterialButton(
      minWidth: double.infinity,
      height: 50,
      color: fourthColor,
      child: new Text('Send Us Feedback',
          style: new TextStyle(fontSize: 20, color: Colors.white)),
      onPressed: () {
        Get.toNamed(Routes.send_feedback);
      },
    );
  }

  Container appInfo() {
    return Container(
        child: Column(
      children: [
        Image.asset(
          "assets/fitness_app/step-count.png",
          height: 100,
          width: 100,
          fit: BoxFit.contain,
        ),
        Text("v 0.1"),
      ],
    ));
  }
}
