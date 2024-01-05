import 'package:fitnessapp/fitness_app/controllers/Admin/adminHomeController.dart';
import 'package:fitnessapp/fitness_app/preferences/user_preferences.dart';
import 'package:fitnessapp/fitness_app/views/Admin/about_us_admin_page.dart';
import 'package:fitnessapp/fitness_app/views/Admin/app_info_page.dart';
import 'package:fitnessapp/fitness_app/views/Admin/checkpoint_list_page.dart';
import 'package:fitnessapp/fitness_app/views/Admin/feedback_page.dart';
import 'package:fitnessapp/fitness_app/views/Admin/path_list_page.dart';
import 'package:fitnessapp/fitness_app/views/Admin/rewards_list_page.dart';
import 'package:fitnessapp/fitness_app/views/Admin/rfid_band_list_page.dart';
import 'package:fitnessapp/fitness_app/views/Admin/user_list_page.dart';
import 'package:fitnessapp/fitness_app/views/User/drawer_header.dart';
import 'package:fitnessapp/fitness_app/views/Admin/admin_home_fragment_screen.dart';
import 'package:fitnessapp/routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AdminRootApp extends StatefulWidget {
  const AdminRootApp({Key? key}) : super(key: key);

  @override
  _AdminRootAppState createState() => _AdminRootAppState();
}

class _AdminRootAppState extends State<AdminRootApp> {
  final _adminHomeScreenController = Get.put(AdminHomeController());
  int pageIndex = 0;
  Widget appBarTitle = const Text("Admin Home");
  Icon settingIcon = const Icon(Icons.settings);
  DrawerSections currentPage = DrawerSections.home;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: getBody(),
    );
  }

  Widget getBody() {
    return GetBuilder(
      init: _adminHomeScreenController,
      initState: (currentState) {},
      builder: (controller) {
        late Widget container;
        if (currentPage == DrawerSections.home) {
          container = const AdminHomeFragmentScreen();
          appBarTitle = const Text("Admin Home");
        } else if (currentPage == DrawerSections.rfid_bands) {
          container = const RfidBandListPage();
          appBarTitle = const Text("RFID Bands");
        } else if (currentPage == DrawerSections.user_list) {
          container = const UserListPage();
          appBarTitle = const Text("User List");
        } else if (currentPage == DrawerSections.feedbacks) {
          container = const FeedbackPage();
          appBarTitle = const Text("Feedbacks");
        } else if (currentPage == DrawerSections.checkpoints) {
          container = const CheckpointListPage();
          appBarTitle = const Text("Checkpoints");
        } else if (currentPage == DrawerSections.roads) {
          container = const PathListPage();
          appBarTitle = const Text("Paths");
        } else if (currentPage == DrawerSections.rewards) {
          container = const RewardsListPage();
          appBarTitle = const Text("Rewards");
        } else if (currentPage == DrawerSections.about_us) {
          container = const AboutUsAdminPage();
          appBarTitle = const Text("About Us");
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
                  const HeaderDrawer(),
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
      padding: const EdgeInsets.only(top: 15),
      child: Column(
        children: [
          menuItem(1, "Admin Home", Icons.home,
              currentPage == DrawerSections.home ? true : false),
          menuItem(2, "RFID Bands", Icons.watch,
              currentPage == DrawerSections.rfid_bands ? true : false),
          menuItem(3, "User List", Icons.library_books,
              currentPage == DrawerSections.user_list ? true : false),
          menuItem(4, "Feedbacks", Icons.feedback,
              currentPage == DrawerSections.feedbacks ? true : false),
          menuItem(5, "Checkpoints", Icons.add_location,
              currentPage == DrawerSections.checkpoints ? true : false),
          menuItem(6, "Paths", Icons.streetview,
              currentPage == DrawerSections.roads ? true : false),
          menuItem(7, "Rewards", Icons.monetization_on,
              currentPage == DrawerSections.rewards ? true : false),
          menuItem(8, "App Info", Icons.question_mark,
              currentPage == DrawerSections.about_us ? true : false),
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
              currentPage = DrawerSections.rfid_bands;
            } else if (id == 3) {
              currentPage = DrawerSections.user_list;
            } else if (id == 4) {
              currentPage = DrawerSections.feedbacks;
            } else if (id == 5) {
              currentPage = DrawerSections.checkpoints;
            } else if (id == 6) {
              currentPage = DrawerSections.roads;
            } else if (id == 7) {
              currentPage = DrawerSections.rewards;
            } else if (id == 8) {
              currentPage = DrawerSections.about_us;
            }
          });
        },
        child: Padding(
          padding: const EdgeInsets.all(15),
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
                  style: const TextStyle(
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
        padding: const EdgeInsets.all(15),
        child: Column(
          children: [
            MaterialButton(
              minWidth: double.infinity,
              height: 35,
              color: const Color(0xFFFF5963),
              child: const Text('Sign Out',
                  style: TextStyle(fontSize: 16, color: Colors.white)),
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
        title: const Text(
          "Logout",
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        content: const Text(
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
  user_list,
  rfid_bands,
  feedbacks,
  checkpoints,
  roads,
  rewards,
  about_us,
}
