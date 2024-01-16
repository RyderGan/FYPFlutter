import 'package:fitnessapp/fitness_app/controllers/User/homeController.dart';
import 'package:fitnessapp/fitness_app/views/responsive_padding.dart';
import 'package:fitnessapp/routes.dart';
import 'package:fitnessapp/theme/colors.dart';
import 'package:fitnessapp/theme/text_style.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

class HomeFragmentScreen extends StatefulWidget {
  const HomeFragmentScreen({super.key});

  @override
  _HomeFragmentScreenState createState() => _HomeFragmentScreenState();
}

class _HomeFragmentScreenState extends State<HomeFragmentScreen> {
  final _homeScreenController = Get.put(homeController());

  @override
  Widget build(BuildContext context) {
    return ResponsivePadding(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: RefreshIndicator(
          child: SafeArea(child: getBody()),
          onRefresh: () {
            return Future.delayed(
              Duration(seconds: 1),
              () {
                //Refresh List
                _homeScreenController.refreshList();
              },
            );
          },
        ),
      ),
    );
  }

  Widget getBody() {
    return LayoutBuilder(builder: (context, constraints) {
      return ConstrainedBox(
        constraints: BoxConstraints(
          minHeight: constraints.maxHeight,
        ),
        child: ListView.builder(
          itemCount: 1,
          itemBuilder: (context, index) {
            return SingleChildScrollView(
                child: Container(
                    padding: const EdgeInsets.all(20),
                    // height: MediaQuery.of(context).size.height,
                    child: Column(
                      children: [
                        displayStepCounts(),
                        const SizedBox(
                          height: 15,
                        ),
                        displayBmi(),
                        const SizedBox(
                          height: 15,
                        ),
                        displayBloodPressure(),
                        const SizedBox(
                          height: 15,
                        ),
                        displayVisceralFat(),
                        SizedBox(
                          height: 15,
                        ),
                      ],
                    )));
          },
        ),
      );
    });
  }

  Container displayStepCounts() {
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
                children: [
                  const Text(
                    "Step Counts",
                    style: TextStylePreset.bigTitle,
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Obx(() {
                    return Text(
                      "${_homeScreenController.finalStepCount.value}/10000 steps",
                      style: TextStylePreset.bigText,
                    );
                  }),
                  const SizedBox(
                    height: 10,
                  ),
                ],
              ),
              Align(
                alignment: Alignment.topRight,
                child: ElevatedButton(
                  onPressed: () {
                    Get.toNamed(Routes.step_count_page);
                  }, // icon of the button
                  style: ElevatedButton.styleFrom(
                    // styling the button
                    shape: const CircleBorder(),
                    padding: const EdgeInsets.all(20),
                    backgroundColor: Colors.blue, // Button color
                    foregroundColor: Colors.cyan, // Splash color
                  ),
                  child: const Icon(Icons.chevron_right_sharp,
                      color: Colors.white),
                ),
              )
            ],
          ),
          const SizedBox(
            height: 15,
          ),
          Obx(() => (() {
                if (_homeScreenController.finalStepCount >= 0) {
                  return LinearPercentIndicator(
                    percent: _homeScreenController.finalStepCount.value / 10000,
                    progressColor: Colors.green,
                    lineHeight: 15,
                    animation: true,
                  );
                } else {
                  return const Text(
                      "Error: cannot show percent indicator for value < 0");
                }
              }())),
        ],
      ),
    );
  }

  Container displayBmi() {
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
                children: [
                  const Text(
                    "BMI",
                    style: TextStylePreset.bigTitle,
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Obx(() {
                    return Text(
                      "${_homeScreenController.bmi.value.toStringAsFixed(2)} kg/m\u{00B2}",
                      style: TextStylePreset.bigText,
                    );
                  }),
                  const SizedBox(
                    height: 15,
                  ),
                  Obx(() => (() {
                        if (_homeScreenController.bmi.value > 0 &&
                            _homeScreenController.bmi.value < 18.5) {
                          return const Text(
                            "Underweight",
                            style:
                                TextStyle(fontSize: 20, color: Colors.orange),
                          );
                        } else if (_homeScreenController.bmi.value >= 18.5 &&
                            _homeScreenController.bmi.value <= 24.9) {
                          return const Text(
                            "Normal weight",
                            style: TextStyle(fontSize: 20, color: Colors.blue),
                          );
                        } else if (_homeScreenController.bmi.value >= 25 &&
                            _homeScreenController.bmi.value <= 29.9) {
                          return const Text(
                            "Overweight",
                            style:
                                TextStyle(fontSize: 20, color: Colors.orange),
                          );
                        } else if (_homeScreenController.bmi.value >= 30) {
                          return const Text(
                            "Obesity",
                            style: TextStyle(fontSize: 20, color: Colors.red),
                          );
                        } else {
                          return const Text(
                            "Error: No data",
                            style: TextStyle(fontSize: 20, color: Colors.red),
                          );
                        }
                      }())),
                ],
              ),
              Align(
                alignment: Alignment.topRight,
                child: ElevatedButton(
                  onPressed: () {
                    Get.toNamed(Routes.bmi_page);
                  }, // icon of the button
                  style: ElevatedButton.styleFrom(
                    // styling the button
                    shape: const CircleBorder(),
                    padding: const EdgeInsets.all(20),
                    backgroundColor: Colors.blue, // Button color
                    foregroundColor: Colors.cyan, // Splash color
                  ),
                  child: const Icon(Icons.chevron_right_sharp,
                      color: Colors.white),
                ),
              )
            ],
          ),
        ],
      ),
    );
  }

  Container displayBloodPressure() {
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
                children: [
                  const Text(
                    "Blood Pressure",
                    style: TextStylePreset.bigTitle,
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Obx(() => (() {
                        if (_homeScreenController.systolicPressure.value > 0 &&
                            _homeScreenController.diastolicPressure.value > 0) {
                          return Text(
                            "${_homeScreenController.systolicPressure.value}/${_homeScreenController.diastolicPressure.value} mmHg",
                            style: TextStylePreset.bigText,
                          );
                        } else {
                          return const Text("No data",
                              style: TextStylePreset.bigText);
                        }
                      }())),
                  const SizedBox(
                    height: 10,
                  ),
                ],
              ),
              Align(
                alignment: Alignment.topRight,
                child: ElevatedButton(
                  onPressed: () {
                    Get.toNamed(Routes.blood_pressure_page);
                  }, // icon of the button
                  style: ElevatedButton.styleFrom(
                    // styling the button
                    shape: const CircleBorder(),
                    padding: const EdgeInsets.all(20),
                    backgroundColor: Colors.blue, // Button color
                    foregroundColor: Colors.cyan, // Splash color
                  ),
                  child: const Icon(Icons.chevron_right_sharp,
                      color: Colors.white),
                ),
              )
            ],
          ),
        ],
      ),
    );
  }

  Container displayVisceralFat() {
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
                children: [
                  const Text(
                    "Visceral Fat",
                    style: TextStylePreset.bigTitle,
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Obx(() => (() {
                        if (_homeScreenController.visceralFat.value > 0) {
                          return Text(
                            "Rating: ${_homeScreenController.visceralFat.value}",
                            style: TextStylePreset.bigText,
                          );
                        } else {
                          return const Text("No data",
                              style: TextStylePreset.bigText);
                        }
                      }())),
                  const SizedBox(
                    height: 10,
                  ),
                ],
              ),
              Align(
                alignment: Alignment.topRight,
                child: ElevatedButton(
                  onPressed: () {
                    Get.toNamed(Routes.visceral_fat_page);
                  }, // icon of the button
                  style: ElevatedButton.styleFrom(
                    // styling the button
                    shape: const CircleBorder(),
                    padding: const EdgeInsets.all(20),
                    backgroundColor: Colors.blue, // Button color
                    foregroundColor: Colors.cyan, // Splash color
                  ),
                  child: const Icon(Icons.chevron_right_sharp,
                      color: Colors.white),
                ),
              )
            ],
          ),
        ],
      ),
    );
  }

  MaterialButton refreshButton() {
    return MaterialButton(
      minWidth: double.infinity,
      height: 50,
      color: secondary,
      child: new Text('Refresh',
          style: new TextStyle(fontSize: 20, color: Colors.white)),
      onPressed: () {
        _homeScreenController.refreshList();
      },
    );
  }
}
