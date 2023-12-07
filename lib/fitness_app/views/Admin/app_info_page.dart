import 'package:fitnessapp/fitness_app/views/responsive_padding.dart';
import 'package:fitnessapp/routes.dart';
import 'package:fitnessapp/theme/colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AppInfoFragmentScreen extends StatefulWidget {
  const AppInfoFragmentScreen({Key? key}) : super(key: key);

  @override
  _AppInfoFragmentScreenState createState() => _AppInfoFragmentScreenState();
}

class _AppInfoFragmentScreenState extends State<AppInfoFragmentScreen> {
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
                  userAppInfoTitle(),
                  const SizedBox(
                    height: 15,
                  ),
                  aboutUsButton(),
                  const SizedBox(
                    height: 20,
                  ),
                  sendFeedbackButton(),
                  const SizedBox(
                    height: 75,
                  ),
                  appInfo(),
                ],
              ),
            ),
          ));
    });
  }

  Container userAppInfoTitle() {
    return Container(
      child: const Text(
        "App Info Settings",
        style: TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.bold,
          color: primary,
        ),
      ),
    );
  }

  MaterialButton aboutUsButton() {
    return MaterialButton(
      minWidth: double.infinity,
      height: 50,
      color: secondary,
      child: const Text('About Us',
          style: TextStyle(fontSize: 20, color: Colors.white)),
      onPressed: () {
        Get.toNamed(Routes.about_us_admin);
      },
    );
  }

  MaterialButton sendFeedbackButton() {
    return MaterialButton(
      minWidth: double.infinity,
      height: 50,
      color: fourthColor,
      child: const Text('Change App Icon',
          style: TextStyle(fontSize: 20, color: Colors.white)),
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
        const Text("v 0.1"),
      ],
    ));
  }
}
