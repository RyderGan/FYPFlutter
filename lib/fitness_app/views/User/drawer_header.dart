import 'dart:convert';

import 'package:fitnessapp/fitness_app/models/Admin/aboutUsModel.dart';
import 'package:fitnessapp/fitness_app/preferences/current_user.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:fitnessapp/fitness_app/services/api_connection.dart';
import 'package:http/http.dart' as http;

class HeaderDrawer extends StatefulWidget {
  const HeaderDrawer({super.key});

  @override
  _HeaderDrawerState createState() => _HeaderDrawerState();
}

class _HeaderDrawerState extends State<HeaderDrawer> {
  final CurrentUser _currentUser = Get.put(CurrentUser());
  AboutUsModel aboutUs =
      AboutUsModel(0, "", "", "", "", "", "", "", "", "", 0, 0);

  Future getAboutUs() async {
    try {
      var res = await http.post(Uri.parse(Api.getAboutUs));
      var resBodyOfLogin = jsonDecode(res.body);
      if (resBodyOfLogin['success']) {
        List<AboutUsModel> aboutUsInfo = await resBodyOfLogin["aboutUs"]
            .map<AboutUsModel>((json) => AboutUsModel.fromJson(json))
            .toList();
        aboutUs = aboutUsInfo[0];
      }
    } catch (e) {
      print(e.toString());
      Fluttertoast.showToast(msg: e.toString());
    }
  }
  //methods

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: Future.wait([getAboutUs()]),
        builder: (context, constraints) {
          return Container(
            color: Colors.blue,
            width: double.infinity,
            height: 200,
            padding: const EdgeInsets.only(top: 20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  margin: const EdgeInsets.only(bottom: 10),
                  height: 70,
                  decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      image: DecorationImage(
                          image: AssetImage('assets/icons/profile_icon.jpg'))),
                ),
                Text(
                  _currentUser.user.fullName,
                  style: const TextStyle(color: Colors.white, fontSize: 20),
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  aboutUs.who,
                  style: TextStyle(color: Colors.grey[200], fontSize: 14),
                  textAlign: TextAlign.center,
                )
              ],
            ),
          );
        });
  }
}
