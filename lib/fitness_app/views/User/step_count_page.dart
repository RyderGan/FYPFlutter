import 'package:fitnessapp/fitness_app/controllers/User/stepCountController.dart';
import 'package:fitnessapp/fitness_app/views/responsive_padding.dart';
import 'package:fitnessapp/routes.dart';
import 'package:fitnessapp/theme/colors.dart';
import 'package:fitnessapp/theme/text_style.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

class StepCountPage extends StatefulWidget {
  const StepCountPage({Key? key}) : super(key: key);

  @override
  _StepCountPageState createState() => _StepCountPageState();
}

class _StepCountPageState extends State<StepCountPage> {
  final _stepCountController = Get.put(stepCountController());

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return ResponsivePadding(
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(Icons.arrow_back, color: Colors.white),
            onPressed: () => Get.back(),
          ),
          title: const Text("Step Counts"),
        ),
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
          minWidth: double.infinity,
        ),
        child: SingleChildScrollView(
          child: Container(
              padding: const EdgeInsets.all(20),
              height: MediaQuery.of(context).size.height,
              child: Column(
                children: [
                  displayUserLatestStepCount(),
                  SizedBox(
                    height: 30,
                  ),
                  Text(
                    "Other records",
                    style: TextStylePreset.bigTitle,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  displayUserAllStepCounts(),
                ],
              )),
        ),
      );
    });
  }

  Container displayUserLatestStepCount() {
    return Container(
      alignment: Alignment.center,
      width: double.infinity,
      padding: EdgeInsets.only(left: 20, top: 10, right: 20, bottom: 10),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.all(Radius.circular(5.0)),
      ),
      child: Column(
        children: [
          Text(
            "Today",
            style: TextStylePreset.bigTitle,
          ),
          SizedBox(
            height: 15,
          ),
          Obx(() {
            return Text(
              _stepCountController.totalStepCounts.toString() + "/10000 steps",
              style: TextStylePreset.bigText,
            );
          }),
          SizedBox(
            height: 15,
          ),
          Obx(() => (() {
                if (_stepCountController.totalStepCounts >= 0) {
                  return LinearPercentIndicator(
                    percent: _stepCountController.totalStepCounts / 10000,
                    progressColor: Colors.green,
                    lineHeight: 15,
                    animation: true,
                  );
                } else {
                  return Text(
                      "Error: cannot show percent indicator for value < 0");
                }
              }())),
          SizedBox(
            height: 10,
          ),
        ],
      ),
    );
  }

  Obx displayUserAllStepCounts() {
    return Obx(() => ListView.builder(
          shrinkWrap: true,
          primary: false,
          itemCount: _stepCountController.allStepCounts.length,
          scrollDirection: Axis.vertical,
          itemBuilder: (context, index) {
            return Card(
              color: primary,
              child: Padding(
                padding: EdgeInsets.all(10),
                child: ListTile(
                  title: Text(
                    _stepCountController.allStepCounts[index].stepCount
                        .toString(),
                    style: TextStylePreset.bigText,
                  ),
                  subtitle: Text(
                    _stepCountController.allStepCounts[index].createdAt,
                    style: TextStylePreset.normalText,
                  ),
                ),
              ),
            );
          },
        ));
  }
}
