import 'package:fitnessapp/fitness_app/models/User/userModel.dart';
import 'package:get/get.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:uuid/uuid.dart';

class supabaseService {
  final supabase = Get.find<SupabaseClient>();

  void registerAccount(String email, String password) async {
// Create a map, let the key of the map be the name of the columns and value
// be the user input
    Map userData = {
//Uuuid().v1() generate uid for each data we add
      'id': const Uuid().v1(),
// name is key and the _nameController.text.trim() is the value from the user
      // 'username': name,
      'email': email,
      'password': password,
      // 'userType': userType,
      // 'gender': gender,
      // 'dateOfBirth': dob,
    };
// Always pass the name of the table in the *from* function. Our table name is
// Users so we passed the Users in the from function.
    await supabase.auth.signUp(password: password, email: email);
  }

  Future<UserModel?> checkEmailExist(String email) async {
    String userEmail;
    var response = await supabase
        .from('Users')
        .select('email')
        .eq("email", email)
        .single();
    if (response.statusCode == 200 && response != null) {
      var jsonString = response.body;
      return UserModel.fromJson(jsonString);
    } else {
      return response = null;
    }
  }

  void loginAccount(String email, String password, String userType) async {
    Map userData = {
      'email': email,
      'password': password,
    };

    await supabase.auth.signInWithPassword(email: email, password: password);
  }

  String? getCurrentUserID() {
    return supabase.auth.currentUser?.id;
  }

  Future<UserModel?> getLoginUserUuid(String email) async {
    var response = await supabase
        .from('auth.users')
        .select('User UID')
        .eq("auth.users.email", email)
        .single();
    if (response.statusCode == 200 && response != null) {
      var jsonString = response.body;
      return UserModel.fromJson(jsonString);
    }
  }
}
