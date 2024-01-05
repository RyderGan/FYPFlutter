import 'package:fitnessapp/fitness_app/controllers/Admin/pathListController.dart';
import 'package:fitnessapp/fitness_app/views/responsive_padding.dart';
import 'package:fitnessapp/theme/colors.dart';
import 'package:fitnessapp/theme/text_style.dart';
import 'package:fitnessapp/routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PathListPage extends StatefulWidget {
  const PathListPage({Key? key}) : super(key: key);

  @override
  _PathListPageState createState() => _PathListPageState();
}

class _PathListPageState extends State<PathListPage> {
  final _pathListController = Get.put(pathListController());

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return ResponsivePadding(
      child: Scaffold(
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
              child: Container(
                  padding: const EdgeInsets.all(20),
                  height: MediaQuery.of(context).size.height,
                  child: Column(
                    children: [
                      InkWell(
                        onTap: () {
                          Get.toNamed(Routes.add_path_info);
                        },
                        child: addPathButton(),
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      const Text(
                        "Path List:",
                        style: TextStylePreset.bigTitle,
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      dataTable(),
                    ],
                  ))));
    });
  }

  Widget dataTable() {
    return Obx(() => ListView.builder(
          shrinkWrap: true,
          primary: false,
          itemCount: _pathListController.pathList.length,
          scrollDirection: Axis.vertical,
          itemBuilder: (context, index) {
            return Card(
              color: Colors.blue.shade100,
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: ListTile(
                  title: Text(
                    _pathListController.pathList[index].name,
                    style: TextStylePreset.bigText,
                  ),
                  subtitle: Text(
                    _pathListController.pathList[index].distance.toString(),
                    style: TextStylePreset.normalText,
                  ),
                  trailing: SizedBox(
                    width: 125,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Text(
                            "${_pathListController.pathList[index].path_id}",
                            style: const TextStyle(height: 5, fontSize: 10),
                          ),
                        ),
                        Expanded(
                          child: InkWell(
                            onTap: () {
                              Get.toNamed(Routes.edit_path_info, arguments: [
                                _pathListController.pathList[index],
                                _pathListController.getCheckpointName(
                                    _pathListController
                                        .pathList[index].fromCpID),
                                _pathListController.getCheckpointName(
                                    _pathListController.pathList[index].toCpID)
                              ]);
                            },
                            child: editButton(),
                          ),
                        ),
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
      height: 40,
      width: 50,
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

  Container addPathButton() {
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
            "Add Path",
            style: TextStylePreset.btnBigText,
          )
        ],
      ),
    );
  }

  // List<DataRow> getRows(List<UserModel> students) =>
  //     students.map((UserModel student) {
  //       final cells = ["#"+, student.fullName, student.pathPoint];
  //       return DataRow(cells: getCells(cells));
  //     }).toList();
}
