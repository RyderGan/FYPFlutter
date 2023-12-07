import 'dart:convert';
import 'package:fitnessapp/fitness_app/models/Admin/rfidBandModel.dart';
import 'package:fitnessapp/fitness_app/models/User/userModel.dart';
import 'package:fitnessapp/fitness_app/services/api_connection.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class rfidBandListController extends GetxController {
  List<RfidBandModel> rfidBandList = <RfidBandModel>[].obs;
  List<UserModel> userModelList = <UserModel>[].obs;

  @override
  void onInit() {
    super.onInit();
    getRfidBandList();
  }

  @override
  void onClose() {
    rfidBandList.clear();
    super.dispose();
  }

  Future<String> getUserEmail(var userID) async {
    try {
      var res = await http.get(
        Uri.parse(Api.getUserList),
      );

      if (res.statusCode == 200) {
        var resBodyOfLogin = jsonDecode(res.body);
        if (resBodyOfLogin['success']) {
          userModelList = <UserModel>[].obs;
          List<UserModel> users = await resBodyOfLogin["userList"]
              .map<UserModel>((json) => UserModel.fromJson(json))
              .toList();
          userModelList.addAll(users);
          for (UserModel user in users) {
            if (user.id.toString() == userID.toString()) {
              return user.email.toString();
            }
          }
        } else {
          List<UserModel> users = <UserModel>[];
          userModelList.addAll(users);
        }
      }
    } catch (e) {
      print(e.toString());
      Fluttertoast.showToast(msg: e.toString());
    }
    return "Select user ID";
  }

  void getRfidBandList() async {
    try {
      var res = await http.get(
        Uri.parse(Api.getRfidBandList),
      );

      if (res.statusCode == 200) {
        var resBodyOfLogin = jsonDecode(res.body);
        if (resBodyOfLogin['success']) {
          List<RfidBandModel> rfidBands = await resBodyOfLogin["rfidBandList"]
              .map<RfidBandModel>((json) => RfidBandModel.fromJson(json))
              .toList();
          rfidBandList.addAll(rfidBands);
        } else {
          List<RfidBandModel> rfidBands = <RfidBandModel>[];
          rfidBandList.addAll(rfidBands);
        }
      }
    } catch (e) {
      print(e.toString());
      Fluttertoast.showToast(msg: e.toString());
    }
  }
}
