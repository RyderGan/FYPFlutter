import 'dart:convert';
import 'package:fitnessapp/fitness_app/controllers/Admin/setListController.dart';
import 'package:fitnessapp/fitness_app/models/Admin/pathModel.dart';
import 'package:fitnessapp/fitness_app/views/responsive_padding.dart';
import 'package:fitnessapp/theme/colors.dart';
import 'package:fitnessapp/theme/text_style.dart';
import 'package:fitnessapp/routes.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:fitnessapp/fitness_app/services/api_connection.dart';
import 'package:http/http.dart' as http;

class SetListPage extends StatefulWidget {
  const SetListPage({Key? key}) : super(key: key);

  @override
  _SetListPageState createState() => _SetListPageState();
}

class _SetListPageState extends State<SetListPage> {
  final _setListController = Get.put(setListController());

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
                _setListController.refreshList();
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
                        const SizedBox(
                          height: 15,
                        ),
                        InkWell(
                          onTap: () {
                            Get.toNamed(Routes.add_set_info);
                          },
                          child: addSetButton(),
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        const Text(
                          "Set List:",
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
          itemCount: _setListController.setList.length,
          scrollDirection: Axis.vertical,
          itemBuilder: (context, index) {
            return Card(
              color: Colors.blue.shade100,
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: ListTile(
                  title: Text(
                    _setListController.setList[index].name,
                    style: TextStylePreset.bigText,
                  ),
                  subtitle: Text(
                    _setListController.setList[index].bonus_points.toString(),
                    style: TextStylePreset.normalText,
                  ),
                  trailing: SizedBox(
                    height: 150,
                    width: 180,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Text(
                            "${_setListController.setList[index].type}",
                            style: const TextStyle(height: 5, fontSize: 10),
                            textAlign: TextAlign.left,
                          ),
                        ),
                        const SizedBox(
                          width: 2,
                        ),
                        SizedBox(
                            width: 100,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  child: InkWell(
                                    onTap: () {
                                      Get.toNamed(Routes.edit_set_info,
                                          arguments: _setListController
                                              .setList[index]);
                                    },
                                    child: editButton(),
                                  ),
                                ),
                                const SizedBox(
                                  height: 8,
                                ),
                                Expanded(
                                  child: InkWell(
                                    onTap: () {
                                      Get.toNamed(Routes.edit_set_paths,
                                          arguments: [
                                            _setListController.setList[index],
                                            _setListController.getCurrentPaths(
                                                _setListController
                                                    .setList[index])
                                          ]);
                                    },
                                    child: editPathOrderButton(),
                                  ),
                                ),
                              ],
                            ))
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

  Container editPathOrderButton() {
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
            "Path",
            style: TextStylePreset.btnSmallText,
          )
        ],
      ),
    );
  }

  Container addSetButton() {
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
            "Add Set",
            style: TextStylePreset.btnBigText,
          )
        ],
      ),
    );
  }

  // List<DataRow> getRows(List<UserModel> students) =>
  //     students.map((UserModel student) {
  //       final cells = ["#"+, student.fullName, student.setPoint];
  //       return DataRow(cells: getCells(cells));
  //     }).toList();
}
