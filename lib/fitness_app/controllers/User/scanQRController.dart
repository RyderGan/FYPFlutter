import 'dart:convert';
import 'package:fitnessapp/fitness_app/preferences/current_user.dart';
import 'package:fitnessapp/fitness_app/services/api_connection.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:http/http.dart' as http;

class scanQRController extends GetxController {
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  QRViewController? qrViewController;
  Barcode? barcode;
  int road = 0;
  int checkpoint = 0;
  String? result = "";
  CurrentUser _currentUser = Get.put(CurrentUser());

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onClose() {
    qrViewController?.dispose();
    super.dispose();
  }

  Future<void> recordCheckpoint(String url) async {
    Uri uri = new Uri.dataFromString(url);
    String? road = uri.queryParameters['r'];
    String? checkpoint = uri.queryParameters['c'];
    try {
      var res = await http.post(
        Uri.parse(Api.recordUserCheckpoint),
        body: {
          'userID': _currentUser.user.id.toString(),
          'road': road,
          'checkpoint': checkpoint,
        },
      );

      if (res.statusCode == 200) {
        var resBody = jsonDecode(res.body);
        if (resBody['success']) {
          String message = resBody['message'];
          Fluttertoast.showToast(msg: message);
        } else {
          Fluttertoast.showToast(msg: "Error occurred");
        }
      }
    } catch (e) {
      print(e.toString());
      Fluttertoast.showToast(msg: e.toString());
    }
  }
}
