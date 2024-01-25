import 'package:fitnessapp/fitness_app/controllers/User/workoutController.dart';
import 'package:fitnessapp/fitness_app/models/User/workoutModel.dart';
import 'package:fitnessapp/fitness_app/preferences/current_user.dart';
import 'package:fitnessapp/fitness_app/views/responsive_padding.dart';
import 'package:fitnessapp/theme/colors.dart';
import 'package:fitnessapp/theme/text_style.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SetDetailsPage extends StatefulWidget {
  const SetDetailsPage({Key? key}) : super(key: key);

  @override
  _SetDetailsPageState createState() => _SetDetailsPageState();
}

class _SetDetailsPageState extends State<SetDetailsPage> {
  final _workoutController = Get.put(workoutController());
  CurrentUser _currentUser = Get.put(CurrentUser());
  late Future<WorkoutModel> currentWorkout;
  bool isWeb = GetPlatform.isWeb;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return ResponsivePadding(
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.black),
            onPressed: () {
              _workoutController.displayPathIDs.clear();
              _workoutController.displaySetDetails.clear();
              Get.back();
            },
          ),
          title: const Text("Set details"),
        ),
        backgroundColor: Colors.white,
        body: SafeArea(child: getBody()),
      ),
    );
  }

  Widget getBody() {
    return LayoutBuilder(builder: (context, constraints) {
      return ConstrainedBox(
          constraints: BoxConstraints(
            minHeight: constraints.maxHeight,
            minWidth: double.infinity,
          ),
          child: SingleChildScrollView(
              child: Container(
            padding: const EdgeInsets.all(20),
            child: Column(children: [
              displayAllPaths(),
            ]),
          )));
    });
  }

  Obx displayAllPaths() {
    return Obx(() => ListView.builder(
          shrinkWrap: true,
          primary: false,
          itemCount: _workoutController.displaySetDetails.length,
          scrollDirection: Axis.vertical,
          itemBuilder: (context, index) {
            return Card(
              color: primary,
              child: Padding(
                padding: EdgeInsets.all(10),
                child: Column(
                  children: [
                    Text(
                      "Path " +
                          _workoutController.displayPathIDs[index].toString(),
                      style: TextStylePreset.bigWhiteText,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    getTextWidgets(_workoutController.displaySetDetails[index]),
                    SizedBox(
                      height: 15,
                    ),
                  ],
                ),
              ),
            );
          },
        ));
  }

  Widget getTextWidgets(List<int> checkpoints) {
    List<Widget> list = <Widget>[];
    for (var i = 0; i < checkpoints.length; i++) {
      list.add(new Text(
        "Checkpoint " + checkpoints[i].toString(),
        style: TextStylePreset.normalWhiteText,
      ));
    }
    return new Column(children: list);
  }
}
