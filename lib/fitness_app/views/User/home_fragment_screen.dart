import 'package:fitnessapp/fitness_app/controllers/User/homeController.dart';
import 'package:fitnessapp/fitness_app/preferences/current_user.dart';
import 'package:fitnessapp/fitness_app/views/responsive_padding.dart';
import 'package:fitnessapp/routes.dart';
import 'package:fitnessapp/theme/colors.dart';
import 'package:fitnessapp/theme/text_style.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

class HomeFragmentScreen extends StatefulWidget {
  @override
  _HomeFragmentScreenState createState() => _HomeFragmentScreenState();
}

class _HomeFragmentScreenState extends State<HomeFragmentScreen> {
  final _homeScreenController = Get.put(homeController());
  CurrentUser _currentUser = Get.put(CurrentUser());
  @override
  Widget build(BuildContext context) {
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
          ),
          child: SingleChildScrollView(
              child: Container(
                  padding: const EdgeInsets.all(20),
                  height: MediaQuery.of(context).size.height,
                  child: Column(
                    children: [
                      displayStepCounts(),
                      SizedBox(
                        height: 15,
                      ),
                      displayBmi(),
                      SizedBox(
                        height: 15,
                      ),
                      displayBloodPressure(),
                      SizedBox(
                        height: 15,
                      ),
                      displayVisceralFat(),
                    ],
                  ))));
    });
  }

  Container displayStepCounts() {
    return Container(
      alignment: Alignment.topLeft,
      width: double.infinity,
      padding: EdgeInsets.only(left: 20, top: 10, right: 20, bottom: 10),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.all(Radius.circular(5.0)),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                children: [
                  Text(
                    "Step Counts",
                    style: TextStylePreset.bigTitle,
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Obx(() {
                    return Text(
                      _homeScreenController.stepCount.value.toString() +
                          "/10000 steps",
                      style: TextStylePreset.bigText,
                    );
                  }),
                  SizedBox(
                    height: 10,
                  ),
                ],
              ),
              Align(
                alignment: Alignment.topRight,
                child: ElevatedButton(
                  onPressed: () {},
                  child: Icon(Icons.chevron_right_sharp,
                      color: Colors.white), // icon of the button
                  style: ElevatedButton.styleFrom(
                    // styling the button
                    shape: CircleBorder(),
                    padding: EdgeInsets.all(20),
                    backgroundColor: Colors.blue, // Button color
                    foregroundColor: Colors.cyan, // Splash color
                  ),
                ),
              )
            ],
          ),
          SizedBox(
            height: 15,
          ),
          Obx(() => (() {
                if (_homeScreenController.stepCount.value >= 0) {
                  return LinearPercentIndicator(
                    percent: _homeScreenController.stepCount.value / 10000,
                    progressColor: Colors.green,
                    lineHeight: 15,
                    animation: true,
                  );
                } else {
                  return Text(
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
      padding: EdgeInsets.only(left: 20, top: 10, right: 20, bottom: 10),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.all(Radius.circular(5.0)),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                children: [
                  Text(
                    "BMI",
                    style: TextStylePreset.bigTitle,
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Obx(() {
                    return Text(
                      _homeScreenController.bmi.value.toStringAsFixed(2) +
                          " kg/m\u{00B2}",
                      style: TextStylePreset.bigText,
                    );
                  }),
                  SizedBox(
                    height: 15,
                  ),
                  Obx(() => (() {
                        if (_homeScreenController.bmi.value > 0 &&
                            _homeScreenController.bmi.value < 18.5) {
                          return Text(
                            "Underweight",
                            style:
                                TextStyle(fontSize: 20, color: Colors.orange),
                          );
                        } else if (_homeScreenController.bmi.value >= 18.5 &&
                            _homeScreenController.bmi.value <= 24.9) {
                          return Text(
                            "Normal weight",
                            style: TextStyle(fontSize: 20, color: Colors.blue),
                          );
                        } else if (_homeScreenController.bmi.value >= 25 &&
                            _homeScreenController.bmi.value <= 29.9) {
                          return Text(
                            "Overweight",
                            style:
                                TextStyle(fontSize: 20, color: Colors.orange),
                          );
                        } else if (_homeScreenController.bmi.value >= 30) {
                          return Text(
                            "Obesity",
                            style: TextStyle(fontSize: 20, color: Colors.red),
                          );
                        } else {
                          return Text(
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
                  },
                  child: Icon(Icons.chevron_right_sharp,
                      color: Colors.white), // icon of the button
                  style: ElevatedButton.styleFrom(
                    // styling the button
                    shape: CircleBorder(),
                    padding: EdgeInsets.all(20),
                    backgroundColor: Colors.blue, // Button color
                    foregroundColor: Colors.cyan, // Splash color
                  ),
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
      padding: EdgeInsets.only(left: 20, top: 10, right: 20, bottom: 10),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.all(Radius.circular(5.0)),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                children: [
                  Text(
                    "Blood Pressure",
                    style: TextStylePreset.bigTitle,
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Obx(() {
                    return Text(
                      _homeScreenController.systolicPressure.value.toString() +
                          "/" +
                          _homeScreenController.diastolicPressure.value
                              .toString() +
                          " mmHg",
                      style: TextStylePreset.bigText,
                    );
                  }),
                  SizedBox(
                    height: 10,
                  ),
                ],
              ),
              Align(
                alignment: Alignment.topRight,
                child: ElevatedButton(
                  onPressed: () {
                    Get.toNamed(Routes.blood_pressure_page);
                  },
                  child: Icon(Icons.chevron_right_sharp,
                      color: Colors.white), // icon of the button
                  style: ElevatedButton.styleFrom(
                    // styling the button
                    shape: CircleBorder(),
                    padding: EdgeInsets.all(20),
                    backgroundColor: Colors.blue, // Button color
                    foregroundColor: Colors.cyan, // Splash color
                  ),
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
      padding: EdgeInsets.only(left: 20, top: 10, right: 20, bottom: 10),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.all(Radius.circular(5.0)),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                children: [
                  Text(
                    "Visceral Fat",
                    style: TextStylePreset.bigTitle,
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Obx(() {
                    return Text(
                      "Rating: " +
                          _homeScreenController.visceralFat.value.toString(),
                      style: TextStylePreset.bigText,
                    );
                  }),
                  SizedBox(
                    height: 10,
                  ),
                ],
              ),
              Align(
                alignment: Alignment.topRight,
                child: ElevatedButton(
                  onPressed: () {},
                  child: Icon(Icons.chevron_right_sharp,
                      color: Colors.white), // icon of the button
                  style: ElevatedButton.styleFrom(
                    // styling the button
                    shape: CircleBorder(),
                    padding: EdgeInsets.all(20),
                    backgroundColor: Colors.blue, // Button color
                    foregroundColor: Colors.cyan, // Splash color
                  ),
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}
