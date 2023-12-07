import 'dart:convert';
import 'package:fitnessapp/fitness_app/models/Admin/rfidCheckpointModel.dart';
import 'package:fitnessapp/fitness_app/services/api_connection.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class checkpointListController extends GetxController {
  List<RfidCheckpointModel> checkpointList = <RfidCheckpointModel>[].obs;

  @override
  void onInit() {
    super.onInit();
    getCheckpointList();
  }

  @override
  void onClose() {
    checkpointList.clear();
    super.dispose();
  }

  void getCheckpointList() async {
    try {
      var res = await http.get(
        Uri.parse(Api.getRfidCheckpointList),
      );

      if (res.statusCode == 200) {
        var resBodyOfLogin = jsonDecode(res.body);
        if (resBodyOfLogin['success']) {
          List<RfidCheckpointModel> checkpoints =
              await resBodyOfLogin["rfidCheckpointList"]
                  .map<RfidCheckpointModel>(
                      (json) => RfidCheckpointModel.fromJson(json))
                  .toList();
          checkpointList.addAll(checkpoints);
        } else {
          List<RfidCheckpointModel> checkpoints = <RfidCheckpointModel>[];
          checkpointList.addAll(checkpoints);
        }
      }
    } catch (e) {
      print(e.toString());
      Fluttertoast.showToast(msg: e.toString());
    }
  }
}
