import 'dart:convert';
import 'package:fitnessapp/fitness_app/controllers/Admin/editPathInfoController(old).dart';
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
  String fromCpIDValue = "Checkpoint 1";
  String toCpIDValue = "Checkpoint 2";
  var arguments = Get.arguments;
  Future<String> fromCpIDValue1 = Get.arguments[1];
  Future<String> toCpIDValue1 = Get.arguments[2];

  Future getAllCheckpoints() async {
    try {
      var res = await http.get(
        Uri.parse(Api.getCheckpointList),
      );

      if (res.statusCode == 200) {
        var resBodyOfLogin = jsonDecode(res.body);
        if (resBodyOfLogin['success']) {
          checkpointList = [];
          List<CheckpointModel> checkpoints =
              await resBodyOfLogin["checkpointList"]
                  .map<CheckpointModel>(
                      (json) => CheckpointModel.fromJson(json))
                  .toList();
          for (CheckpointModel checkpoint in checkpoints) {
            checkpointList.add(checkpoint.name.toString());
          }
        }
      }
    } catch (e) {
      print(e.toString());
      Fluttertoast.showToast(msg: e.toString());
    }
  }

  @override
  void initState() {
    fromCpIDValue1.then((value) => fromCpIDValue = value);
    toCpIDValue1.then((value) => toCpIDValue = value);
    fromCpIDValue1.then(
        (value) => _editPathInfoController.fromCpIDController.text = value);
    toCpIDValue1
        .then((value) => _editPathInfoController.toCpIDController.text = value);
    super.initState();
    getAllCheckpoints();
  }
  //methods

  @override
  Widget build(BuildContext context) {
    _editPathInfoController.setPathDetails(arguments[0]);
    // fromCpIDValue =
    //     _editPathInfoController.getCheckpointName(arguments[0].fromCpID);
    // toCpIDValue = _editPathInfoController.getCheckpointName(arguments[0].toCpID);
    // TODO: implement build
    return ResponsivePadding(
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.black),
            onPressed: () => Get.back(),
          ),
          title: const Text("Edit Path Information"),
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
          fromCpIDField(),
          const SizedBox(
            height: 15,
          ),
          toCpIDField(),
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
          InkWell(
            onTap: () {
              _editPathInfoController.updatePathInfo(arguments[0]);
            },
            child: updatePathInfoButton(),
          ),
          const SizedBox(
            height: 15,
          ),
          InkWell(
            onTap: () {
              _editPathInfoController.deletePath(arguments[0]);
            },
            child: deletePathButton(),
          )
        ],
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

  FutureBuilder fromCpIDField() {
    return FutureBuilder(
        future: Future.wait([getAllCheckpoints()]),
        builder: (context, constraints) {
          return Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15.0),
              border: Border.all(color: black.withOpacity(0.1)),
            ),
            child: DropdownButtonFormField(
              decoration: const InputDecoration(
                prefixIcon: Icon(Icons.location_pin),
              ),
              padding: const EdgeInsets.only(left: 10, right: 10),
              value: fromCpIDValue,
              icon: const Icon(Icons.keyboard_arrow_down),
              isExpanded: true,
              items: checkpointList.map((String items) {
                return DropdownMenuItem(
                  value: items,
                  child: Text(items),
                );
              }).toList(),
              onChanged: (String? newValue) {
                setState(() {
                  fromCpIDValue = newValue!;
                  _editPathInfoController.fromCpIDController.text = newValue;
                });
              },
              validator: (userTypeValue) {
                if (userTypeValue == "Select CP ID") {
                  return "Please select a CP ID";
                }
                return null;
              },
            ),
          );
        });
  }

  FutureBuilder toCpIDField() {
    return FutureBuilder(
        future: Future.wait([getAllCheckpoints()]),
        builder: (context, constraints) {
          return Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15.0),
              border: Border.all(color: black.withOpacity(0.1)),
            ),
            child: DropdownButtonFormField(
              decoration: const InputDecoration(
                prefixIcon: Icon(Icons.location_pin),
              ),
              padding: const EdgeInsets.only(left: 10, right: 10),
              value: toCpIDValue,
              icon: const Icon(Icons.keyboard_arrow_down),
              isExpanded: true,
              items: checkpointList.map((String items) {
                return DropdownMenuItem(
                  value: items,
                  child: Text(items),
                );
              }).toList(),
              onChanged: (String? newValue) {
                setState(() {
                  toCpIDValue = newValue!;
                  _editPathInfoController.toCpIDController.text = newValue;
                });
              },
              validator: (userTypeValue) {
                if (userTypeValue == "Select CP ID") {
                  return "Please select a CP ID";
                }
                return null;
              },
            ),
          );
        });
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
