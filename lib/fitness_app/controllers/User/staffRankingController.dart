import 'dart:convert';
import 'package:fitnessapp/fitness_app/models/User/userModel.dart';
import 'package:fitnessapp/fitness_app/services/api_connection.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class staffRankingsController extends GetxController {
  List<UserModel> allStaffs = <UserModel>[].obs;

  @override
  void onInit() {
    super.onInit();
    getStaffRanking();
  }

  @override
  void onClose() {
    allStaffs.clear();
    super.dispose();
  }

  void getStaffRanking() async {
    try {
      var res = await http.get(
        Uri.parse(Api.getStaffRanking),
      );

      if (res.statusCode == 200) {
        var resBodyOfLogin = jsonDecode(res.body);
        if (resBodyOfLogin['success']) {
          List<UserModel> staffs = await resBodyOfLogin["staffRankingData"]
              .map<UserModel>((json) => UserModel.fromJson(json))
              .toList();
          allStaffs.addAll(staffs);
        } else {
          List<UserModel> staffs = <UserModel>[];
          allStaffs.addAll(staffs);
        }
      }
    } catch (e) {
      print(e.toString());
      Fluttertoast.showToast(msg: e.toString());
    }
  }
}
