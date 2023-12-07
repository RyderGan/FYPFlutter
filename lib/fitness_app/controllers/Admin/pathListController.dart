import 'dart:convert';
import 'package:fitnessapp/fitness_app/models/Admin/pathModel.dart';
import 'package:fitnessapp/fitness_app/models/Admin/rfidCheckpointModel.dart';
import 'package:fitnessapp/fitness_app/services/api_connection.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class pathListController extends GetxController {
  List<PathModel> pathList = <PathModel>[].obs;
  List<RfidCheckpointModel> checkpointModelList = <RfidCheckpointModel>[].obs;

  @override
  void onInit() {
    super.onInit();
    getPathList();
  }

  @override
  void onClose() {
    pathList.clear();
    super.dispose();
  }

  Future<String> getCheckpointName(var checkpointID) async {
    try {
      var res = await http.get(
        Uri.parse(Api.getRfidCheckpointList),
      );

      if (res.statusCode == 200) {
        var resBodyOfLogin = jsonDecode(res.body);
        if (resBodyOfLogin['success']) {
          checkpointModelList = <RfidCheckpointModel>[].obs;
          List<RfidCheckpointModel> checkpoints =
              await resBodyOfLogin["rfidCheckpointList"]
                  .map<RfidCheckpointModel>(
                      (json) => RfidCheckpointModel.fromJson(json))
                  .toList();
          checkpointModelList.addAll(checkpoints);
          for (RfidCheckpointModel checkpoint in checkpoints) {
            if (checkpoint.rfid_checkpoint_id.toString() == checkpointID) {
              return checkpoint.name.toString();
            }
          }
        } else {
          List<RfidCheckpointModel> checkpoints = <RfidCheckpointModel>[];
          checkpointModelList.addAll(checkpoints);
        }
      }
    } catch (e) {
      print(e.toString());
      Fluttertoast.showToast(msg: e.toString());
    }
    return "Error";
  }

  void getPathList() async {
    try {
      var res = await http.get(
        Uri.parse(Api.getPathList),
      );

      if (res.statusCode == 200) {
        var resBodyOfLogin = jsonDecode(res.body);
        if (resBodyOfLogin['success']) {
          List<PathModel> paths = await resBodyOfLogin["pathList"]
              .map<PathModel>((json) => PathModel.fromJson(json))
              .toList();
          pathList.addAll(paths);
        } else {
          List<PathModel> paths = <PathModel>[];
          pathList.addAll(paths);
        }
      }
    } catch (e) {
      print(e.toString());
      Fluttertoast.showToast(msg: e.toString());
    }
  }
}
