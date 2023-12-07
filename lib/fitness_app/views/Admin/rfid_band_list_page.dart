import 'package:fitnessapp/fitness_app/controllers/Admin/rfidBandListController.dart';
import 'package:fitnessapp/fitness_app/views/responsive_padding.dart';
import 'package:fitnessapp/theme/colors.dart';
import 'package:fitnessapp/theme/text_style.dart';
import 'package:fitnessapp/routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RfidBandListPage extends StatefulWidget {
  const RfidBandListPage({Key? key}) : super(key: key);

  @override
  _RfidBandListPageState createState() => _RfidBandListPageState();
}

class _RfidBandListPageState extends State<RfidBandListPage> {
  final _rfidBandListController = Get.put(rfidBandListController());

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
                          Get.toNamed(Routes.add_rfid_band_info);
                        },
                        child: addRfidBandButton(),
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      const Text(
                        "RfidBand List:",
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
          itemCount: _rfidBandListController.rfidBandList.length,
          scrollDirection: Axis.vertical,
          itemBuilder: (context, index) {
            return Card(
              color: Colors.blue.shade100,
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: ListTile(
                  title: Text(
                    _rfidBandListController.rfidBandList[index].name,
                    style: TextStylePreset.bigText,
                  ),
                  subtitle: Text(
                    _rfidBandListController.rfidBandList[index].uid,
                    style: TextStylePreset.normalText,
                  ),
                  trailing: SizedBox(
                    width: 125,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Text(
                            "${_rfidBandListController.rfidBandList[index].rfid_band_id}",
                            style: TextStyle(height: 5, fontSize: 10),
                          ),
                        ),
                        Expanded(
                          child: InkWell(
                            onTap: () {
                              Get.toNamed(Routes.edit_rfid_band_info,
                                  arguments: [
                                    _rfidBandListController.rfidBandList[index],
                                    _rfidBandListController.getUserEmail(
                                        _rfidBandListController
                                            .rfidBandList[index].user_id)
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

  Container addRfidBandButton() {
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
            "Add RfidBand",
            style: TextStylePreset.btnBigText,
          )
        ],
      ),
    );
  }

  // List<DataRow> getRows(List<UserModel> students) =>
  //     students.map((UserModel student) {
  //       final cells = ["#"+, student.fullName, student.rfidBandPoint];
  //       return DataRow(cells: getCells(cells));
  //     }).toList();
}
