import 'dart:convert';
import 'package:fitnessapp/fitness_app/models/Admin/pathModel.dart';
import 'package:fitnessapp/fitness_app/views/Admin/checkpoint_qr_image.dart';
import 'package:fitnessapp/theme/colors.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:fitnessapp/fitness_app/services/api_connection.dart';
import 'package:http/http.dart' as http;

class CheckpointQrPage extends StatefulWidget {
  const CheckpointQrPage({Key? key}) : super(key: key);

  @override
  _CheckpointQrPageState createState() => _CheckpointQrPageState();
}

class _CheckpointQrPageState extends State<CheckpointQrPage> {
  TextEditingController controller = TextEditingController();
  String checkpointID = Get.arguments;
  List<String> pathList = [];

  //methods
  Future getPathList() async {
    try {
      var res = await http.get(
        Uri.parse(Api.getPathList),
      );

      if (res.statusCode == 200) {
        var resBodyOfLogin = jsonDecode(res.body);
        pathList = [];
        if (resBodyOfLogin['success']) {
          List<PathModel> paths = await resBodyOfLogin["pathList"]
              .map<PathModel>((json) => PathModel.fromJson(json))
              .toList();
          for (PathModel path in paths) {
            if (path.type == "QR Code") {
              pathList.add(path.name.toString());
            }
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
    return Scaffold(
      appBar: AppBar(
        title: const Text('Flutter + QR code'),
        centerTitle: true,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            margin: const EdgeInsets.all(20),
            child: pathField(),
          ),
          //This button when pressed navigates to QR code generation
          ElevatedButton(
              onPressed: () async {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: ((context) {
                      return QRImage(controller, checkpointID);
                    }),
                  ),
                );
              },
              child: const Text('GENERATE QR CODE')),
        ],
      ),
    );
  }

  FutureBuilder pathField() {
    return FutureBuilder(
        future: Future.wait([getPathList()]),
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
              items: pathList.map((String items) {
                return DropdownMenuItem(
                  value: items,
                  child: Text(items),
                );
              }).toList(),
              onChanged: (String? newValue) {
                setState(() {
                  controller.text = newValue!;
                });
              },
              validator: (pathTypeValue) {
                if (pathTypeValue == null) {
                  return "Please select a path ID";
                }
                return null;
              },
            ),
          );
        });
  }
}
