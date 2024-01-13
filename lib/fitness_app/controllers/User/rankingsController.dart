import 'dart:convert';
import 'package:fitnessapp/fitness_app/models/User/userModel.dart';
import 'package:fitnessapp/fitness_app/services/api_connection.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class rankingsController extends GetxController {
  Rx<UserModel> firstStaff = UserModel(0, '', '', '', '', '', '', 0, '').obs;
  Rx<UserModel> secondStaff = UserModel(0, '', '', '', '', '', '', 0, '').obs;
  Rx<UserModel> thirdStaff = UserModel(0, '', '', '', '', '', '', 0, '').obs;
  Rx<UserModel> firstStudent = UserModel(0, '', '', '', '', '', '', 0, '').obs;
  Rx<UserModel> secondStudent = UserModel(0, '', '', '', '', '', '', 0, '').obs;
  Rx<UserModel> thirdStudent = UserModel(0, '', '', '', '', '', '', 0, '').obs;

  @override
  void onInit() {
    super.onInit();
    getTopFirstStaff();
    getTopFirstStudent();
    getTopSecondStaff();
    getTopSecondStudent();
    getTopThirdStaff();
    getTopThirdStudent();
  }

  @override
  void onClose() {
    super.dispose();
  }

  void refreshList() {
    getTopFirstStaff();
    getTopFirstStudent();
    getTopSecondStaff();
    getTopSecondStudent();
    getTopThirdStaff();
    getTopThirdStudent();
  }

  void getTopFirstStaff() async {
    try {
      var res = await http.get(
        Uri.parse(Api.getTopFirstStaff),
      );

      if (res.statusCode == 200) {
        var resBody = jsonDecode(res.body);
        if (resBody['success']) {
          UserModel userInfo = UserModel.fromJson(resBody["firstStaffData"]);
          firstStaff.value = userInfo;
        } else {
          Fluttertoast.showToast(msg: resBody.toString());
        }
      }
    } catch (e) {
      print(e.toString());
      Fluttertoast.showToast(msg: e.toString());
    }
  }

  void getTopSecondStaff() async {
    try {
      var res = await http.get(
        Uri.parse(Api.getTopSecondStaff),
      );

      if (res.statusCode == 200) {
        var resBody = jsonDecode(res.body);
        if (resBody['success']) {
          UserModel userInfo = UserModel.fromJson(resBody["secondStaffData"]);
          secondStaff.value = userInfo;
        } else {
          Fluttertoast.showToast(msg: resBody.toString());
        }
      }
    } catch (e) {
      print(e.toString());
      Fluttertoast.showToast(msg: e.toString());
    }
  }

  void getTopThirdStaff() async {
    try {
      var res = await http.get(
        Uri.parse(Api.getTopThirdStaff),
      );

      if (res.statusCode == 200) {
        var resBody = jsonDecode(res.body);
        if (resBody['success']) {
          UserModel userInfo = UserModel.fromJson(resBody["thirdStaffData"]);
          thirdStaff.value = userInfo;
        } else {
          Fluttertoast.showToast(msg: resBody.toString());
        }
      }
    } catch (e) {
      print(e.toString());
      Fluttertoast.showToast(msg: e.toString());
    }
  }

  void getTopFirstStudent() async {
    try {
      var res = await http.get(
        Uri.parse(Api.getTopFirstStudent),
      );

      if (res.statusCode == 200) {
        var resBody = jsonDecode(res.body);
        if (resBody['success']) {
          UserModel userInfo = UserModel.fromJson(resBody["firstStudentData"]);
          firstStudent.value = userInfo;
        } else {
          Fluttertoast.showToast(msg: resBody.toString());
        }
      }
    } catch (e) {
      print(e.toString());
      Fluttertoast.showToast(msg: e.toString());
    }
  }

  void getTopSecondStudent() async {
    try {
      var res = await http.get(
        Uri.parse(Api.getTopSecondStudent),
      );

      if (res.statusCode == 200) {
        var resBody = jsonDecode(res.body);
        if (resBody['success']) {
          UserModel userInfo = UserModel.fromJson(resBody["secondStudentData"]);
          secondStudent.value = userInfo;
        } else {
          Fluttertoast.showToast(msg: resBody.toString());
        }
      }
    } catch (e) {
      print(e.toString());
      Fluttertoast.showToast(msg: e.toString());
    }
  }

  void getTopThirdStudent() async {
    try {
      var res = await http.get(
        Uri.parse(Api.getTopThirdStudent),
      );

      if (res.statusCode == 200) {
        var resBody = jsonDecode(res.body);
        if (resBody['success']) {
          UserModel userInfo = UserModel.fromJson(resBody["thirdStudentData"]);
          thirdStudent.value = userInfo;
        } else {
          Fluttertoast.showToast(msg: resBody.toString());
        }
      }
    } catch (e) {
      print(e.toString());
      Fluttertoast.showToast(msg: e.toString());
    }
  }
}
