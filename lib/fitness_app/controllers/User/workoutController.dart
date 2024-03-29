import 'dart:async';
import 'dart:convert';
import 'package:fitnessapp/fitness_app/controllers/User/notificationController.dart';
import 'package:fitnessapp/fitness_app/models/Admin/checkpointModel.dart';
import 'package:fitnessapp/fitness_app/models/User/pathModel.dart';
import 'package:fitnessapp/fitness_app/models/User/setModel.dart';
import 'package:fitnessapp/fitness_app/models/User/workoutModel.dart';
import 'package:fitnessapp/fitness_app/preferences/current_user.dart';
import 'package:fitnessapp/fitness_app/services/api_connection.dart';
import 'package:fitnessapp/routes.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;

class workoutController extends GetxController {
  GlobalKey<FormState> addNewVisceralFatFormKey = GlobalKey<FormState>();
  GlobalKey<FormState> editVisceralFatFormKey = GlobalKey<FormState>();

  //late TextEditingController ratingController, updateRatingController;
  //Map<String, TextEditingController> bmiEditingControllers = {};
  final _notificationController = Get.put(notificationController());
  CurrentUser _currentUser = Get.put(CurrentUser());
  WorkoutModel currentWorkoutDetails =
      new WorkoutModel(0, 0, "", "", "", 0, "");
  List<SetModel> allSets = <SetModel>[].obs;
  List<PathModel> PathsResult = <PathModel>[];
  List<PathModel> currentPathsResult = <PathModel>[].obs;
  List<int> currentPaths = [];
  List<List<int>> currentCheckpoints = [];
  List<List<int>> checkpointsPassed = [];
  int currentSet = 0;
  int totalCheckpointsPassed = 0;
  int totalPointsEarned = 0;
  RxInt onlyOne = 1.obs;
  bool workOutInProgress = false;
  String nextCheckpointName = "Finding Next Checkpoint";
  String workOutInProgressType = "";
  List<List<int>> displaySetDetails = <List<int>>[].obs;
  List<int> displayPathIDs = [];
  List<CheckpointModel> allCheckpointDetails = [];

  @override
  void onInit() {
    if (currentSet < 1) {
      super.onInit();
    }
    onlyOne.value = 1;
    getAllWorkoutSets();
    getAllCheckpoints();
  }

  @override
  void onClose() {
    allSets.clear();
    super.dispose();
  }

  Future<void> getNextCheckpoint(List<List<int>> checkpointsPassedList) async {
    int nextCheckpointID = 0;
    //Find Next Checkpoint ID
    bool found = false;
    bool notFinished = true;
    int pathIndex = 0;
    int checkpointIndex = 0;
    for (var i = 0; i < currentPaths.length; i++) {
      //check if the path is finished
      for (int k = 0; k < checkpointsPassedList[i].length; k++) {
        //if the path is not yet finished
        if (checkpointsPassedList[i][k] == 0) {
          found = true;
          pathIndex = i;
          checkpointIndex = k;
          break;
        }
      }
      if (found) {
        break;
      }
    }

    nextCheckpointID = currentCheckpoints[pathIndex][checkpointIndex];
    nextCheckpointName = await getCheckpointName(nextCheckpointID);
  }

  Future<void> completeWorkout(int setID) async {
    try {
      var res = await http.post(
        Uri.parse(Api.addSetBonusPoints),
        body: {
          'userID': _currentUser.user.id.toString(),
          'setID': setID.toString(),
        },
      );

      if (res.statusCode == 200) {
        var resBody = jsonDecode(res.body);
        if (resBody['success']) {
          String message = resBody['message'];
          Fluttertoast.showToast(msg: message);
          _notificationController.addUserNotification(message);
        } else {
          Fluttertoast.showToast(msg: "Error occurred");
        }
      }
    } catch (e) {
      print(e.toString());
      Fluttertoast.showToast(msg: e.toString());
    }
    clearWorkout();
  }

  Future<String> getCheckpointName(int checkpointID) async {
    try {
      var res = await http.post(
        Uri.parse(Api.getCheckpointInfo),
        body: {
          'checkpointID': checkpointID.toString(),
        },
      );

      if (res.statusCode == 200) {
        var resBody = jsonDecode(res.body);
        if (resBody['success']) {
          CheckpointModel checkpointDetails =
              CheckpointModel.fromJson(resBody["checkpointData"]);
          return checkpointDetails.name;
        }
      }
    } catch (e) {
      print(e.toString());
      Fluttertoast.showToast(msg: e.toString());
    }
    return "Checkpoint Not Found";
  }

