import 'package:fitnessapp/fitness_app/controllers/User/homeController.dart';
import 'package:fitnessapp/fitness_app/preferences/user_preferences.dart';
import 'package:fitnessapp/fitness_app/views/User/drawer_header.dart';
import 'package:fitnessapp/fitness_app/views/User/home_fragment_screen.dart';
import 'package:fitnessapp/fitness_app/views/User/notification_fragment_screen.dart';
import 'package:fitnessapp/fitness_app/views/User/rankings_fragment_screen.dart';
import 'package:fitnessapp/fitness_app/views/User/rewards_fragment_screen.dart';
import 'package:fitnessapp/fitness_app/views/User/scan_qr_fragment_screen.dart';
import 'package:fitnessapp/fitness_app/views/User/settings_fragment_screen.dart';
import 'package:fitnessapp/routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RootApp extends StatefulWidget {
  const RootApp({Key? key}) : super(key: key);

  @override
  _RootAppState createState() => _RootAppState();
}

class _RootAppState extends State<RootApp> {
  int pageIndex = 0;
  Widget appBarTitle = Text("Home");
  Icon settingIcon = new Icon(Icons.settings);
  var currentPage = DrawerSections.home;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: getBody(),
    );
  }

  Widget getBody() {
    return GetBuilder(
      init: homeController(),
      initState: (currentState) {},
      builder: (controller) {
        var container;
        if (currentPage == DrawerSections.home) {
          container = HomeFragmentScreen();
          appBarTitle = Text("Home");
        } else if (currentPage == DrawerSections.notifications) {
          container = NotificationFragmentScreen();
          appBarTitle = Text("Notifications");
        } else if (currentPage == DrawerSections.rankings) {
          container = RankingsFragmentScreen();
          appBarTitle = Text("Rankings");
        } else if (currentPage == DrawerSections.scan_qr) {
          container = ScanQRFragmentScreen();
          appBarTitle = Text("Scan QR code");
        } else if (currentPage == DrawerSections.rewards) {
          container = RewardsFragmentScreen();
          appBarTitle = Text("Rewards");
        } else if (currentPage == DrawerSections.settings) {
          container = SettingsFragmentScreen();
          appBarTitle = Text("Settings");
        }
        return Scaffold(
          appBar: AppBar(
            centerTitle: true,
            title: appBarTitle,
          ),
          backgroundColor: Colors.white,
          body: container,
          drawer: Drawer(
            child: SingleChildScrollView(
              child: Container(
                child: Column(children: [
                  HeaderDrawer(),
                  DrawerList(),
                  signOutButton(),
                ]),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget DrawerList() {
    return Container(
      padding: EdgeInsets.only(top: 15),
      child: Column(
        children: [
          menuItem(1, "Home", Icons.home,
              currentPage == DrawerSections.home ? true : false),
          menuItem(2, "Notifications", Icons.notifications,
              currentPage == DrawerSections.notifications ? true : false),
          menuItem(3, "Rankings", Icons.scoreboard,
              currentPage == DrawerSections.rankings ? true : false),
          menuItem(4, "Scan QR code", Icons.qr_code,
              currentPage == DrawerSections.scan_qr ? true : false),
          menuItem(5, "Rewards", Icons.monetization_on,
              currentPage == DrawerSections.rewards ? true : false),
          menuItem(6, "Settings", Icons.settings,
              currentPage == DrawerSections.settings ? true : false),
        ],
      ),
    );
  }

  Widget menuItem(int id, String title, IconData icon, bool selected) {
    return Material(
      color: selected ? Colors.grey[300] : Colors.transparent,
      child: InkWell(
        onTap: () {
          Get.back();
          setState(() {
            if (id == 1) {
              currentPage = DrawerSections.home;
            } else if (id == 2) {
              currentPage = DrawerSections.notifications;
            } else if (id == 3) {
              currentPage = DrawerSections.rankings;
            } else if (id == 4) {
              currentPage = DrawerSections.scan_qr;
            } else if (id == 5) {
              currentPage = DrawerSections.rewards;
            } else if (id == 6) {
              currentPage = DrawerSections.settings;
            }
          });
        },
        child: Padding(
          padding: EdgeInsets.all(15),
          child: Row(
            children: [
              Expanded(
                child: Icon(
                  icon,
                  size: 20,
                  color: Colors.black,
                ),
              ),
              Expanded(
                flex: 3,
                child: Text(
                  title,
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget signOutButton() {
    return Container(
      child: Padding(
        padding: EdgeInsets.all(15),
        child: Column(
          children: [
            MaterialButton(
              minWidth: double.infinity,
              height: 35,
              color: Color(0xFFFF5963),
              child: new Text('Sign Out',
                  style: new TextStyle(fontSize: 16, color: Colors.white)),
              onPressed: () {
                signOutUser();
              },
            ),
          ],
        ),
      ),
    );
  }

  signOutUser() async {
    var resultResponse = await Get.dialog(
      AlertDialog(
        backgroundColor: Colors.grey,
        title: Text(
          "Logout",
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        content: Text(
          "Are you sure?\nThis will log you out from app.",
        ),
        actions: [
          TextButton(
            onPressed: () {
              Get.back(result: "loggedOut");
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

    if (resultResponse == 'loggedOut') {
      //delete user data from local storage
      RememberUserPrefs.removeUserInfo().then((value) {
        Get.offAllNamed(Routes.login);
      });
    }
  }
}

enum DrawerSections {
  home,
  notifications,
  rankings,
  scan_qr,
  rewards,
  settings,
}
