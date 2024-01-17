import 'dart:io';
import 'dart:convert';
import 'package:fitnessapp/fitness_app/models/Admin/pathModel.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:screenshot/screenshot.dart';
import 'package:fitnessapp/fitness_app/services/api_connection.dart';
import 'package:http/http.dart' as http;

class QRImage extends StatefulWidget {
  const QRImage(this.controller, this.checkpointID, {super.key});
  final TextEditingController controller;
  final String checkpointID;

  @override
  State<QRImage> createState() => _QRImageState();
}

class _QRImageState extends State<QRImage> {
  final _screenshotController = ScreenshotController();
  Future<Image>? image;
  List<String> pathList = [];
  String pathID = "";

  Future<void> getPathID() async {
    String findPathID = "";
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
            if (path.name.toString() == widget.controller.text.trim()) {
              findPathID = path.id.toString();
            }
          }
        }
      }
    } catch (e) {
      print(e.toString());
      Fluttertoast.showToast(msg: e.toString());
    }
    pathID = findPathID;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: Future.wait([getPathID()]),
        builder: (context, constraints) {
          return Scaffold(
              appBar: AppBar(
                title: const Text('Checkpoint QR code'),
                centerTitle: true,
              ),
              body: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // TextButton(
                  //     onPressed: () async {
                  //       await _captureAndSaveQRCode();
                  //     },
                  //     child: const Text("capture qr code")),
                  if (image != null)
                    Center(
                        child: Screenshot(
                      controller: _screenshotController,
                      child: QrImageView(
                        data:
                            "http://192.168.0.208:8080/api_healthApp/user/recordCheckpoint.php?p=" +
                                pathID +
                                "&c=" +
                                widget.checkpointID,
                        size: 280,
                        // You can include embeddedImageStyle Property if you
                        //wanna embed an image from your Asset folder
                        embeddedImageStyle: QrEmbeddedImageStyle(
                          size: const Size(
                            100,
                            100,
                          ),
                        ),
                      ),
                    )),
                ],
              ));
        });
  }

  Future<String> get imagePath async {
    final directory = Platform.isAndroid
        ? await getExternalStorageDirectory() //FOR ANDROID
        : await getApplicationDocumentsDirectory(); //FOR iOS
    print(directory);
    return '$directory/qr.png';
  }

  Future<Image> _loadImage() async {
    return await imagePath.then((imagePath) => Image.asset(imagePath));
  }

  Future<void> _captureAndSaveQRCode() async {
    final imageDirectory = await imagePath;
    if (await Permission.storage.request().isGranted) {
      _screenshotController.captureAndSave(imageDirectory);
      setState(() {
        image = _loadImage();
      });
    } else {
      Fluttertoast.showToast(msg: "Storage Permission not Granted");
    }
  }

  @override
  void initState() {
    image = _loadImage();
    super.initState();
  }
}
