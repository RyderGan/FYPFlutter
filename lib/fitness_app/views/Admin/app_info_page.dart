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

class AppInfoFragmentScreen extends StatefulWidget {
  const AppInfoFragmentScreen({Key? key}) : super(key: key);

  @override
  _AppInfoFragmentScreenState createState() => _AppInfoFragmentScreenState();
}

class _AppInfoFragmentScreenState extends State<AppInfoFragmentScreen> {
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
                  sendNotificationButton(),
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
        Get.toNamed(Routes.about_us_admin, arguments: aboutUs);
      },
    );
  }

  MaterialButton sendNotificationButton() {
    return MaterialButton(
      minWidth: double.infinity,
      height: 50,
      color: fourthColor,
      child: const Text('Send Notification',
          style: TextStyle(fontSize: 20, color: Colors.white)),
      onPressed: () {
        Get.toNamed(Routes.send_notification);
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
