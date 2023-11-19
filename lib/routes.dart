import 'package:fitnessapp/fitness_app/views/User/about_us_page.dart';
import 'package:fitnessapp/fitness_app/views/User/blood_pressure_page.dart';
import 'package:fitnessapp/fitness_app/views/User/bmi_page.dart';
import 'package:fitnessapp/fitness_app/views/User/change_email_password_page.dart';
import 'package:fitnessapp/fitness_app/views/User/change_user_info_page.dart';
import 'package:fitnessapp/fitness_app/views/User/loading_page.dart';
import 'package:fitnessapp/fitness_app/views/User/login_page.dart';
import 'package:fitnessapp/fitness_app/views/User/register_page.dart';
import 'package:fitnessapp/fitness_app/views/User/reset_password_page.dart';
import 'package:fitnessapp/fitness_app/views/User/send_feedback_page.dart';
import 'package:fitnessapp/fitness_app/views/User/visceral_fat_page.dart';
import 'package:fitnessapp/fitness_app/views/root_app.dart';
import 'package:get/get_navigation/src/routes/get_route.dart';

/// Routes name to directly navigate the route by its name
class Routes {
  static String login = '/login';
  static String register = '/register';
  static String loading = '/loading';
  static String root_app = '/root_app';
  static String change_userLogin = '/change_userLogin';
  static String about_us = '/about_us';
  static String send_feedback = '/send_feedback';
  static String change_userInfo = '/change_userInfo';
  static String bmi_page = '/bmi_page';
  static String blood_pressure_page = '/bloodPressure_page';
  static String reset_password = '/reset_password';
  static String visceral_fat_page = '/visceralFat_page';
}

/// Add this list variable into your GetMaterialApp as the value of getPages parameter.
/// You can get the reference to the above GetMaterialApp code.
final getPages = [
  GetPage(
    name: Routes.login,
    page: () => const LoginPage(),
  ),
  GetPage(
    name: Routes.reset_password,
    page: () => const ResetPasswordPage(),
  ),
  GetPage(
    name: Routes.register,
    page: () => const RegisterPage(),
  ),
  GetPage(
    name: Routes.loading,
    page: () => const LoadingPage(),
  ),
  GetPage(
    name: Routes.root_app,
    page: () => const RootApp(),
  ),
  GetPage(
    name: Routes.change_userLogin,
    page: () => const ChangeEmailPasswordPage(),
  ),
  GetPage(
    name: Routes.about_us,
    page: () => const AboutUsPage(),
  ),
  GetPage(
    name: Routes.send_feedback,
    page: () => const SendFeedbackPage(),
  ),
  GetPage(
    name: Routes.change_userInfo,
    page: () => const ChangeUserInfoPage(),
  ),
  GetPage(
    name: Routes.bmi_page,
    page: () => const BmiPage(),
  ),
  GetPage(
    name: Routes.blood_pressure_page,
    page: () => const BloodPressurePage(),
  ),
  GetPage(
    name: Routes.visceral_fat_page,
    page: () => const VisceralFatPage(),
  ),
];
