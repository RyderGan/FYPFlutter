import 'dart:convert';
import 'package:fitnessapp/fitness_app/models/User/userModel.dart';
import 'package:fitnessapp/fitness_app/services/api_connection.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class studentRankingsController extends GetxController {
  List<UserModel> allStudents = <UserModel>[].obs;

  @override
  void onInit() {
    super.onInit();
    getStudentRanking();
  }

  @override
  void onClose() {
    allStudents.clear();
    super.dispose();
  }

  void getStudentRanking() async {
    try {
      var res = await http.get(
        Uri.parse(Api.getStudentRanking),
      );

      if (res.statusCode == 200) {
        var resBodyOfLogin = jsonDecode(res.body);
        if (resBodyOfLogin['success']) {
          List<UserModel> students = await resBodyOfLogin["studentRankingData"]
              .map<UserModel>((json) => UserModel.fromJson(json))
              .toList();
          allStudents.addAll(students);
        } else {
          List<UserModel> students = <UserModel>[];
          allStudents.addAll(students);
        }
      }
    } catch (e) {
      print(e.toString());
      Fluttertoast.showToast(msg: e.toString());
    }
  }
}
