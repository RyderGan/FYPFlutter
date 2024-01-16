import 'dart:convert';
import 'package:fitnessapp/fitness_app/controllers/Admin/editPathInfoController.dart';
import 'package:fitnessapp/fitness_app/models/Admin/checkpointModel.dart';
import 'package:fitnessapp/fitness_app/views/responsive_padding.dart';
import 'package:fitnessapp/theme/colors.dart';
import 'package:fitnessapp/theme/text_style.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:fitnessapp/fitness_app/services/api_connection.dart';
import 'package:http/http.dart' as http;

class EditPathInfoPage extends StatefulWidget {
  const EditPathInfoPage({Key? key}) : super(key: key);

  @override
  _EditPathInfoPageState createState() => _EditPathInfoPageState();
}

class _EditPathInfoPageState extends State<EditPathInfoPage> {
  final _editPathInfoController = Get.put(EditPathInfoController());
  List<String> checkpointList = [];
  var arguments = Get.arguments;
  var types = [
    'Select type',
    'RFID',
    'QR Code',
  ];
  //methods

  @override
  Widget build(BuildContext context) {
    _editPathInfoController.setPathDetails(arguments);
    // fromCpIDValue =
    //     _editPathInfoController.getCheckpointName(arguments.fromCpID);
    // toCpIDValue = _editPathInfoController.getCheckpointName(arguments.toCpID);
    // TODO: implement build
    return ResponsivePadding(
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.white),
            onPressed: () => Get.back(),
          ),
          title: const Text("Edit Path Information"),
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
        ),
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(children: [
              const Text(
                "Edit Path info",
                style: TextStylePreset.bigTitle,
              ),
              const SizedBox(
                height: 15,
              ),
              pathInfoForm(),
            ]),
          ),
        ),
      );
    });
  }

  Form pathInfoForm() {
    return Form(
      key: _editPathInfoController.editPathInfoFormKey,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      child: Column(
        children: [
          nameField(),
          const SizedBox(
            height: 15,
          ),
          distanceField(),
          const SizedBox(
            height: 15,
          ),
          elevationField(),
          const SizedBox(
            height: 15,
          ),
          difficultyField(),
          const SizedBox(
            height: 15,
          ),
          pointsField(),
          const SizedBox(
            height: 15,
          ),
          timeLimitField(),
          const SizedBox(
            height: 15,
          ),
          typeField(),
          const SizedBox(
            height: 15,
          ),
          InkWell(
            onTap: () {
              _editPathInfoController.updatePathInfo(arguments);
            },
            child: updatePathInfoButton(),
          ),
          const SizedBox(
            height: 15,
          ),
          InkWell(
            onTap: () {
              _editPathInfoController.deletePath(arguments);
            },
            child: deletePathButton(),
          )
        ],
      ),
    );
  }

  Container typeField() {
    String typeValue = arguments.type;
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15.0),
        border: Border.all(color: black.withOpacity(0.1)),
      ),
      child: DropdownButtonFormField(
        decoration: const InputDecoration(
          prefixIcon: Icon(Icons.person),
        ),
        padding: const EdgeInsets.only(left: 10, right: 10),
        value: typeValue,
        icon: const Icon(Icons.keyboard_arrow_down),
        isExpanded: true,
        items: types.map((String items) {
          return DropdownMenuItem(
            value: items,
            child: Text(items),
          );
        }).toList(),
        onChanged: (String? newValue) {
          setState(() {
            typeValue = newValue!;
            arguments.type = typeValue;
          });
        },
        validator: (checkpointTypeValue) {
          if (checkpointTypeValue == "Select type") {
            return "Please select a type";
          }
          return null;
        },
      ),
    );
  }

  Container nameField() {
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
              Icons.abc,
              color: black.withOpacity(0.5),
            ),
            const SizedBox(
              width: 15,
            ),
            Flexible(
              child: TextFormField(
                cursorColor: black.withOpacity(0.5),
                decoration: const InputDecoration(
                    hintText: "Name", border: InputBorder.none),
                keyboardType: TextInputType.name,
                controller: _editPathInfoController.nameController,
                validator: (value) {
                  if (value!.isEmpty) {
                    return "Please enter name";
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

  Container distanceField() {
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
              Icons.abc,
              color: black.withOpacity(0.5),
            ),
            const SizedBox(
              width: 15,
            ),
            Flexible(
              child: TextFormField(
                cursorColor: black.withOpacity(0.5),
                decoration: const InputDecoration(
                    hintText: "Distance", border: InputBorder.none),
                keyboardType: TextInputType.number,
                controller: _editPathInfoController.distanceController,
                validator: (value) {
                  if (value!.isEmpty) {
                    return "Please enter Distance";
                  } else if (!value.isNum) {
                    return "Please input a number";
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

  Container elevationField() {
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
              Icons.abc,
              color: black.withOpacity(0.5),
            ),
            const SizedBox(
              width: 15,
            ),
            Flexible(
              child: TextFormField(
                cursorColor: black.withOpacity(0.5),
                decoration: const InputDecoration(
                    hintText: "Elevation", border: InputBorder.none),
                keyboardType: TextInputType.number,
                controller: _editPathInfoController.elevationController,
                validator: (value) {
                  if (value!.isEmpty) {
                    return "Please enter Elevation";
                  } else if (!value.isNum) {
                    return "Please input a number";
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

  Container difficultyField() {
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
              Icons.abc,
              color: black.withOpacity(0.5),
            ),
            const SizedBox(
              width: 15,
            ),
            Flexible(
              child: TextFormField(
                cursorColor: black.withOpacity(0.5),
                decoration: const InputDecoration(
                    hintText: "Difficulty", border: InputBorder.none),
                keyboardType: TextInputType.number,
                controller: _editPathInfoController.difficultyController,
                validator: (value) {
                  if (value!.isEmpty) {
                    return "Please enter Difficulty";
                  } else if (!value.isNum) {
                    return "Please input a number";
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

  Container pointsField() {
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
              Icons.abc,
              color: black.withOpacity(0.5),
            ),
            const SizedBox(
              width: 15,
            ),
            Flexible(
              child: TextFormField(
                cursorColor: black.withOpacity(0.5),
                decoration: const InputDecoration(
                    hintText: "Points", border: InputBorder.none),
                keyboardType: TextInputType.number,
                controller: _editPathInfoController.pointsController,
                validator: (value) {
                  if (value!.isEmpty) {
                    return "Please enter Points";
                  } else if (!value.isNum) {
                    return "Please input a number";
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

  Container timeLimitField() {
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
              Icons.abc,
              color: black.withOpacity(0.5),
            ),
            const SizedBox(
              width: 15,
            ),
            Flexible(
              child: TextFormField(
                cursorColor: black.withOpacity(0.5),
                decoration: const InputDecoration(
                    hintText: "Time Limit", border: InputBorder.none),
                keyboardType: TextInputType.number,
                controller: _editPathInfoController.timeLimitController,
                validator: (value) {
                  if (value!.isEmpty) {
                    return "Please enter time limit";
                  } else if (!value.isNum) {
                    return "Please input a number";
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

  Container updatePathInfoButton() {
    return Container(
      height: 50,
      width: double.infinity,
      decoration: BoxDecoration(
          gradient: const LinearGradient(colors: [fourthColor, thirdColor]),
          borderRadius: BorderRadius.circular(30)),
      child: const Row(
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
            "Update Path Info",
            style: TextStylePreset.btnSmallText,
          )
        ],
      ),
    );
  }

  Container deletePathButton() {
    return Container(
      height: 50,
      width: double.infinity,
      decoration: BoxDecoration(
          gradient: const LinearGradient(colors: [Colors.red, thirdColor]),
          borderRadius: BorderRadius.circular(30)),
      child: const Row(
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
            "Delete Path",
            style: TextStylePreset.btnSmallText,
          )
        ],
      ),
    );
  }
}
