import 'package:fitnessapp/fitness_app/controllers/User/changeUserInfoController.dart';
import 'package:fitnessapp/fitness_app/preferences/current_user.dart';
import 'package:fitnessapp/fitness_app/views/responsive_padding.dart';
import 'package:fitnessapp/theme/colors.dart';
import 'package:fitnessapp/theme/text_style.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class ChangeUserInfoPage extends StatefulWidget {
  const ChangeUserInfoPage({Key? key}) : super(key: key);

  @override
  _ChangeUserInfoPageState createState() => _ChangeUserInfoPageState();
}

class _ChangeUserInfoPageState extends State<ChangeUserInfoPage> {
  final _changeUserInfoController = Get.put(changeUserInfoController());
  final CurrentUser _currentUser = Get.put(CurrentUser());
  var genders = [
    'Select gender',
    'Female',
    'Male',
  ];

  //methods

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return ResponsivePadding(
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.white),
            onPressed: () => Get.back(),
          ),
          title: const Text("Change User Information"),
        ),
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
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(children: [
              const Text(
                "Change user info",
                style: TextStylePreset.bigTitle,
              ),
              const SizedBox(
                height: 15,
              ),
              userInfoForm(),
            ]),
          ),
        ),
      );
    });
  }

  Form userInfoForm() {
    return Form(
      key: _changeUserInfoController.changeUserInfoFormKey,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      child: Column(
        children: [
          nameField(),
          const SizedBox(
            height: 15,
          ),
          genderField(),
          const SizedBox(
            height: 15,
          ),
          dobField(),
          const SizedBox(
            height: 15,
          ),
          InkWell(
            onTap: () {
              _changeUserInfoController.updateUserInfo();
            },
            child: updateUserInfoButton(),
          )
        ],
      ),
    );
  }

  Container nameField() {
    return Container(
      height: 50,
      width: double.infinity,
      decoration: BoxDecoration(
          color: bgTextField, borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.only(left: 10, right: 10),
        child: Row(
          children: [
            Icon(
              Icons.abc,
              color: black.withOpacity(0.5),
            ),
            const SizedBox(
              width: 15,
            ),
            Flexible(
              child: TextFormField(
                cursorColor: black.withOpacity(0.5),
                decoration: const InputDecoration(
                    hintText: "Username", border: InputBorder.none),
                keyboardType: TextInputType.name,
                controller: _changeUserInfoController.fullNameController,
                validator: (value) {
                  if (value!.isEmpty) {
                    return "Please enter username";
                  }
                  return null;
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Container genderField() {
    String genderValue = _currentUser.user.gender;
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15.0),
        border: Border.all(color: black.withOpacity(0.1)),
      ),
      child: DropdownButtonFormField(
        decoration: const InputDecoration(
          border: InputBorder.none,
          prefixIcon: Icon(Icons.wc),
        ),
        padding: const EdgeInsets.only(right: 10),
        value: genderValue,
        icon: const Icon(Icons.keyboard_arrow_down),
        isExpanded: true,
        items: genders.map((String items) {
          return DropdownMenuItem(
            value: items,
            child: Text(items),
          );
        }).toList(),
        onChanged: (String? newValue) {
          setState(() {
            genderValue = newValue!;
            _changeUserInfoController.gender.value = genderValue;
          });
        },
        validator: (genderValue) {
          if (genderValue == "Select gender") {
            return "Please select a gender";
          }
          return null;
        },
      ),
    );
  }

  Container dobField() {
    return Container(
      height: 50,
      width: double.infinity,
      decoration: BoxDecoration(
          color: bgTextField, borderRadius: BorderRadius.circular(15)),
      child: Padding(
        padding: const EdgeInsets.only(left: 10),
        child: Row(
          children: [
            Icon(
              Icons.calendar_today,
              color: black.withOpacity(0.5),
            ),
            const SizedBox(
              width: 15,
            ),
            Flexible(
              child: TextFormField(
                controller: _changeUserInfoController.dobController,
                //editing controller of this TextField
                decoration: const InputDecoration(
                  hintText: "Enter Date Of Birth", //label text of field
                ),
                readOnly: true,
                //set it true, so that user will not able to edit text
                onTap: () async {
                  DateTime? pickedDate = await showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime(1950),
                      //DateTime.now() - not to allow to choose before today.
                      lastDate: DateTime(2100));

                  if (pickedDate != null) {
                    print(
                        pickedDate); //pickedDate output format => 2021-03-10 00:00:00.000
                    String formattedDate =
                        DateFormat('yyyy-MM-dd').format(pickedDate);
                    print(
                        formattedDate); //formatted date output using intl package =>  2021-03-16
                    setState(() {
                      _changeUserInfoController.dobController.text =
                          formattedDate; //set output date to TextField value.
                    });
                  } else {}
                },
                validator: (formattedDate) {
                  if (formattedDate!.isEmpty) {
                    return "Please enter date of birth";
                  }
                  return null;
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Container updateUserInfoButton() {
    return Container(
      height: 50,
      width: double.infinity,
      decoration: BoxDecoration(
          gradient: const LinearGradient(colors: [fourthColor, thirdColor]),
          borderRadius: BorderRadius.circular(30)),
      child: const Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.arrow_forward_sharp,
            color: white,
          ),
          SizedBox(
            width: 5,
          ),
          Text(
            "Update User Info",
            style: TextStylePreset.btnSmallText,
          )
        ],
      ),
    );
  }
}
