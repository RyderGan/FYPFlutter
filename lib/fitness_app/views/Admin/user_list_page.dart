import 'package:fitnessapp/fitness_app/controllers/Admin/userListController.dart';
import 'package:fitnessapp/fitness_app/views/responsive_padding.dart';
import 'package:fitnessapp/theme/colors.dart';
import 'package:fitnessapp/theme/text_style.dart';
import 'package:fitnessapp/routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class UserListPage extends StatefulWidget {
  const UserListPage({Key? key}) : super(key: key);

  @override
  _UserListPageState createState() => _UserListPageState();
}

class _UserListPageState extends State<UserListPage> {
  final _userListController = Get.put(userListController());

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
                      dataTable(),
                    ],
                  ))));
    });
  }

  Widget dataTable() {
    return Obx(() => ListView.builder(
          shrinkWrap: true,
          primary: false,
          itemCount: _userListController.userList.length,
          scrollDirection: Axis.vertical,
          itemBuilder: (context, index) {
            return Card(
              color: Colors.blue.shade100,
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: ListTile(
                  title: Text(
                    _userListController.userList[index].fullName,
                    style: TextStylePreset.bigText,
                  ),
                  subtitle: Text(
                    _userListController.userList[index].email,
                    style: TextStylePreset.normalText,
                  ),
                  trailing: SizedBox(
                    width: 125,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Text(
                            "${_userListController.userList[index].userType}",
                            style: TextStyle(height: 5, fontSize: 10),
                          ),
                        ),
                        Expanded(
                          child: InkWell(
                            onTap: () {
                              Get.toNamed(Routes.edit_user_info,
                                  arguments:
                                      _userListController.userList[index]);
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

  // List<DataRow> getRows(List<UserModel> students) =>
  //     students.map((UserModel student) {
  //       final cells = ["#"+, student.fullName, student.rewardPoint];
  //       return DataRow(cells: getCells(cells));
  //     }).toList();
}
