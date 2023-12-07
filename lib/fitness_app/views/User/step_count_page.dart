import 'package:fitnessapp/fitness_app/controllers/User/stepCountController.dart';
import 'package:fitnessapp/fitness_app/views/responsive_padding.dart';
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
            icon: const Icon(Icons.arrow_back, color: Colors.white),
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
                  const SizedBox(
                    height: 30,
                  ),
                  const Text(
                    "Other records",
                    style: TextStylePreset.bigTitle,
                  ),
                  const SizedBox(
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
      padding: const EdgeInsets.only(left: 20, top: 10, right: 20, bottom: 10),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey),
        borderRadius: const BorderRadius.all(Radius.circular(5.0)),
      ),
      child: Column(
        children: [
          const Text(
            "Today",
            style: TextStylePreset.bigTitle,
          ),
          const SizedBox(
            height: 15,
          ),
          Obx(() {
            return Text(
              "${_stepCountController.totalStepCounts}/10000 steps",
              style: TextStylePreset.bigText,
            );
          }),
          const SizedBox(
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
                  return const Text(
                      "Error: cannot show percent indicator for value < 0");
                }
              }())),
          const SizedBox(
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
                padding: const EdgeInsets.all(10),
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
