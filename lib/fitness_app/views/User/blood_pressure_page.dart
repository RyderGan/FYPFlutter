import 'dart:math';

import 'package:fitnessapp/fitness_app/controllers/User/bloodPressureController.dart';
import 'package:fitnessapp/fitness_app/controllers/User/bmiController.dart';
import 'package:fitnessapp/fitness_app/models/User/bmiModel.dart';
import 'package:fitnessapp/fitness_app/preferences/current_user.dart';
import 'package:fitnessapp/fitness_app/views/responsive_padding.dart';
import 'package:fitnessapp/routes.dart';
import 'package:fitnessapp/theme/colors.dart';
import 'package:fitnessapp/theme/text_style.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:line_icons/line_icons.dart';

class BloodPressurePage extends StatefulWidget {
  const BloodPressurePage({Key? key}) : super(key: key);

  @override
  _BloodPressurePageState createState() => _BloodPressurePageState();
}

class _BloodPressurePageState extends State<BloodPressurePage> {
  CurrentUser _currentUser = Get.put(CurrentUser());
  final _bloodPressureController = Get.put(bloodPressureController());

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
          title: const Text("Blood Pressure"),
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
                  Text(
                    "Add New Blood Pressure",
                    style: TextStylePreset.bigTitle,
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  addNewBloodPressureForm(),
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
                  displayUserAllBloodPressure(),
                ],
              )),
        ),
      );
    });
  }

  Container addNewBloodPressureForm() {
    return Container(
      alignment: Alignment.topLeft,
      width: double.infinity,
      padding: EdgeInsets.only(left: 20, top: 10, right: 20, bottom: 10),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.all(Radius.circular(5.0)),
      ),
      child: Form(
        key: _bloodPressureController.addNewBloodPressureFormKey,
        autovalidateMode: AutovalidateMode.always,
        child: Column(
          children: [
            systolicField(),
            SizedBox(
              height: 15,
            ),
            diastolicField(),
            SizedBox(
              height: 15,
            ),
            InkWell(
              onTap: () {
                _bloodPressureController.addNewBloodPressure();
              },
              child: addBloodPressureButton(),
            )
          ],
        ),
      ),
    );
  }

  Container systolicField() {
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
              Icons.outbond,
              color: black.withOpacity(0.5),
            ),
            SizedBox(
              width: 15,
            ),
            Flexible(
              child: TextFormField(
                cursorColor: black.withOpacity(0.5),
                decoration: InputDecoration(
                    hintText: "Systolic pressure", border: InputBorder.none),
                keyboardType: TextInputType.number,
                controller: _bloodPressureController.systolicController,
                validator: (value) {
                  if (value!.isEmpty) {
                    return "Please enter systolic pressure";
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Container diastolicField() {
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
              Icons.bedtime,
              color: black.withOpacity(0.5),
            ),
            SizedBox(
              width: 15,
            ),
            Flexible(
              child: TextFormField(
                cursorColor: black.withOpacity(0.5),
                decoration: InputDecoration(
                    hintText: "Diastolic pressure", border: InputBorder.none),
                keyboardType: TextInputType.number,
                controller: _bloodPressureController.diastolicController,
                validator: (value) {
                  if (value!.isEmpty) {
                    return "Please enter diastolic pressure";
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Container addBloodPressureButton() {
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
            "Add Blood Pressure",
            style: TextStylePreset.btnSmallText,
          )
        ],
      ),
    );
  }

  Obx displayUserAllBloodPressure() {
    return Obx(() => ListView.builder(
          shrinkWrap: true,
          primary: false,
          itemCount: _bloodPressureController.allBloodPressures.length,
          scrollDirection: Axis.vertical,
          itemBuilder: (context, index) {
            return Card(
              color: primary,
              child: Padding(
                padding: EdgeInsets.all(10),
                child: ListTile(
                  title: Text(
                    _bloodPressureController.allBloodPressures[index].systolic
                            .toString() +
                        "/" +
                        _bloodPressureController
                            .allBloodPressures[index].diastolic
                            .toString(),
                    style: TextStylePreset.bigText,
                  ),
                  subtitle: Text(
                    _bloodPressureController.allBloodPressures[index].createdAt,
                    style: TextStylePreset.normalText,
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
                                        editBloodPressureForm(
                                            _bloodPressureController
                                                .allBloodPressures[index].bpID),
                                      ],
                                    ),
                                  );
                                },
                                icon: Icon(Icons.edit))),
                        Expanded(
                            child: IconButton(
                                onPressed: () {
                                  //delete action
                                  _bloodPressureController
                                      .deleteUserBloodPressure(
                                          _bloodPressureController
                                              .allBloodPressures[index].bpID);
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

  Form editBloodPressureForm(int bpID) {
    return Form(
      key: _bloodPressureController.editBloodPressureFormKey,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      child: Column(
        children: [
          editSystolicField(),
          SizedBox(
            height: 15,
          ),
          editDiastolicField(),
          InkWell(
            onTap: () {
              _bloodPressureController.updateUserBloodPressure(bpID);
            },
            child: updateBloodPressureButton(),
          )
        ],
      ),
    );
  }

  Container editSystolicField() {
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
                    hintText: "Systolic pressure", border: InputBorder.none),
                keyboardType: TextInputType.number,
                controller: _bloodPressureController.updateSystolicController,
                validator: (value) {
                  if (value!.isEmpty) {
                    return "Please enter systolic pressure";
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Container editDiastolicField() {
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
                    hintText: "Diastolic pressure", border: InputBorder.none),
                keyboardType: TextInputType.number,
                controller: _bloodPressureController.updateDiastolicController,
                validator: (value) {
                  if (value!.isEmpty) {
                    return "Please enter diastolic pressure";
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Container updateBloodPressureButton() {
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
            "Update Blood Pressure",
            style: TextStylePreset.btnSmallText,
          )
        ],
      ),
    );
  }
}
