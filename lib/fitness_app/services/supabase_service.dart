
import 'package:fitnessapp/fitness_app/models/User/userModel.dart';
import 'package:get/get.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class supabaseService {
  final supabase = Get.find<SupabaseClient>();

  void registerAccount(String email, String password, String name,
      String userType, String gender, String dob) async {
    var response = await supabase.auth.signUp(password: password, email: email);
    //add other infos
    await supabase.from('profiles').update({
      'full_name': name,
      'userType': userType,
      'gender': gender,
      'dateOfBirth': dob
    }).eq('id', response.user?.id);
  }

  Future<String?> checkEmailExist(String email) async {
    var response = await supabase
        .from('profiles')
        .select('email', const FetchOptions(count: CountOption.exact))
        .eq("email", email);
    print(response);
    return response.count;
  }

  void loginAccount(String email, String password, String userType) async {
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
    return null;
  }
}
