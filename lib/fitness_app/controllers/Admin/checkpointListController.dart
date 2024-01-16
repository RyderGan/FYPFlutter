import 'dart:convert';
import 'package:fitnessapp/fitness_app/models/Admin/checkpointModel.dart';
import 'package:fitnessapp/fitness_app/services/api_connection.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class checkpointListController extends GetxController {
  List<CheckpointModel> checkpointList = <CheckpointModel>[].obs;

  @override
  void onInit() {
    super.onInit();
    getCheckpointList();
  }

  void refreshList() {
    checkpointList.clear();
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
        Uri.parse(Api.getCheckpointList),
      );

      if (res.statusCode == 200) {
        var resBodyOfLogin = jsonDecode(res.body);
        if (resBodyOfLogin['success']) {
          List<CheckpointModel> checkpoints =
              await resBodyOfLogin["checkpointList"]
                  .map<CheckpointModel>(
                      (json) => CheckpointModel.fromJson(json))
                  .toList();
          checkpointList.addAll(checkpoints);
        } else {
          List<CheckpointModel> checkpoints = <CheckpointModel>[];
          checkpointList.addAll(checkpoints);
        }
      }
    } catch (e) {
      print(e.toString());
      Fluttertoast.showToast(msg: e.toString());
    }
  }
}
