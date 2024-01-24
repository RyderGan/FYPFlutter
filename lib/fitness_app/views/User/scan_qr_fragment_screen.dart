import 'package:fitnessapp/fitness_app/controllers/User/scanQRController.dart';
import 'package:fitnessapp/fitness_app/views/responsive_padding.dart';
import 'package:fitnessapp/routes.dart';
import 'package:fitnessapp/theme/colors.dart';
import 'package:fitnessapp/theme/text_style.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

class ScanQRFragmentScreen extends StatefulWidget {
  const ScanQRFragmentScreen({Key? key}) : super(key: key);

  @override
  _ScanQRFragmentScreenState createState() => _ScanQRFragmentScreenState();
}

class _ScanQRFragmentScreenState extends State<ScanQRFragmentScreen> {
  final _scanQRController = Get.put(scanQRController());
  bool isWeb = GetPlatform.isWeb;

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
        // appBar: AppBar(
        //   leading: IconButton(
        //     icon: Icon(Icons.arrow_back, color: Colors.black),
        //     onPressed: () => Get.back(),
        //   ),
        //   title: const Text("Scan QR code"),
        // ),
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
          minWidth: double.infinity,
        ),
        child: Stack(
          alignment: Alignment.center,
          children: [
            if (!isWeb)
              QRView(
                key: _scanQRController.qrKey,
                onQRViewCreated: onQRViewCreated,
                overlay: QrScannerOverlayShape(
                  borderColor: primary,
                  borderRadius: 10,
                  borderLength: 20,
                  borderWidth: 10,
                  cutOutSize: MediaQuery.of(context).size.width * 0.8,
                ),
              ),
            if (!isWeb)
              Positioned(bottom: 10, child: buildResult())
            else
              displayNotAvailable(),
          ],
        ),
      );
    });
  }

  Container displayNotAvailable() {
    return Container(
      child: SingleChildScrollView(
          child: Container(
              padding: const EdgeInsets.all(20),
              // height: MediaQuery.of(context).size.height,
              child: Column(
                children: [
                  Text(
                    "Scan QR Module is only available inside the App",
                    style: TextStylePreset.bigTitle,
                  ),
                ],
              ))),
    );
  }

  void onQRViewCreated(QRViewController controller) {
    setState(() {
      _scanQRController.qrViewController = controller;
      _scanQRController.qrViewController?.scannedDataStream.listen((barcode) {
        setState(() {
          _scanQRController.barcode = barcode;
          _scanQRController.result = _scanQRController.barcode!.code;
          print(_scanQRController.result);
        });

        // Handle the scanned data as desired
        Get.toNamed(Routes.qr_code_result_page);
      });
    });
  }

  Widget buildResult() {
    return Container(
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: Colors.white24,
      ),
      child: Text(
        _scanQRController.barcode != null
            ? 'QR code scanned' //${_scanQRController.barcode!.code}, Result: QR code scanned
            : 'Scan a QR code',
        maxLines: 3,
        style: const TextStyle(color: Colors.white),
      ),
    );
  }
}