  Future<WorkoutModel> getWorkoutInfo(int userID) async {
    //Get Workout Info
    WorkoutModel workoutDetails = new WorkoutModel(0, 0, "", "", "", 0, "");
    try {
      var res = await http.post(
        Uri.parse(Api.getRFIDWorkout),
        body: {
          'userID': userID.toString(),
        },
      );

      if (res.statusCode == 200) {
        var resBody = jsonDecode(res.body);
        if (resBody['success']) {
          WorkoutModel workoutDetails =
              WorkoutModel.fromJson(resBody["workoutData"]);
          return workoutDetails;
        }
      }
    } catch (e) {
      print(e.toString());
      Fluttertoast.showToast(msg: e.toString());
    }
    return workoutDetails;
  }

  void getAllWorkoutSets() async {
    try {
      var res = await http.get(
        Uri.parse(Api.getAllWorkoutSets),
      );

      if (res.statusCode == 200) {
        var resBody = jsonDecode(res.body);
        if (resBody['success']) {
          List<SetModel> sets = await resBody["allSetData"]
              .map<SetModel>((json) => SetModel.fromJson(json))
              .toList();
          allSets.addAll(sets);
        }
      }
    } catch (e) {
      print(e.toString());
      Fluttertoast.showToast(msg: e.toString());
    }
  }

  void refreshList() {
    allSets.clear();
    getAllWorkoutSets();
  }

  void getPathDetails(int pathID) async {
    try {
      var res = await http.post(
        Uri.parse(Api.getPathDetails),
        body: {
          'pathID': pathID.toString(),
        },
      );

      if (res.statusCode == 200) {
        var resBody = jsonDecode(res.body);
        if (resBody['success']) {
          PathModel pathDetails = PathModel.fromJson(resBody["pathData"]);
          currentPathsResult.add(pathDetails);
        }
      }
    } catch (e) {
      print(e.toString());
      Fluttertoast.showToast(msg: e.toString());
    }
  }

  Future<void> getPathCheckpoints(int pathID) async {
    try {
      var res = await http.post(
        Uri.parse(Api.getPathDetails),
        body: {
          'pathID': pathID.toString(),
        },
      );

      if (res.statusCode == 200) {
        var resBody = jsonDecode(res.body);
        if (resBody['success']) {
          PathModel pathDetails = PathModel.fromJson(resBody["pathData"]);
          currentCheckpoints.add(pathDetails.path_checkpoint_list);
          checkpointsPassed.add(List<int>.empty(growable: true));
          await Future.delayed(const Duration(milliseconds: 500));
        }
      }
    } catch (e) {
      print(e.toString());
      Fluttertoast.showToast(msg: e.toString());
    }
  }

  bool checkUserHasCompleteSet() {
    bool valid = true;
    for (var i = 0; i < checkpointsPassed.length; i++) {
      for (var j = 0; j < checkpointsPassed[i].length; j++) {
        if (checkpointsPassed[i][j] == 0) {
          valid = false;
          return valid;
        }
      }
    }
    return valid;
  }

  void startRFIDWorkout(int setID, String pathList, String checkpointList,
      String passedList, int userID) async {
    try {
      var res = await http.post(
        Uri.parse(Api.startRFIDWorkout),
        body: {
          'setID': setID.toString(),
          'pathList': pathList,
          'checkpointList': checkpointList,
          'passedList': passedList,
          'userID': userID.toString(),
        },
      );
      print(res.statusCode);
      if (res.statusCode == 200) {
        var resBody = jsonDecode(res.body);
        if (resBody['success']) {
          Fluttertoast.showToast(msg: "Workout Started!");
        } else {
          Fluttertoast.showToast(msg: "Error: Couldn't Start Workout!");
        }
      }
    } catch (e) {
      print(e.toString());
      Fluttertoast.showToast(msg: e.toString());
    }
  }

  void stopRFIDWorkout(int userID) async {
    try {
      var res = await http.post(
        Uri.parse(Api.stopRFIDWorkout),
        body: {
          'userID': userID.toString(),
        },
      );

      if (res.statusCode == 200) {
        var resBody = jsonDecode(res.body);
        if (resBody['success']) {
          Fluttertoast.showToast(msg: "Workout Stopped!");
        }
      }
    } catch (e) {
      print(e.toString());
      Fluttertoast.showToast(msg: e.toString());
    }
  }

  void getRFIDWorkout(int userID) async {
    try {
      var res = await http.post(
        Uri.parse(Api.getRFIDWorkout),
        body: {
          'userID': userID.toString(),
        },
      );

      if (res.statusCode == 200) {
        var resBody = jsonDecode(res.body);
        if (resBody['success']) {
          WorkoutModel workoutDetails =
              WorkoutModel.fromJson(resBody["workoutData"]);
          currentWorkoutDetails = workoutDetails;
        }
      }
    } catch (e) {
      print(e.toString());
      Fluttertoast.showToast(msg: e.toString());
    }
  }

