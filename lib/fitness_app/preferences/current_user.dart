import 'package:fitnessapp/fitness_app/models/User/userModel.dart';
import 'package:fitnessapp/fitness_app/preferences/user_preferences.dart';
import 'package:get/get.dart';

class CurrentUser extends GetxController {
  Rx<UserModel> _currentUser = UserModel(0, '', '', '', '', '', '', '').obs;

  UserModel get user => _currentUser.value;

  getUserInfo() async {
    UserModel? getUserInfoFromLocalStorage =
        await RememberUserPrefs.readUserInfo();
    _currentUser.value = getUserInfoFromLocalStorage!;
  }
}
