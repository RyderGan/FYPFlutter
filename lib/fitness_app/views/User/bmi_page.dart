import 'dart:math';

import 'package:fitnessapp/fitness_app/controllers/User/bmiController.dart';
import 'package:fitnessapp/fitness_app/views/responsive_padding.dart';
import 'package:fitnessapp/routes.dart';
import 'package:fitnessapp/theme/colors.dart';
import 'package:fitnessapp/theme/text_style.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:line_icons/line_icons.dart';

class BmiPage extends StatefulWidget {
  const BmiPage({Key? key}) : super(key: key);

  @override
  _BmiPageState createState() => _BmiPageState();
}

class _BmiPageState extends State<BmiPage> {
  final _bmiController = Get.put(bmiController());

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return ResponsivePadding(
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(Icons.arrow_back, color: Colors.white),
            onPressed: () => Get.offNamed(Routes.root_app),
          ),
          title: const Text("BMI"),
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
              child: Column(
                children: [
                  Text(
                    "Add New Bmi",
                    style: TextStylePreset.bigTitle,
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  addNewBmiForm(),
                  SizedBox(
                    height: 30,
                  ),
                  Text(
                    "All records",
                    style: TextStylePreset.bigTitle,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  displayUserAllBmi(),
                ],
              )),
        ),
      );
    });
  }

  Container addNewBmiForm() {
    return Container(
      alignment: Alignment.topLeft,
      width: double.infinity,
      padding: EdgeInsets.only(left: 20, top: 10, right: 20, bottom: 10),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.all(Radius.circular(5.0)),
      ),
      child: Form(
        key: _bmiController.addNewBmiFormKey,
        autovalidateMode: AutovalidateMode.always,
        child: Column(
          children: [
            weightField(),
            SizedBox(
              height: 15,
            ),
            heightField(),
            SizedBox(
              height: 15,
            ),
            InkWell(
              onTap: () {
                _bmiController.addNewBmi();
              },
              child: addBmiButton(),
            ),
          ],
        ),
      ),
    );
  }

  Container weightField() {
    return Container(
      height: 50,
      width: double.infinity,
      decoration: BoxDecoration(
          color: bgTextField, borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.only(left: 10, right: 10),
        child: Row(
          children: [
            Icon(
              LineIcons.weight,
              color: black.withOpacity(0.5),
            ),
            SizedBox(
              width: 15,
            ),
            Flexible(
              child: TextFormField(
                cursorColor: black.withOpacity(0.5),
                decoration: InputDecoration(
                    hintText: "Weight in unit (kg)", border: InputBorder.none),
                keyboardType: TextInputType.number,
                controller: _bmiController.weightController,
                validator: (value) {
                  if (value!.isEmpty) {
                    return "Please enter weight";
                  } else if (!value.isNumericOnly) {
                    return "Please enter numeric values";
                  }
                  return null;
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Container heightField() {
    return Container(
      height: 50,
      width: double.infinity,
      decoration: BoxDecoration(
          color: bgTextField, borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.only(left: 10, right: 10),
        child: Row(
          children: [
            Icon(
              Icons.height,
              color: black.withOpacity(0.5),
            ),
            SizedBox(
              width: 15,
            ),
            Flexible(
              child: TextFormField(
                cursorColor: black.withOpacity(0.5),
                decoration: InputDecoration(
                    hintText: "Height in unit (cm)", border: InputBorder.none),
                keyboardType: TextInputType.number,
                controller: _bmiController.heightController,
                validator: (value) {
                  if (value!.isEmpty) {
                    return "Please enter height";
                  } else if (!value.isNumericOnly) {
                    return "Please enter numeric values";
                  }
                  return null;
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Container addBmiButton() {
    return Container(
      height: 50,
      width: double.infinity,
      decoration: BoxDecoration(
          gradient: LinearGradient(colors: [fourthColor, thirdColor]),
          borderRadius: BorderRadius.circular(30)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.arrow_forward_sharp,
            color: white,
          ),
          SizedBox(
            width: 5,
          ),
          Text(
            "Add Bmi",
            style: TextStylePreset.btnSmallText,
          )
        ],
      ),
    );
  }

  Obx displayUserAllBmi() {
    return Obx(() => ListView.builder(
          shrinkWrap: true,
          primary: false,
          itemCount: _bmiController.allBmis.length,
          scrollDirection: Axis.vertical,
          itemBuilder: (context, index) {
            return Card(
              color: primary,
              child: Padding(
                padding: EdgeInsets.all(10),
                child: ListTile(
                  title: Text(
                    calculateBmi(
                            _bmiController.allBmis[index].weight.toString(),
                            _bmiController.allBmis[index].height.toString()) +
                        " kg/m\u{00B2}",
                    style: TextStylePreset.bigWhiteText,
                  ),
                  subtitle: Text(
                    _bmiController.allBmis[index].createdAt,
                    style: TextStylePreset.normalWhiteText,
                  ),
                  trailing: Container(
                    width: 90,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                            child: IconButton(
                                onPressed: () {
                                  showDialog(
                                    context: context,
                                    builder: (context) => SimpleDialog(
                                      children: [
                                        editBmiForm(_bmiController
                                            .allBmis[index].bmiID),
                                      ],
                                    ),
                                  );
                                },
                                icon: Icon(Icons.edit))),
                        Expanded(
                            child: IconButton(
                                onPressed: () {
                                  //delete action
                                  _bmiController.deleteUserBmi(
                                      _bmiController.allBmis[index].bmiID);
                                },
                                icon: Icon(Icons.delete))),
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        ));
  }

  Form editBmiForm(int bmiID) {
    return Form(
      key: _bmiController.editBmiFormKey,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      child: Column(
        children: [
          editWeightField(),
          SizedBox(
            height: 15,
          ),
          editHeightField(),
          InkWell(
            onTap: () {
              _bmiController.updateUserBmi(bmiID);
              Get.back();
            },
            child: updateBmiButton(),
          )
        ],
      ),
    );
  }

  Container editWeightField() {
    return Container(
      height: 50,
      width: double.infinity,
      decoration: BoxDecoration(
          color: bgTextField, borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.only(left: 10, right: 10),
        child: Row(
          children: [
            Icon(
              LineIcons.weight,
              color: black.withOpacity(0.5),
            ),
            SizedBox(
              width: 15,
            ),
            Flexible(
              child: TextFormField(
                cursorColor: black.withOpacity(0.5),
                decoration: InputDecoration(
                    hintText: "Weight in unit (kg)", border: InputBorder.none),
                keyboardType: TextInputType.number,
                controller: _bmiController.updateWeightController,
                validator: (value) {
                  if (value!.isEmpty) {
                    return "Please enter weight";
                  } else if (!value.isNumericOnly) {
                    return "Please enter numeric values";
                  }
                  return null;
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Container editHeightField() {
    return Container(
      height: 50,
      width: double.infinity,
      decoration: BoxDecoration(
          color: bgTextField, borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.only(left: 10, right: 10),
        child: Row(
          children: [
            Icon(
              Icons.height,
              color: black.withOpacity(0.5),
            ),
            SizedBox(
              width: 15,
            ),
            Flexible(
              child: TextFormField(
                cursorColor: black.withOpacity(0.5),
                decoration: InputDecoration(
                    hintText: "Height in unit (cm)", border: InputBorder.none),
                keyboardType: TextInputType.number,
                controller: _bmiController.updateHeightController,
                validator: (value) {
                  if (value!.isEmpty) {
                    return "Please enter height";
                  } else if (!value.isNumericOnly) {
                    return "Please enter numeric values";
                  }
                  return null;
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Container updateBmiButton() {
    return Container(
      height: 50,
      width: double.infinity,
      decoration: BoxDecoration(
          gradient: LinearGradient(colors: [fourthColor, thirdColor]),
          borderRadius: BorderRadius.circular(30)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.arrow_forward_sharp,
            color: white,
          ),
          SizedBox(
            width: 5,
          ),
          Text(
            "Update Bmi",
            style: TextStylePreset.btnSmallText,
          )
        ],
      ),
    );
  }

  String calculateBmi(String weight, String height) {
    double bmi = double.parse(weight) / pow(double.parse(height) / 100, 2);
    return bmi.toStringAsFixed(2);
  }
}
