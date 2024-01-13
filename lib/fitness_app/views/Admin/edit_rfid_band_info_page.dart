import 'dart:convert';
import 'package:fitnessapp/fitness_app/controllers/Admin/editRfidBandInfoController.dart';
import 'package:fitnessapp/fitness_app/models/Admin/userModel.dart';
import 'package:fitnessapp/fitness_app/views/responsive_padding.dart';
import 'package:fitnessapp/theme/colors.dart';
import 'package:fitnessapp/theme/text_style.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:fitnessapp/fitness_app/services/api_connection.dart';
import 'package:http/http.dart' as http;

class EditRfidBandInfoPage extends StatefulWidget {
  const EditRfidBandInfoPage({Key? key}) : super(key: key);

  @override
  _EditRfidBandInfoPageState createState() => _EditRfidBandInfoPageState();
}

class _EditRfidBandInfoPageState extends State<EditRfidBandInfoPage> {
  final _editRfidBandInfoController = Get.put(EditRfidBandInfoController());
  List<String> userList = ["Select user ID"];
  String userIDValue = "Select user ID";
  var arguments = Get.arguments;
  Future<String> userIDValue1 = Get.arguments[1];

  Future getUserList() async {
    try {
      var res = await http.get(
        Uri.parse(Api.getUserList),
      );

      if (res.statusCode == 200) {
        var resBodyOfLogin = jsonDecode(res.body);
        if (resBodyOfLogin['success']) {
          userList = ["Select user ID"];
          List<UserModel> users = await resBodyOfLogin["userList"]
              .map<UserModel>((json) => UserModel.fromJson(json))
              .toList();
          for (UserModel user in users) {
            userList.add(user.email.toString());
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
    userIDValue1.then((value) => userIDValue = value);
    userIDValue1.then(
        (value) => _editRfidBandInfoController.userIDController.text = value);
    super.initState();
    getUserList();
  }
  //methods

  @override
  Widget build(BuildContext context) {
    _editRfidBandInfoController.setRfidBandDetails(arguments[0]);
    // userIDValue =
    //     _editRfidBandInfoController.getCheckpointName(arguments[0].fromCpID);
    // toCpIDValue = _editRfidBandInfoController.getCheckpointName(arguments[0].toCpID);
    // TODO: implement build
    return ResponsivePadding(
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.white),
            onPressed: () => Get.back(),
          ),
          title: const Text("Edit Rfid Band Information"),
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
                "Edit Rfid Band info",
                style: TextStylePreset.bigTitle,
              ),
              const SizedBox(
                height: 15,
              ),
              rfidBandInfoForm(),
            ]),
          ),
        ),
      );
    });
  }

  Form rfidBandInfoForm() {
    return Form(
      key: _editRfidBandInfoController.editRfidBandInfoFormKey,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      child: Column(
        children: [
          nameField(),
          const SizedBox(
            height: 15,
          ),
          uidField(),
          const SizedBox(
            height: 15,
          ),
          userIDField(),
          const SizedBox(
            height: 15,
          ),
          InkWell(
            onTap: () {
              _editRfidBandInfoController.updateRfidBandInfo(arguments[0]);
            },
            child: updateRfidBandInfoButton(),
          ),
          const SizedBox(
            height: 15,
          ),
          InkWell(
            onTap: () {
              _editRfidBandInfoController.deleteRfidBand(arguments[0]);
            },
            child: deleteRfidBandButton(),
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
                    hintText: "RFID Band Name", border: InputBorder.none),
                keyboardType: TextInputType.name,
                controller: _editRfidBandInfoController.nameController,
                validator: (value) {
                  if (value!.isEmpty) {
                    return "Please enter RFID Band name";
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

  Container uidField() {
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
                    hintText: "RFID Band UID", border: InputBorder.none),
                keyboardType: TextInputType.text,
                controller: _editRfidBandInfoController.uidController,
                validator: (value) {
                  if (value!.isEmpty) {
                    return "Please enter RFID Band UID";
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

  FutureBuilder userIDField() {
    return FutureBuilder(
        future: Future.wait([getUserList()]),
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
              value: userIDValue,
              icon: const Icon(Icons.keyboard_arrow_down),
              isExpanded: true,
              items: userList.map((String items) {
                return DropdownMenuItem(
                  value: items,
                  child: Text(items),
                );
              }).toList(),
              onChanged: (String? newValue) {
                setState(() {
                  userIDValue = newValue!;
                  _editRfidBandInfoController.userIDController.text = newValue;
                });
              },
              validator: (userTypeValue) {
                return null;
              },
            ),
          );
        });
  }

  Container updateRfidBandInfoButton() {
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
            "Update Rfid Band Info",
            style: TextStylePreset.btnSmallText,
          )
        ],
      ),
    );
  }

  Container deleteRfidBandButton() {
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
            "Delete Rfid Band",
            style: TextStylePreset.btnSmallText,
          )
        ],
      ),
    );
  }
}
