import 'dart:async';

import 'package:fitnessapp/fitness_app/controllers/User/rewardsController.dart';
import 'package:fitnessapp/fitness_app/controllers/User/workoutController.dart';
import 'package:fitnessapp/fitness_app/models/User/pathModel.dart';
import 'package:fitnessapp/fitness_app/models/User/workoutModel.dart';
import 'package:fitnessapp/fitness_app/preferences/current_user.dart';
import 'package:fitnessapp/fitness_app/views/responsive_padding.dart';
import 'package:fitnessapp/theme/colors.dart';
import 'package:fitnessapp/theme/text_style.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class WorkoutFragmentScreen extends StatefulWidget {
  const WorkoutFragmentScreen({Key? key}) : super(key: key);

  @override
  _WorkoutFragmentScreenState createState() => _WorkoutFragmentScreenState();
}

class _WorkoutFragmentScreenState extends State<WorkoutFragmentScreen> {
  final _workoutController = Get.put(workoutController());
  CurrentUser _currentUser = Get.put(CurrentUser());
  late Future<WorkoutModel> currentWorkout;
  bool isWeb = GetPlatform.isWeb;

  @override
  void initState() {
    super.initState();
    setUpTimedFetch();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return ResponsivePadding(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(child: getBody()),
      ),
    );
  }

  Widget getBody() {
    return LayoutBuilder(builder: (context, constraints) {
      if (!isWeb) {
        return ConstrainedBox(
            constraints: BoxConstraints(
              minHeight: constraints.maxHeight,
              //minWidth: constraints.maxWidth,
            ),
            child: SingleChildScrollView(
                child: Container(
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  if (!isWeb) displayWorkoutProgress(),
                  if (!isWeb)
                    SizedBox(
                      height: 15,
                    ),
                  if (!isWeb)
                    Text(
                      "Sets Available",
                      style: TextStylePreset.bigTitle,
                    ),
                  if (!isWeb)
                    SizedBox(
                      height: 15,
                    ),
                  if (!isWeb) displayAllSets(),
                ],
              ),
            )));
      } else {
        return ConstrainedBox(
          constraints: BoxConstraints(
            minHeight: constraints.maxHeight,
            minWidth: double.infinity,
          ),
          child: Stack(
            alignment: Alignment.center,
            children: [
              if (isWeb) displayNotAvailable(),
            ],
          ),
        );
      }
    });
  }

  Container displayNotAvailable() {
    return Container(
      child: SingleChildScrollView(
          child: Container(
              padding: const EdgeInsets.all(20),
              // height: MediaQuery.of(context).size.height,
              child: Column(
                children: [
                  Text(
                    "Workout Module is only available inside the App",
                    style: TextStylePreset.bigTitle,
                  ),
                ],
              ))),
    );
  }

  Obx displayWorkoutProgress() {
    return Obx(() => ListView.builder(
          shrinkWrap: true,
          primary: false,
          itemCount: _workoutController.onlyOne.value,
          scrollDirection: Axis.vertical,
          itemBuilder: (context, index) {
            return Column(
              children: [
                (_workoutController.workOutInProgress == true &&
                        _workoutController.workOutInProgressType == "RFID")
                    ? displayNextCheckpoint()
                    : Text(
                        "Press Start to Begin!",
                        style: TextStylePreset.smallTitle,
                      )
              ],
            );
          },
        ));
  }

  Obx displayAllSets() {
    return Obx(() => ListView.builder(
          shrinkWrap: true,
          primary: false,
          itemCount: _workoutController.allSets.length,
          scrollDirection: Axis.vertical,
          itemBuilder: (context, index) {
            return Card(
              color: primary,
              child: Padding(
                padding: EdgeInsets.all(10),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                _workoutController.allSets[index].set_name,
                                style: TextStylePreset.bigWhiteText,
                              ),
                              SizedBox(
                                width: 15,
                              ),
                              Text(
                                "(" +
                                    _workoutController.allSets[index].set_type +
                                    ")",
                                style: TextStylePreset.normalWhiteText,
                              ),
                            ]),
                        Align(
                            alignment: Alignment.topRight,
                            child: Text(
                              "Points: " +
                                  _workoutController
                                      .allSets[index].set_bonusPoints
                                      .toString() +
                                  "pt",
                              style: TextStylePreset.normalWhiteText,
                            )),
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    detailsButton(_workoutController.allSets[index].set_id),
                    SizedBox(
                      height: 10,
                    ),
                    (_workoutController.workOutInProgress == false)
                        ? startButton(
                            _workoutController.allSets[index].set_id,
                            _workoutController.allSets[index].paths,
                            _workoutController.allSets[index].set_type)
                        : (_workoutController.currentSet ==
                                _workoutController.allSets[index].set_id)
                            ? workOutPaths(
                                _workoutController.allSets[index].set_id,
                                _workoutController.allSets[index].paths,
                                _workoutController.allSets[index].set_type)
                            : Text("")
                  ],
                ),
              ),
            );
          },
        ));
  }

  MaterialButton startButton(int setID, List<int> paths, String setType) {
    return MaterialButton(
      minWidth: double.infinity,
      height: 50,
      color: success,
      child: new Text('Start',
          style: new TextStyle(fontSize: 20, color: Colors.white)),
      onPressed: () async {
        _workoutController.clearWorkout();
        _workoutController.workOutInProgress = true;
        _workoutController.workOutInProgressType = setType;
        _workoutController.currentSet = setID;
        for (int i = 0; i < paths.length; i++) {
          await _workoutController.getPathCheckpoints(paths.elementAt(i));
          await Future.delayed(const Duration(milliseconds: 1500));
        }
        for (int i = 0; i < _workoutController.currentCheckpoints.length; i++) {
          for (int j = 0;
              j < _workoutController.currentCheckpoints[i].length;
              j++) {
            _workoutController.checkpointsPassed[i].add(0);
          }
        }
        _workoutController.currentPaths = paths;
        _workoutController.refreshList();
        print("Set ${_workoutController.currentSet.toString()}");
        print("Path ${_workoutController.currentPaths}");
        print("Checkpoints ${_workoutController.currentCheckpoints}");
        print("Passed ${_workoutController.checkpointsPassed}");

        if (setType == "RFID") {
          //Call function to store into workout db
          print("Start Workout");
          _workoutController.startRFIDWorkout(
              setID,
              _workoutController.currentPaths.toString(),
              _workoutController.currentCheckpoints.toString(),
              _workoutController.checkpointsPassed.toString(),
              _currentUser.user.id);
          //While true, continuously check db for status
        }
      },
    );
  }

  MaterialButton detailsButton(int setID) {
    return MaterialButton(
      minWidth: double.infinity,
      height: 50,
      color: secondary,
      child: new Text('See Details',
          style: new TextStyle(fontSize: 20, color: Colors.white)),
      onPressed: () async {
        _workoutController.getSetDetails(setID);
      },
    );
  }

  Container displayNextCheckpoint() {
    return Container(
      alignment: Alignment.topLeft,
      width: double.infinity,
      padding: const EdgeInsets.only(left: 20, top: 10, right: 20, bottom: 10),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey),
        borderRadius: const BorderRadius.all(Radius.circular(5.0)),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Next Checkpoint:",
                    style: TextStylePreset.bigTitle,
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Row(
                    children: [
                      const SizedBox(
                        width: 10,
                      ),
                      Text(
                        _workoutController.nextCheckpointName,
                        style: TextStylePreset.bigText,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(
            height: 15,
          ),
        ],
      ),
    );
  }

  MaterialButton stopButton(int setID, String setType) {
    return MaterialButton(
      minWidth: double.infinity,
      height: 50,
      color: error,
      child: new Text('Stop',
          style: new TextStyle(fontSize: 20, color: Colors.white)),
      onPressed: () {
        _workoutController.clearWorkout();
        _workoutController.onlyOne.value = 2;
        _workoutController.onlyOne.value = 1;
        if (setType == "RFID") {
          //Set RFID Workout as Completed
          _workoutController.stopRFIDWorkout(_currentUser.user.id);
        }
      },
    );
  }

  void displayAllPathDetails(List<int> paths) {
    for (var j = 0; j < paths.length; j++) {
      int pathID = paths[j];
      _workoutController.getPathDetails(pathID);
    }
  }

  Container workOutPaths(int setID, List<int> paths, String setType) {
    return Container(
      height: 100,
      width: double.infinity,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          displayAllCurrentPaths(),
          // SizedBox(
          //   height: 15,
          // ),
          stopButton(setID, setType),
        ],
      ),
    );
  }

  Obx displayAllCurrentPaths() {
    return Obx(() => ListView.builder(
          shrinkWrap: true,
          primary: false,
          itemCount: _workoutController.currentPathsResult.length,
          scrollDirection: Axis.vertical,
          itemBuilder: (context, index) {
            return Card(
              color: primary,
              child: Padding(
                padding: EdgeInsets.all(10),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          _workoutController
                              .currentPathsResult[index].path_name,
                          style: TextStylePreset.bigWhiteText,
                        ),
                        Align(
                            alignment: Alignment.topRight,
                            child: Text(
                              "",
                              // "Checkpoint: " +
                              //     _workoutController
                              //         .currentNumberOfCheckpoints[index]
                              //         .toString() +
                              //     "/" +
                              //     _workoutController.currentPathsResult[index]
                              //         .path_checkpoint_list.length
                              //         .toString(),
                              style: TextStylePreset.normalWhiteText,
                            )),
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    (_workoutController.workOutInProgress == false)
                        ? startButton(
                            _workoutController.allSets[index].set_id,
                            _workoutController.allSets[index].paths,
                            _workoutController.allSets[index].set_type)
                        : (_workoutController.currentSet ==
                                _workoutController.allSets[index].set_id)
                            ? workOutPaths(
                                _workoutController.allSets[index].set_id,
                                _workoutController.allSets[index].paths,
                                _workoutController.allSets[index].set_type)
                            : Text("")
                  ],
                ),
              ),
            );
          },
        ));
  }

  setUpTimedFetch() {
    Timer.periodic(Duration(milliseconds: 1000), (timer) async {
      if (_workoutController.workOutInProgress == true &&
          _workoutController.workOutInProgressType == "RFID") {
        print("RFID Set Active!");
        setState(() {
          currentWorkout =
              _workoutController.getWorkoutInfo(_currentUser.user.id);
        });
        WorkoutModel currentWorkoutNow = await currentWorkout;
        // get checkpoint passed list
        List<List<int>> checkpointPassedList = [];
        List<String> prepareCheckpointPassedList = currentWorkoutNow
            .workout_passed_list
            .replaceAll("],", "@")
            .replaceAll("]", "")
            .replaceAll("[", "")
            .replaceAll(" ", "")
            .split("@");
        for (String miniList in prepareCheckpointPassedList) {
          List<String> checkpointStringList = miniList.split(",");
          List<int> checkpointMiniList =
              checkpointStringList.map((data) => int.parse(data)).toList();
          checkpointPassedList.add(checkpointMiniList);
        }
        _workoutController.checkpointsPassed = checkpointPassedList;

        if (currentWorkoutNow.workout_status == "Finished") {
          await _workoutController
              .completeWorkout(_workoutController.currentSet);
          _workoutController.nextCheckpointName = "Finding Next Checkpoint";
          _workoutController.stopRFIDWorkout(_currentUser.user.id);
        } else {
          //Update Next Checkpoint Value
          await _workoutController.getNextCheckpoint(checkpointPassedList);
        }
        ;
      }
    });
  }
}
