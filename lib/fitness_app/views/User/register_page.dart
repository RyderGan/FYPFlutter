import 'dart:convert';

import 'package:fitnessapp/fitness_app/controllers/User/registerController.dart';
import 'package:fitnessapp/fitness_app/models/User/userModel.dart';
import 'package:fitnessapp/fitness_app/services/api_connection.dart';
import 'package:fitnessapp/fitness_app/views/responsive_padding.dart';
import 'package:fitnessapp/routes.dart';
import 'package:fitnessapp/theme/colors.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:line_icons/line_icons.dart';
import 'package:http/http.dart' as http;

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  bool _obscureText = true;
  String _password = '';
  String userTypeValue = 'Select user';
  String genderValue = 'Select gender';

  final _registerController = Get.put(registerController());

  //variables
  var users = [
    'Select user',
    'Staff',
    'Student',
  ];

  var genders = [
    'Select gender',
    'Female',
    'Male',
  ];

  //methods
  void _toggle() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  @override
  Widget build(BuildContext context) {
    return ResponsivePadding(
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Register account"),
        ),
        backgroundColor: white,
        body: SafeArea(child: getBody()),
      ),
    );
  }

  Widget getBody() {
    return LayoutBuilder(
      builder: (context, constraints) {
        return ConstrainedBox(
          constraints: BoxConstraints(
            minHeight: constraints.maxHeight,
          ),
          child: SingleChildScrollView(
            child: Form(
              key: _registerController.registerFormKey,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  children: [
                    Container(
                        padding: EdgeInsets.only(bottom: 20),
                        child: Column(
                          children: [
                            Text(
                              "Welcome to UM Health Tracker",
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Text(
                              "Please fill in the form below to register.",
                              style: TextStyle(fontSize: 14),
                            )
                          ],
                        )),
                    Container(
                      child: Column(
                        children: [
                          nameField(),
                          SizedBox(
                            height: 10,
                          ),
                          emailField(),
                          SizedBox(
                            height: 10,
                          ),
                          passwordField(),
                          SizedBox(
                            height: 10,
                          ),
                          userTypeField(),
                          SizedBox(
                            height: 10,
                          ),
                          genderField(),
                          SizedBox(
                            height: 10,
                          ),
                          dobField(),
                          SizedBox(
                            height: 10,
                          ),
                          InkWell(
                            onTap: () {
                              _registerController.registerAction();
                              // if (_registerController.emailExist == true)
                              //   [
                              //     Get.showSnackbar(
                              //       GetSnackBar(
                              //         title: "Login failed",
                              //         message: 'Email already exist',
                              //         icon: const Icon(Icons.error),
                              //         backgroundColor: primary,
                              //         duration: const Duration(seconds: 3),
                              //       ),
                              //     ),
                              //   ];
                            },
                            child: registerButton(),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        );
      },
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
            SizedBox(
              width: 15,
            ),
            Flexible(
              child: TextFormField(
                cursorColor: black.withOpacity(0.5),
                decoration: InputDecoration(
                    hintText: "Username", border: InputBorder.none),
                keyboardType: TextInputType.name,
                controller: _registerController.nameController,
                onSaved: (value) {
                  _registerController.name = value!; //! is null check operator
                },
                validator: (value) {
                  if (value!.isEmpty) {
                    return "Please enter username";
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Container emailField() {
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
              LineIcons.envelope,
              color: black.withOpacity(0.5),
            ),
            SizedBox(
              width: 15,
            ),
            Flexible(
              child: TextFormField(
                cursorColor: black.withOpacity(0.5),
                decoration: InputDecoration(
                    hintText: "Email", border: InputBorder.none),
                keyboardType: TextInputType.emailAddress,
                controller: _registerController.emailController,
                onSaved: (value) {
                  _registerController.email = value!; //! is null check operator
                },
                validator: (value) {
                  return _registerController.validateEmail(value!);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Container passwordField() {
    return Container(
      height: 50,
      width: double.infinity,
      decoration: BoxDecoration(
          color: bgTextField, borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.only(left: 10),
        child: Row(
          children: [
            Icon(
              LineIcons.lock,
              color: black.withOpacity(0.5),
            ),
            SizedBox(
              width: 15,
            ),
            Flexible(
              child: TextFormField(
                cursorColor: black.withOpacity(0.5),
                decoration: const InputDecoration(
                    hintText: 'Password', border: InputBorder.none),
                obscureText: _obscureText,
                keyboardType: TextInputType.visiblePassword,
                controller: _registerController.passwordController,
                onSaved: (value) {
                  _registerController.password =
                      value!; //! is null check operator
                },
                validator: (value) {
                  return _registerController.validatePassword(value!);
                },
              ),
            ),
            IconButton(
                onPressed: _toggle,
                icon: Icon(
                  LineIcons.eyeAlt,
                  color: black.withOpacity(0.5),
                ))
          ],
        ),
      ),
    );
  }

  Container userTypeField() {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15.0),
        border: Border.all(color: black.withOpacity(0.1)),
      ),
      child: DropdownButtonFormField(
        decoration: InputDecoration(
          border: InputBorder.none,
          prefixIcon: Icon(Icons.person),
        ),
        padding: const EdgeInsets.only(right: 10),
        value: userTypeValue,
        icon: const Icon(Icons.keyboard_arrow_down),
        isExpanded: true,
        items: users.map((String items) {
          return DropdownMenuItem(
            value: items,
            child: Text(items),
          );
        }).toList(),
        onChanged: (String? newValue) {
          setState(() {
            userTypeValue = newValue!;
            _registerController.userTypeValue.value = userTypeValue;
          });
        },
        validator: (userTypeValue) {
          if (userTypeValue == "Select user") {
            return "Please select a user";
          }
        },
      ),
    );
  }

  Container genderField() {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15.0),
        border: Border.all(color: black.withOpacity(0.1)),
      ),
      child: DropdownButtonFormField(
        decoration: InputDecoration(
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
            _registerController.gender.value = genderValue;
          });
        },
        validator: (genderValue) {
          if (genderValue == "Select gender") {
            return "Please select a gender";
          }
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
            SizedBox(
              width: 15,
            ),
            Flexible(
              child: TextFormField(
                controller: _registerController.dobController,
                //editing controller of this TextField
                decoration: InputDecoration(
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
                      _registerController.dobController.text =
                          formattedDate; //set output date to TextField value.
                    });
                  } else {}
                },
                onSaved: (formattedDate) {
                  _registerController.dob = formattedDate!;
                },
                validator: (formattedDate) {
                  if (formattedDate!.isEmpty) {
                    return "Please enter date of birth";
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Container registerButton() {
    return Container(
      height: 50,
      width: double.infinity,
      decoration: BoxDecoration(
          gradient: LinearGradient(colors: [fourthColor, thirdColor]),
          borderRadius: BorderRadius.circular(30)),
      child: Row(
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
            "Register",
            style: TextStyle(
                fontSize: 16, color: white, fontWeight: FontWeight.bold),
          )
        ],
      ),
    );
  }

  Container loginButton() {
    return Container(
      height: 50,
      width: 200,
      decoration: BoxDecoration(
          gradient: LinearGradient(colors: [fourthColor, thirdColor]),
          borderRadius: BorderRadius.circular(30)),
      child: Row(
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
            "Login",
            style: TextStyle(
                fontSize: 16, color: white, fontWeight: FontWeight.bold),
          )
        ],
      ),
    );
  }
}
