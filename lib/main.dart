
import 'package:fitnessapp/fitness_app/preferences/user_preferences.dart';
import 'package:fitnessapp/fitness_app/views/User/loading_page.dart';
import 'package:fitnessapp/routes.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:fitnessapp/fitness_app/views/User/login_page.dart';
import 'package:flutter/material.dart';

void main() {
  Get.put<GetStorage>(GetStorage());
  WidgetsFlutterBinding.ensureInitialized();
  //fix screen orientation
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]).then((value) => runApp(const MyApp()));
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'IoT Health Tracker',
      debugShowCheckedModeBanner: false,
      //initialRoute: Routes.login,
      home: FutureBuilder(
        future: RememberUserPrefs.readUserInfo(),
        builder: (context, snapshot) {
          if (snapshot.data == null) {
            return const LoginPage();
          } else {
            return const LoadingPage();
          }
        },
      ),
      getPages: getPages,
    );
  }
}

class HexColor extends Color {
  HexColor(final String hexColor) : super(_getColorFromHex(hexColor));

  static int _getColorFromHex(String hexColor) {
    hexColor = hexColor.toUpperCase().replaceAll('#', '');
    if (hexColor.length == 6) {
      hexColor = 'FF$hexColor';
    }
    return int.parse(hexColor, radix: 16);
  }
}
