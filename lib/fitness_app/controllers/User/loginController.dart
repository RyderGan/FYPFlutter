import 'package:fitnessapp/fitness_app/services/supabase_service.dart';
import 'package:fitnessapp/routes.dart';
import 'package:fitnessapp/sessionManager.dart';
import 'package:flutter/material.dart';
import 'package:fitnessapp/fitness_app/models/User/userModel.dart';
import 'package:fitnessapp/fitness_app/views/User/register_page.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class loginController extends GetxController {
  final GlobalKey<FormState> loginFormKey = GlobalKey<FormState>();
  late TextEditingController emailController,
      passwordController,
      userTypeController;

  var email = '';
  var password = '';
  var userType = '';

  @override
  void onInit() {
    super.onInit();
    emailController = TextEditingController();
    passwordController = TextEditingController();
    userTypeController = TextEditingController();
  }

  @override
  void onClose() {
    emailController.dispose();
    passwordController.dispose();
    userTypeController.dispose();
  }

  String? validateEmail(String value) {
    if (!GetUtils.isEmail(value)) {
      return "Provide valid email";
    }
    return null;
  }

  // ? is nullable
  String? validatePassword(String value) {
    if (value.length < 6) {
      return "Password must be of 6 characters";
    }
    return null;
  }

  void loginAccount(String email, String password, String userType) {
    // insert into database
    supabaseService().loginAccount(email, password, userType);
    //navigate to home page
    Get.offAndToNamed(Routes.root_app);
  }

  void checkLogin() {
    // ! is null check operator
    final isValid = loginFormKey.currentState!.validate();
    if (!isValid) {
      return;
    }
    // ! is null check operator
    loginFormKey.currentState!.save();
    loginAccount(
        emailController.text, passwordController.text, userTypeController.text);
  }
}
