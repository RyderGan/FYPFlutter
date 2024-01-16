import 'package:fitnessapp/fitness_app/controllers/User/staffRankingController.dart';
import 'package:fitnessapp/fitness_app/models/User/userModel.dart';
import 'package:fitnessapp/fitness_app/views/responsive_padding.dart';
import 'package:fitnessapp/theme/colors.dart';
import 'package:fitnessapp/theme/text_style.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class StaffRankingPage extends StatefulWidget {
  const StaffRankingPage({Key? key}) : super(key: key);

  @override
  _StaffRankingPageState createState() => _StaffRankingPageState();
}

class _StaffRankingPageState extends State<StaffRankingPage> {
  final _staffRankingsController = Get.put(staffRankingsController());

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
          title: const Text("Staff Ranking"),
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
    List<UserModel> staffs = _staffRankingsController.allStaffs;
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
            staffs.length,
            (index) => DataRow(
              cells: [
                DataCell(Text(
                  (index + 1).toString(),
                  style: TextStylePreset.bigText,
                )), // Index column
                DataCell(Text(
                  staffs[index].fullName.toString(),
                  style: TextStylePreset.bigText,
                )),
                DataCell(Text(
                  staffs[index].rewardPoint.toString(),
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
