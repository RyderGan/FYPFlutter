import 'dart:convert';
import 'package:fitnessapp/fitness_app/models/Admin/pathModel.dart';
import 'package:fitnessapp/fitness_app/models/Admin/setModel.dart';
import 'package:fitnessapp/fitness_app/services/api_connection.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class setListController extends GetxController {
  List<SetModel> setList = <SetModel>[].obs;
  List<PathModel> pathModelList = <PathModel>[].obs;

  @override
  void onInit() {
    super.onInit();
    getSetList();
  }

  void refreshList() {
    setList.clear();
    getSetList();
  }

  @override
  void onClose() {
    setList.clear();
    super.dispose();
  }

  Future<List<PathModel>> getCurrentPaths(SetModel set) async {
    List<PathModel> currentPathList = <PathModel>[].obs;
    List<int> pathsinset = set.path_list;
    for (int pathID in pathsinset) {
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
            for (PathModel path in paths) {
              if (pathID == path.id) {
                currentPathList.add(path);
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
    return currentPathList;
  }

  Future<String> getPathName(var pathID) async {
    try {
      var res = await http.get(
        Uri.parse(Api.getPathList),
      );

      if (res.statusCode == 200) {
        var resBodyOfLogin = jsonDecode(res.body);
        if (resBodyOfLogin['success']) {
          pathModelList = <PathModel>[].obs;
          List<PathModel> paths = await resBodyOfLogin["pathList"]
              .map<PathModel>((json) => PathModel.fromJson(json))
              .toList();
          pathModelList.addAll(paths);
          for (PathModel path in paths) {
            if (path.id.toString() == pathID) {
              return path.name.toString();
            }
          }
        } else {
          List<PathModel> paths = <PathModel>[];
          pathModelList.addAll(paths);
        }
      }
    } catch (e) {
      print(e.toString());
      Fluttertoast.showToast(msg: e.toString());
    }
    return "Error";
  }

  void getSetList() async {
    try {
      var res = await http.get(
        Uri.parse(Api.getSetList),
      );

      if (res.statusCode == 200) {
        var resBodyOfLogin = jsonDecode(res.body);
        if (resBodyOfLogin['success']) {
          List<SetModel> sets = await resBodyOfLogin["setList"]
              .map<SetModel>((json) => SetModel.fromJson(json))
              .toList();
          setList.addAll(sets);
        } else {
          List<SetModel> sets = <SetModel>[];
          setList.addAll(sets);
        }
      }
    } catch (e) {
      print(e.toString());
      Fluttertoast.showToast(msg: e.toString());
    }
  }
}
