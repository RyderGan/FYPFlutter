import 'package:fitnessapp/fitness_app/preferences/current_user.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HeaderDrawer extends StatefulWidget {
  const HeaderDrawer({super.key});

  @override
  _HeaderDrawerState createState() => _HeaderDrawerState();
}

class _HeaderDrawerState extends State<HeaderDrawer> {
  final CurrentUser _currentUser = Get.put(CurrentUser());

  //methods

  @override
  Widget build(BuildContext context) {
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
            _currentUser.user.email,
            style: TextStyle(color: Colors.grey[200], fontSize: 14),
          )
        ],
      ),
    );
  }
}
