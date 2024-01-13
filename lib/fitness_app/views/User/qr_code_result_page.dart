import 'dart:io';

import 'package:fitnessapp/fitness_app/controllers/User/scanQRController.dart';
import 'package:fitnessapp/fitness_app/views/responsive_padding.dart';
import 'package:fitnessapp/routes.dart';
import 'package:fitnessapp/theme/colors.dart';
import 'package:fitnessapp/theme/text_style.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:url_launcher/url_launcher.dart';

class QRCodeResultPage extends StatefulWidget {
  const QRCodeResultPage({Key? key}) : super(key: key);

  @override
  _QRCodeResultPageState createState() => _QRCodeResultPageState();
}

class _QRCodeResultPageState extends State<QRCodeResultPage> {
  final _scanQRController = Get.put(scanQRController());

  // @override
  // void reassemble() async {
  //   super.reassemble();

  //   if (Platform.isAndroid) {
  //     await _scanQRController.qrViewController!.pauseCamera();
  //   }
  //   _scanQRController.qrViewController!.resumeCamera();
  // }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return ResponsivePadding(
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(Icons.arrow_back, color: Colors.white),
            onPressed: () => Get.back(),
          ),
          title: const Text("QR code result"),
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
          child: Container(
            padding: const EdgeInsets.all(20),
            height: MediaQuery.of(context).size.height,
            child: Column(children: [
              result(),
            ]),
          ));
    });
  }

  Widget result() {
    return Container(
      child: Column(
        children: [
          Text(
            _scanQRController.result != null
                ? getQRCodeInfo(_scanQRController.result!)
                : 'No result',
            style: TextStylePreset.bigText,
          ),
          SizedBox(
            height: 30,
          ),
          InkWell(
            onTap: () {
              _scanQRController.recordCheckpoint(_scanQRController.result!);
              Get.back();
            },
            child: openLinkButton(),
          ),
        ],
      ),
    );
  }

  String getQRCodeInfo(String url) {
    Uri uri = new Uri.dataFromString(url);
    String? path = uri.queryParameters['p'];
    String? checkpoint = uri.queryParameters['c'];
    return "Path $path Checkpoint $checkpoint";
  }

  Container openLinkButton() {
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
            "Record Checkpoint",
            style: TextStylePreset.btnSmallText,
          )
        ],
      ),
    );
  }
}
