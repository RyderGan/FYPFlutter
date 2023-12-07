import 'dart:convert';
import 'package:fitnessapp/fitness_app/controllers/Admin/addRfidBandInfoController.dart';
import 'package:fitnessapp/fitness_app/models/Admin/userModel.dart';
import 'package:fitnessapp/fitness_app/views/responsive_padding.dart';
import 'package:fitnessapp/theme/colors.dart';
import 'package:fitnessapp/theme/text_style.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:fitnessapp/fitness_app/services/api_connection.dart';
import 'package:http/http.dart' as http;

class AddRfidBandInfoPage extends StatefulWidget {
  const AddRfidBandInfoPage({Key? key}) : super(key: key);

  @override
  _AddRfidBandInfoPageState createState() => _AddRfidBandInfoPageState();
}

class _AddRfidBandInfoPageState extends State<AddRfidBandInfoPage> {
  final _addRfidBandInfoController = Get.put(addRfidBandInfoController());
  List<String> userList = [];

  //methods
  Future getUserList() async {
    try {
      var res = await http.get(
        Uri.parse(Api.getUserList),
      );

      if (res.statusCode == 200) {
        var resBodyOfLogin = jsonDecode(res.body);
        userList = [];
        if (resBodyOfLogin['success']) {
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
  Widget build(BuildContext context) {
    // TODO: implement build
    return ResponsivePadding(
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.white),
            onPressed: () => Get.back(),
          ),
          title: const Text("Add Rfid Band Information"),
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
                "Add Rfid Band",
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
      key: _addRfidBandInfoController.addRfidBandInfoFormKey,
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
              _addRfidBandInfoController.addRfidBand();
            },
            child: addRfidBandButton(),
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
                    hintText: "RFID Band Name", border: InputBorder.none),
                keyboardType: TextInputType.name,
                controller: _addRfidBandInfoController.nameController,
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
                controller: _addRfidBandInfoController.uidController,
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
                  _addRfidBandInfoController.userIDController.text = newValue!;
                });
              },
              validator: (userTypeValue) {
                if (userTypeValue == null) {
                  return "Please select a user ID";
                }
                return null;
              },
            ),
          );
        });
  }

  Container addRfidBandButton() {
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
            "Add RfidBand",
            style: TextStylePreset.btnSmallText,
          )
        ],
      ),
    );
  }
}
