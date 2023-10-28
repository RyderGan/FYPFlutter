import 'package:fitnessapp/fitness_app/views/User/login_page.dart';
import 'package:fitnessapp/fitness_app/views/User/register_page.dart';
import 'package:fitnessapp/fitness_app/views/root_app.dart';
import 'package:get/get_navigation/src/routes/get_route.dart';

/// Routes name to directly navigate the route by its name
class Routes {
  static String login = '/login';
  static String register = '/register';
  static String root_app = '/root_app';
}

/// Add this list variable into your GetMaterialApp as the value of getPages parameter.
/// You can get the reference to the above GetMaterialApp code.
final getPages = [
  GetPage(
    name: Routes.login,
    page: () => const LoginPage(),
  ),
  GetPage(
    name: Routes.register,
    page: () => const RegisterPage(),
  ),
  GetPage(
    name: Routes.root_app,
    page: () => const RootApp(),
  ),
];
