import 'package:fitnessapp/fitness_app/services/supabase_service.dart';
import 'package:fitnessapp/routes.dart';
import 'package:flutter/material.dart';
import 'package:fitnessapp/fitness_app/models/User/userModel.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class registerController extends GetxController {
  GlobalKey<FormState> registerFormKey = GlobalKey<FormState>();
  late TextEditingController nameController,
      emailController,
      passwordController,
      userTypeController,
      genderController,
      dobController;

  var name = '';
  var email = '';
  var password = '';
  var userType = '';
  var gender = '';
  var dob = '';
  var emailData = List<User>.empty().obs;

  @override
  void onInit() {
    super.onInit();
    nameController = TextEditingController();
    emailController = TextEditingController();
    passwordController = TextEditingController();
    userTypeController = TextEditingController();
    genderController = TextEditingController();
    dobController = TextEditingController();
  }

  @override
  void onClose() {
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    userTypeController.dispose();
    genderController.dispose();
    dobController.dispose();
  }

  String? validateEmail(String value) {
    if (!GetUtils.isEmail(value)) {
      return "Provide valid email";
    }
    // if (supabaseService().checkEmailExist(value) == value) {
    //   return "Email exists";
    // }
    return null;
  }

  // ? is nullable
  String? validatePassword(String value) {
    if (value.length < 6) {
      return "Password must be of 6 characters";
    }
    return null;
  }

  void registerAccount(String email, String password, String name,
      String userType, String gender, String dob) {
    // insert into database
    supabaseService()
        .registerAccount(email, password, name, userType, gender, dob);
    //navigate to login page
    Get.offAllNamed(Routes.login);
  }

  void checkRegister() {
    // ! is null check operator
    final isValid = registerFormKey.currentState!.validate();
    //var emailExist = supabaseService().checkEmailExist(email);

    if (!isValid) {
      return;
    }
    registerAccount(
        emailController.text,
        passwordController.text.trim(),
        nameController.text,
        userTypeController.text,
        genderController.text,
        dobController.text);
  }
}