  bool updateNumberOfCheckpointsPassed(int path, int checkpoint) {
    bool valid = false;
    int currentPath = 0;
    int currentCheckpoint = currentCheckpoints[0][0];
    bool pathStarted = false;
    //check other path has started
    //check if other path are started
    for (var i = 0; i < currentPaths.length; i++) {
      if (path != currentPaths[i]) {
        if (checkpointsPassed[i][0] != 0) {
          //check if the path is finished
          for (int k = 0; k < currentCheckpoints[i].length; k++) {
            //if the path is not yet finished
            if (checkpointsPassed[i][k] != currentCheckpoints[i][k]) {
              String errorMsg = "Please finish other path first";
              Fluttertoast.showToast(msg: errorMsg);
              _notificationController.addUserNotification(errorMsg);
              return valid;
            }
          }
        }
      }
    }
    //check checkpoint exist
    for (var i = 0; i < currentPaths.length; i++) {
      if (path == currentPaths[i]) {
        currentPath = currentPaths[i];
        //check checkpoint exist
        for (int j = 0; j < currentCheckpoints[i].length; j++) {
          if (currentCheckpoints[i][j] == checkpoint) {
            //check if checkpoint is duplicated
            if (checkpointsPassed[i][j] == checkpoint) {
              valid = false;
              if ((j + 1) < currentCheckpoints[i].length) {
                checkpoint = checkpointsPassed[i][j + 1];
                String errorMsg =
                    "Duplicated checkpoint. Please go to Checkpoint ${currentCheckpoints[i][totalCheckpointsPassed]}.";
                Fluttertoast.showToast(msg: errorMsg);
                _notificationController.addUserNotification(errorMsg);
              } else {
                String errorMsg =
                    "Duplicated checkpoint. Please go to other path.";
                Fluttertoast.showToast(msg: errorMsg);
                _notificationController.addUserNotification(errorMsg);
              }
              return valid;
            }
            //check checkpoint sequence
            if (currentCheckpoints[i][totalCheckpointsPassed] == checkpoint) {
              checkpointsPassed[i][j] = currentCheckpoints[i][j];
              print("Recorded Path $currentPath Checkpoint $currentCheckpoint");
              totalCheckpointsPassed += 1;
              valid = true;
              //check if this checkpoint is the last checkpoint of one path
              if (totalCheckpointsPassed == currentCheckpoints[i].length) {
                //reset checkpoint counter
                totalCheckpointsPassed = 0;
              }
              return valid;
            } else {
              String errorMsg =
                  "Please go to Path $currentPath Checkpoint ${currentCheckpoints[i][totalCheckpointsPassed]}";
              Fluttertoast.showToast(msg: errorMsg);
              _notificationController.addUserNotification(errorMsg);
            }
          }
        }
      }
    }
    return valid;
  }

  void getSetDetails(int setID) async {
    //get all paths
    try {
      var res = await http.post(
        Uri.parse(Api.getOneWorkoutSet),
        body: {
          'setID': setID.toString(),
        },
      );

      if (res.statusCode == 200) {
        print(res.body);
        var resBody = jsonDecode(res.body);
        if (resBody['success']) {
          SetModel setDetails = SetModel.fromJson(resBody["setData"]);
          for (int i = 0; i < setDetails.paths.length; i++) {
            int pathID = setDetails.paths[i];
            displayPathIDs.add(pathID);
            //get path details
            try {
              var res2 = await http.post(
                Uri.parse(Api.getPathDetails),
                body: {
                  'pathID': pathID.toString(),
                },
              );
              if (res2.statusCode == 200) {
                var resBody2 = jsonDecode(res2.body);
                PathModel pathDetails =
                    PathModel.fromJson(resBody2["pathData"]);
                displaySetDetails.add(pathDetails.path_checkpoint_list);
              }
            } catch (e) {
              print(e.toString());
              Fluttertoast.showToast(msg: e.toString());
            }
          }
          Get.toNamed(Routes.set_details_page);
        }
      }
    } catch (e) {
      print(e.toString());
      Fluttertoast.showToast(msg: e.toString());
    }
  }

  void getAllCheckpoints() async {
    try {
      var res = await http.get(
        Uri.parse(Api.getAllCheckpoints),
      );

      if (res.statusCode == 200) {
        var resBody = jsonDecode(res.body);
        if (resBody['success']) {
          List<CheckpointModel> checkpoints =
              await resBody["allCheckpointsData"]
                  .map<CheckpointModel>(
                      (json) => CheckpointModel.fromJson(json))
                  .toList();
          allCheckpointDetails.addAll(checkpoints);
        }
      }
    } catch (e) {
      print(e.toString());
      Fluttertoast.showToast(msg: e.toString());
    }
  }

  void clearWorkout() {
    nextCheckpointName = "Finding Next Checkpoint";
    workOutInProgress = false;
    currentPaths.clear();
    currentCheckpoints.clear();
    checkpointsPassed.clear();
    currentSet = 0;
    totalPointsEarned = 0;
    totalCheckpointsPassed = 0;
    onlyOne.value = 2;
    onlyOne.value = 1;
    refreshList();
  }
}
