import 'dart:convert';
import 'package:fitnessapp/fitness_app/models/Admin/aboutUsModel.dart';
import 'package:fitnessapp/fitness_app/views/responsive_padding.dart';
import 'package:fitnessapp/routes.dart';
import 'package:fitnessapp/theme/colors.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:fitnessapp/fitness_app/services/api_connection.dart';
import 'package:http/http.dart' as http;

class SettingsFragmentScreen extends StatefulWidget {
  const SettingsFragmentScreen({Key? key}) : super(key: key);

  @override
  _SettingsFragmentScreenState createState() => _SettingsFragmentScreenState();
}

class _SettingsFragmentScreenState extends State<SettingsFragmentScreen> {
  AboutUsModel aboutUs =
      AboutUsModel(0, "", "", "", "", "", "", "", "", "", 0, 0);

  Future<AboutUsModel> getAboutUs() async {
    AboutUsModel newAboutUs =
        AboutUsModel(0, "", "", "", "", "", "", "", "", "", 0, 0);
    try {
      var res = await http.post(Uri.parse(Api.getAboutUs));
      var resBodyOfLogin = jsonDecode(res.body);
      if (resBodyOfLogin['success']) {
        List<AboutUsModel> aboutUsInfo = await resBodyOfLogin["aboutUs"]
            .map<AboutUsModel>((json) => AboutUsModel.fromJson(json))
            .toList();
        newAboutUs = aboutUsInfo[0];
      }
    } catch (e) {
      print(e.toString());
      Fluttertoast.showToast(msg: e.toString());
    }
    return newAboutUs;
  }

  @override
  void initState() {
    getAboutUs().then((value) => aboutUs = value);
    super.initState();
  }

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
              child: Column(
                children: [
                  userSettingsTitle(),
                  const SizedBox(
                    height: 15,
                  ),
                  changeUserInfoButton(),
                  const SizedBox(
                    height: 15,
                  ),
                  changeUserEmailPasswordButton(),
                  const SizedBox(
                    height: 45,
                  ),
                  aboutUsButton(),
                  const SizedBox(
                    height: 15,
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

  Container userSettingsTitle() {
    return Container(
      child: const Text(
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
      child: const Text('Change User info',
          style: TextStyle(fontSize: 20, color: Colors.white)),
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
      child: const Text('Change Email & Password',
          style: TextStyle(fontSize: 20, color: Colors.white)),
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
      child: const Text('About Us',
          style: TextStyle(fontSize: 20, color: Colors.white)),
      onPressed: () {
        Get.toNamed(Routes.about_us_user, arguments: aboutUs);
      },
    );
  }

  MaterialButton sendFeedbackButton() {
    return MaterialButton(
      minWidth: double.infinity,
      height: 50,
      color: fourthColor,
      child: const Text('Send Us Feedback',
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
