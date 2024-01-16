import 'dart:convert';
import 'package:fitnessapp/fitness_app/models/Admin/checkpointModel.dart';
import 'package:fitnessapp/fitness_app/models/Admin/pathModel.dart';
import 'package:fitnessapp/fitness_app/services/api_connection.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class pathListController extends GetxController {
  List<PathModel> pathList = <PathModel>[].obs;
  List<CheckpointModel> checkpointModelList = <CheckpointModel>[].obs;

  @override
  void onInit() {
    super.onInit();
    getPathList();
  }

  void refreshList() {
    pathList.clear();
    getPathList();
  }

  @override
  void onClose() {
    pathList.clear();
    super.dispose();
  }

  Future<List<CheckpointModel>> getCurrentCheckpoints(PathModel path) async {
    List<CheckpointModel> currentCheckpointList = <CheckpointModel>[].obs;
    List<int> checkpointsinpath = path.checkpoint_list;
    for (int checkpointID in checkpointsinpath) {
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
            for (CheckpointModel checkpoint in checkpoints) {
              if (checkpointID == checkpoint.id) {
                currentCheckpointList.add(checkpoint);
                break;
              }
            }
          }
        }
      } catch (e) {
        print(e.toString());
        Fluttertoast.showToast(msg: e.toString());
      }
    }
    return currentCheckpointList;
  }

  Future<String> getCheckpointName(var checkpointID) async {
    try {
      var res = await http.get(
        Uri.parse(Api.getCheckpointList),
      );

      if (res.statusCode == 200) {
        var resBodyOfLogin = jsonDecode(res.body);
        if (resBodyOfLogin['success']) {
          checkpointModelList = <CheckpointModel>[].obs;
          List<CheckpointModel> checkpoints =
              await resBodyOfLogin["checkpointList"]
                  .map<CheckpointModel>(
                      (json) => CheckpointModel.fromJson(json))
                  .toList();
          checkpointModelList.addAll(checkpoints);
          for (CheckpointModel checkpoint in checkpoints) {
            if (checkpoint.id.toString() == checkpointID) {
              return checkpoint.name.toString();
            }
          }
        } else {
          List<CheckpointModel> checkpoints = <CheckpointModel>[];
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
