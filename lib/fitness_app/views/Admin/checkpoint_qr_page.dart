import 'package:fitnessapp/fitness_app/views/Admin/checkpoint_qr_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CheckpointQrPage extends StatefulWidget {
  const CheckpointQrPage({Key? key}) : super(key: key);

  @override
  _CheckpointQrPageState createState() => _CheckpointQrPageState();
}

class _CheckpointQrPageState extends State<CheckpointQrPage> {
  TextEditingController controller = TextEditingController();
  String checkpointID = Get.arguments;

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
            child: TextField(
              controller: controller,
              decoration: const InputDecoration(
                  border: OutlineInputBorder(), labelText: 'Enter the path id'),
            ),
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
}
