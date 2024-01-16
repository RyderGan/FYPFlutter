import 'package:fitnessapp/fitness_app/controllers/User/studentRankingController.dart';
import 'package:fitnessapp/fitness_app/models/User/userModel.dart';
import 'package:fitnessapp/fitness_app/views/responsive_padding.dart';
import 'package:fitnessapp/theme/colors.dart';
import 'package:fitnessapp/theme/text_style.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class StudentRankingPage extends StatefulWidget {
  const StudentRankingPage({Key? key}) : super(key: key);

  @override
  _StudentRankingPageState createState() => _StudentRankingPageState();
}

class _StudentRankingPageState extends State<StudentRankingPage> {
  final _studentRankingsController = Get.put(studentRankingsController());

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
          title: const Text("Student Ranking"),
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
              child: Container(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    children: [
                      dataTable(),
                    ],
                  ))));
    });
  }

  Widget dataTable() {
    List<UserModel> students = _studentRankingsController.allStudents;
    return Obx(() => DataTable(
          columns: const [
            DataColumn(
              label: SizedBox(
                width: 25,
                child: Text('Pos'),
              ),
            ),
            DataColumn(
              label: SizedBox(
                width: 145,
                child: Text('Name'),
              ),
            ),
            DataColumn(
              label: SizedBox(
                width: 40,
                child: Text('Points'),
              ),
            ),
          ],
          rows: List<DataRow>.generate(
            students.length,
            (index) => DataRow(
              cells: [
                DataCell(Text(
                  (index + 1).toString(),
                  style: TextStylePreset.bigText,
                )), // Index column
                DataCell(Text(
                  students[index].fullName.toString(),
                  style: TextStylePreset.bigText,
                )),
                DataCell(Text(
                  students[index].rewardPoint.toString(),
                  style: TextStylePreset.bigText,
                )),
              ],
            ),
          ),
        ));
  }

  List<DataColumn> getColumns(List<String> columns) => columns
      .map((String column) => DataColumn(
            label: Text(column),
          ))
      .toList();

  // List<DataRow> getRows(List<UserModel> students) =>
  //     students.map((UserModel student) {
  //       final cells = ["#"+, student.fullName, student.rewardPoint];
  //       return DataRow(cells: getCells(cells));
  //     }).toList();
}
