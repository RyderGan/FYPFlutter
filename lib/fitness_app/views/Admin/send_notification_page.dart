import 'dart:convert';
import 'package:fitnessapp/fitness_app/controllers/Admin/sendNotificationController.dart';
import 'package:fitnessapp/fitness_app/models/User/userModel.dart';
import 'package:fitnessapp/fitness_app/views/responsive_padding.dart';
import 'package:fitnessapp/theme/colors.dart';
import 'package:fitnessapp/theme/text_style.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:fitnessapp/fitness_app/services/api_connection.dart';
import 'package:http/http.dart' as http;

class SendNotificationPage extends StatefulWidget {
  const SendNotificationPage({Key? key}) : super(key: key);

  @override
  _SendNotificationPageState createState() => _SendNotificationPageState();
}

class _SendNotificationPageState extends State<SendNotificationPage> {
  final _sendNotificationController = Get.put(sendNotificationController());
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
            icon: const Icon(Icons.arrow_back, color: Colors.black),
            onPressed: () => Get.back(),
          ),
          title: const Text("Send notification"),
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
                "Send Notification",
                style: TextStylePreset.bigTitle,
              ),
              const SizedBox(
                height: 15,
              ),
              notificationForm(),
              const SizedBox(
                height: 45,
              ),
              const SizedBox(
                height: 15,
              ),
            ]),
          ),
        ),
      );
    });
  }

  Form notificationForm() {
    return Form(
      key: _sendNotificationController.sendNotificationFormKey,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      child: Column(
        children: [
          userIDField(),
          const SizedBox(
            height: 15,
          ),
          messageField(),
          const SizedBox(
            height: 15,
          ),
          InkWell(
            onTap: () {
              _sendNotificationController.sendNotification();
            },
            child: sendNotificationButton(),
          )
        ],
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
                  _sendNotificationController.userIDController.text = newValue!;
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

  Container messageField() {
    return Container(
      height: 100,
      width: double.infinity,
      decoration: BoxDecoration(
          color: bgTextField, borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.only(left: 10, right: 10),
        child: Row(
          children: [
            Icon(
              Icons.message,
              color: black.withOpacity(0.5),
            ),
            const SizedBox(
              width: 15,
            ),
            Flexible(
              child: TextFormField(
                cursorColor: black.withOpacity(0.5),
                decoration: const InputDecoration(
                  hintText: "Message",
                  border: InputBorder.none,
                ),
                keyboardType: TextInputType.text,
                minLines: 2, // Set this
                maxLines: 10, // and this
                controller: _sendNotificationController.messageController,
                validator: (value) {
                  return _sendNotificationController
                      .validateDescription(value!);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Container sendNotificationButton() {
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
            "Add Notification",
            style: TextStylePreset.btnSmallText,
          )
        ],
      ),
    );
  }
}
