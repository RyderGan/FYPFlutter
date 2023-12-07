import 'dart:convert';
import 'package:fitnessapp/fitness_app/controllers/Admin/addPathInfoController.dart';
import 'package:fitnessapp/fitness_app/views/responsive_padding.dart';
import 'package:fitnessapp/theme/colors.dart';
import 'package:fitnessapp/theme/text_style.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:fitnessapp/fitness_app/models/Admin/rfidCheckpointModel.dart';
import 'package:fitnessapp/fitness_app/services/api_connection.dart';
import 'package:http/http.dart' as http;

class AddPathInfoPage extends StatefulWidget {
  const AddPathInfoPage({Key? key}) : super(key: key);

  @override
  _AddPathInfoPageState createState() => _AddPathInfoPageState();
}

class _AddPathInfoPageState extends State<AddPathInfoPage> {
  final _addPathInfoController = Get.put(addPathInfoController());
  List<String> checkpointList = [];

  //methods
  Future getAllCheckpoints() async {
    try {
      var res = await http.get(
        Uri.parse(Api.getRfidCheckpointList),
      );

      if (res.statusCode == 200) {
        var resBodyOfLogin = jsonDecode(res.body);
        if (resBodyOfLogin['success']) {
          checkpointList = [];
          List<RfidCheckpointModel> checkpoints =
              await resBodyOfLogin["rfidCheckpointList"]
                  .map<RfidCheckpointModel>(
                      (json) => RfidCheckpointModel.fromJson(json))
                  .toList();
          for (RfidCheckpointModel checkpoint in checkpoints) {
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
  Widget build(BuildContext context) {
    // TODO: implement build
    return ResponsivePadding(
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.white),
            onPressed: () => Get.back(),
          ),
          title: const Text("Add Path Information"),
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
                "Add Path",
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
      key: _addPathInfoController.addPathInfoFormKey,
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
              _addPathInfoController.addPath();
            },
            child: addPathButton(),
          ),
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
                controller: _addPathInfoController.nameController,
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
                  _addPathInfoController.fromCpIDController.text = newValue!;
                });
              },
              validator: (userTypeValue) {
                if (userTypeValue == null) {
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
                  _addPathInfoController.toCpIDController.text = newValue!;
                });
              },
              validator: (userTypeValue) {
                if (userTypeValue == null) {
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
                controller: _addPathInfoController.distanceController,
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
                controller: _addPathInfoController.elevationController,
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
                controller: _addPathInfoController.difficultyController,
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

  Container addPathButton() {
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
            "Add Path",
            style: TextStylePreset.btnSmallText,
          )
        ],
      ),
    );
  }

  // Need to add state
  // Container userTypeField() {
  //   return Container(
  //     decoration: BoxDecoration(
  //       borderRadius: BorderRadius.circular(15.0),
  //       border: Border.all(color: black.withOpacity(0.1)),
  //     ),
  //     child: DropdownButtonFormField(
  //       decoration: const InputDecoration(
  //         border: InputBorder.none,
  //         prefixIcon: Icon(Icons.person),
  //       ),
  //       padding: const EdgeInsets.only(right: 10),
  //       value: userTypeValue,
  //       icon: const Icon(Icons.keyboard_arrow_down),
  //       isExpanded: true,
  //       items: users.map((String items) {
  //         return DropdownMenuItem(
  //           value: items,
  //           child: Text(items),
  //         );
  //       }).toList(),
  //       onChanged: (String? newValue) {
  //         setState(() {
  //           userTypeValue = newValue!;
  //           _registerController.userTypeValue.value = userTypeValue;
  //         });
  //       },
  //       validator: (userTypeValue) {
  //         if (userTypeValue == "Select user") {
  //           return "Please select a user";
  //         }
  //         return null;
  //       },
  //     ),
  //   );
  // }

  // Container emailField() {
  //   return Container(
  //     height: 50,
  //     width: double.infinity,
  //     decoration: BoxDecoration(
  //         color: bgTextField, borderRadius: BorderRadius.circular(12)),
  //     child: Padding(
  //       padding: const EdgeInsets.only(left: 10, right: 10),
  //       child: Row(
  //         children: [
  //           Icon(
  //             LineIcons.envelope,
  //             color: black.withOpacity(0.5),
  //           ),
  //           const SizedBox(
  //             width: 15,
  //           ),
  //           Flexible(
  //             child: TextFormField(
  //               cursorColor: black.withOpacity(0.5),
  //               decoration: const InputDecoration(
  //                   hintText: "Email", border: InputBorder.none),
  //               keyboardType: TextInputType.emailAddress,
  //               controller: _registerController.emailController,
  //               onSaved: (value) {
  //                 _registerController.email = value!; //! is null check operator
  //               },
  //               validator: (value) {
  //                 return _registerController.validateEmail(value!);
  //               },
  //             ),
  //           ),
  //         ],
  //       ),
  //     ),
  //   );
  // }

  // Container passwordField() {
  //   return Container(
  //     height: 50,
  //     width: double.infinity,
  //     decoration: BoxDecoration(
  //         color: bgTextField, borderRadius: BorderRadius.circular(12)),
  //     child: Padding(
  //       padding: const EdgeInsets.only(left: 10),
  //       child: Row(
  //         children: [
  //           Icon(
  //             LineIcons.lock,
  //             color: black.withOpacity(0.5),
  //           ),
  //           const SizedBox(
  //             width: 15,
  //           ),
  //           Flexible(
  //             child: TextFormField(
  //               cursorColor: black.withOpacity(0.5),
  //               decoration: const InputDecoration(
  //                   hintText: 'Password', border: InputBorder.none),
  //               obscureText: _obscureText,
  //               keyboardType: TextInputType.visiblePassword,
  //               controller: _registerController.passwordController,
  //               onSaved: (value) {
  //                 _registerController.password =
  //                     value!; //! is null check operator
  //               },
  //               validator: (value) {
  //                 return _registerController.validatePassword(value!);
  //               },
  //             ),
  //           ),
  //           IconButton(
  //               onPressed: _toggle,
  //               icon: Icon(
  //                 LineIcons.eyeAlt,
  //                 color: black.withOpacity(0.5),
  //               ))
  //         ],
  //       ),
  //     ),
  //   );
  // }
}
