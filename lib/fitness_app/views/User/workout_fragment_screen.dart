import 'dart:async';
import 'dart:ffi';

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
        backgroundColor: white,
        body: SafeArea(child: getBody()),
      ),
    );
  }

  Widget getBody() {
    return LayoutBuilder(builder: (context, constraints) {
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
                Text(
                  "Sets Available",
                  style: TextStylePreset.bigTitle,
                ),
                SizedBox(
                  height: 15,
                ),
                displayAllSets(),
              ],
            ),
          )));
    });
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
        _workoutController.currentSet = setID;
        for (int i = 0; i < paths.length; i++) {
          _workoutController.getPathCheckpoints(paths.elementAt(i));
          await Future.delayed(const Duration(milliseconds: 500));
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

  MaterialButton stopButton(int setID, String setType) {
    return MaterialButton(
      minWidth: double.infinity,
      height: 50,
      color: error,
      child: new Text('Stop',
          style: new TextStyle(fontSize: 20, color: Colors.white)),
      onPressed: () {
        _workoutController.clearWorkout();
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
    Timer.periodic(Duration(milliseconds: 5000), (timer) async {
      if (_workoutController.workOutInProgress == true) {
        print("RFID Set Active!");
        setState(() {
          currentWorkout =
              _workoutController.getWorkoutInfo(_currentUser.user.id);
        });
        WorkoutModel currentWorkoutNow = await currentWorkout;
        if (currentWorkoutNow.workout_status == "Finished") {
          await _workoutController
              .completeWorkout(_workoutController.currentSet);
        }
        ;
      }
    });
  }
}
