import 'package:fitnessapp/fitness_app/controllers/Admin/checkpointListController.dart';
import 'package:fitnessapp/fitness_app/views/responsive_padding.dart';
import 'package:fitnessapp/theme/colors.dart';
import 'package:fitnessapp/theme/text_style.dart';
import 'package:fitnessapp/routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qr_flutter/qr_flutter.dart';

class CheckpointListPage extends StatefulWidget {
  const CheckpointListPage({Key? key}) : super(key: key);

  @override
  _CheckpointListPageState createState() => _CheckpointListPageState();
}

class _CheckpointListPageState extends State<CheckpointListPage> {
  final _checkpointListController = Get.put(checkpointListController());

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return ResponsivePadding(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: RefreshIndicator(
          child: SafeArea(child: getBody()),
          onRefresh: () {
            return Future.delayed(
              Duration(seconds: 1),
              () {
                //Refresh List
                _checkpointListController.refreshList();
              },
            );
          },
        ),
      ),
    );
  }

  Widget getBody() {
    return LayoutBuilder(builder: (context, constraints) {
      return ConstrainedBox(
        constraints: BoxConstraints(
          minHeight: constraints.maxHeight,
        ),
        child: ListView.builder(
          itemCount: 1,
          itemBuilder: (context, index) {
            return SingleChildScrollView(
                child: Container(
                    padding: const EdgeInsets.all(20),
                    // height: MediaQuery.of(context).size.height,
                    child: Column(
                      children: [
                        InkWell(
                          onTap: () {
                            Get.toNamed(Routes.add_checkpoint_info);
                          },
                          child: addCheckpointButton(),
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        const Text(
                          "Checkpoint List:",
                          style: TextStylePreset.bigTitle,
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        dataTable(),
                      ],
                    )));
          },
        ),
      );
    });
  }

  Widget dataTable() {
    return Obx(() => ListView.builder(
          shrinkWrap: true,
          primary: false,
          itemCount: _checkpointListController.checkpointList.length,
          scrollDirection: Axis.vertical,
          itemBuilder: (context, index) {
            return Card(
              color: Colors.blue.shade100,
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: ListTile(
                  title: Text(
                    _checkpointListController.checkpointList[index].name,
                    style: TextStylePreset.bigText,
                  ),
                  subtitle: Text(
                    _checkpointListController.checkpointList[index].location,
                    style: TextStylePreset.normalText,
                  ),
                  trailing: SizedBox(
                    height: 150,
                    width: 150,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Text(
                            "${_checkpointListController.checkpointList[index].type}",
                            style: const TextStyle(height: 5, fontSize: 12),
                            textAlign: TextAlign.center,
                          ),
                        ),
                        const SizedBox(
                          height: 5,
                          width: 5,
                        ),
                        SizedBox(
                            width: 100,
                            child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Expanded(
                                    child: InkWell(
                                      onTap: () {
                                        Get.toNamed(Routes.edit_checkpoint_info,
                                            arguments: _checkpointListController
                                                .checkpointList[index]);
                                      },
                                      child: editButton(),
                                    ),
                                  ),
                                  if (_checkpointListController
                                          .checkpointList[index].type ==
                                      "QR Code")
                                    const SizedBox(
                                      height: 5,
                                      width: 5,
                                    ),
                                  if (_checkpointListController
                                          .checkpointList[index].type ==
                                      "QR Code")
                                    Expanded(
                                      child: InkWell(
                                        onTap: () {
                                          Get.toNamed(Routes.checkpoint_qr,
                                              arguments:
                                                  _checkpointListController
                                                      .checkpointList[index].id
                                                      .toString());
                                        },
                                        child: qrButton(),
                                      ),
                                    ),
                                ])),
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        ));
  }

  Container editButton() {
    return Container(
      height: 80,
      width: 100,
      decoration: BoxDecoration(
          gradient: const LinearGradient(colors: [fourthColor, thirdColor]),
          borderRadius: BorderRadius.circular(30)),
      child: const Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "Edit",
            style: TextStylePreset.btnSmallText,
          )
        ],
      ),
    );
  }

  Container qrButton() {
    return Container(
      height: 80,
      width: 100,
      decoration: BoxDecoration(
          gradient: const LinearGradient(colors: [fourthColor, thirdColor]),
          borderRadius: BorderRadius.circular(30)),
      child: const Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "QR",
            style: TextStylePreset.btnSmallText,
          )
        ],
      ),
    );
  }

  Container addCheckpointButton() {
    return Container(
      height: 50,
      width: double.infinity,
      decoration: BoxDecoration(
          gradient: const LinearGradient(colors: [Colors.green, thirdColor]),
          borderRadius: BorderRadius.circular(30)),
      child: const Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.arrow_forward_sharp,
            color: white,
          ),
          SizedBox(
            width: 15,
          ),
          Text(
            "Add Checkpoint",
            style: TextStylePreset.btnBigText,
          )
        ],
      ),
    );
  }

  // List<DataRow> getRows(List<UserModel> students) =>
  //     students.map((UserModel student) {
  //       final cells = ["#"+, student.fullName, student.checkpointPoint];
  //       return DataRow(cells: getCells(cells));
  //     }).toList();
}
