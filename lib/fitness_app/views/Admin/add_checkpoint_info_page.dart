import 'package:fitnessapp/fitness_app/controllers/Admin/addCheckpointInfoController.dart';
import 'package:fitnessapp/fitness_app/views/responsive_padding.dart';
import 'package:fitnessapp/theme/colors.dart';
import 'package:fitnessapp/theme/text_style.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddCheckpointInfoPage extends StatefulWidget {
  const AddCheckpointInfoPage({Key? key}) : super(key: key);

  @override
  _AddCheckpointInfoPageState createState() => _AddCheckpointInfoPageState();
}

class _AddCheckpointInfoPageState extends State<AddCheckpointInfoPage> {
  final _addCheckpointInfoController = Get.put(addCheckpointInfoController());
  var types = [
    'Select type',
    'RFID',
    'QR Code',
  ];
  //methods

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
          title: const Text("Add Checkpoint Information"),
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
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(children: [
              const Text(
                "Add Checkpoint",
                style: TextStylePreset.bigTitle,
              ),
              const SizedBox(
                height: 15,
              ),
              checkpointInfoForm(),
            ]),
          ),
        ),
      );
    });
  }

  Form checkpointInfoForm() {
    return Form(
      key: _addCheckpointInfoController.addCheckpointInfoFormKey,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      child: Column(
        children: [
          nameField(),
          const SizedBox(
            height: 15,
          ),
          descriptionField(),
          const SizedBox(
            height: 15,
          ),
          locationField(),
          const SizedBox(
            height: 15,
          ),
          typeField(),
          const SizedBox(
            height: 15,
          ),
          InkWell(
            onTap: () {
              _addCheckpointInfoController.addCheckpoint();
            },
            child: addCheckpointButton(),
          ),
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
                    hintText: "Name", border: InputBorder.none),
                keyboardType: TextInputType.name,
                controller: _addCheckpointInfoController.nameController,
                validator: (value) {
                  if (value!.isEmpty) {
                    return "Please enter name";
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

  Container descriptionField() {
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
                    hintText: "Description", border: InputBorder.none),
                keyboardType: TextInputType.text,
                controller: _addCheckpointInfoController.descriptionController,
                validator: (value) {
                  if (value!.isEmpty) {
                    return "Please enter description";
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

  Container locationField() {
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
                    hintText: "Location", border: InputBorder.none),
                keyboardType: TextInputType.text,
                controller: _addCheckpointInfoController.locationController,
                validator: (value) {
                  if (value!.isEmpty) {
                    return "Please enter location";
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

  Container typeField() {
    String typeValue = types[0];
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15.0),
        border: Border.all(color: black.withOpacity(0.1)),
      ),
      child: DropdownButtonFormField(
        decoration: const InputDecoration(
          prefixIcon: Icon(Icons.person),
        ),
        padding: const EdgeInsets.only(left: 10, right: 10),
        value: typeValue,
        icon: const Icon(Icons.keyboard_arrow_down),
        isExpanded: true,
        items: types.map((String items) {
          return DropdownMenuItem(
            value: items,
            child: Text(items),
          );
        }).toList(),
        onChanged: (String? newValue) {
          setState(() {
            typeValue = newValue!;
            _addCheckpointInfoController.typeController.text = typeValue;
          });
        },
        validator: (checkpointTypeValue) {
          if (checkpointTypeValue == "Select type") {
            return "Please select a type";
          }
          return null;
        },
      ),
    );
  }

  Container addCheckpointButton() {
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
            "Add Checkpoint",
            style: TextStylePreset.btnSmallText,
          )
        ],
      ),
    );
  }

  // Need to add state
  // Container userTypeField() {
  //   return Container(
  //     decoration: BoxDecoration(
  //       borderRadius: BorderRadius.circular(15.0),
  //       border: Border.all(color: black.withOpacity(0.1)),
  //     ),
  //     child: DropdownButtonFormField(
  //       decoration: const InputDecoration(
  //         border: InputBorder.none,
  //         prefixIcon: Icon(Icons.person),
  //       ),
  //       padding: const EdgeInsets.only(right: 10),
  //       value: userTypeValue,
  //       icon: const Icon(Icons.keyboard_arrow_down),
  //       isExpanded: true,
  //       items: users.map((String items) {
  //         return DropdownMenuItem(
  //           value: items,
  //           child: Text(items),
  //         );
  //       }).toList(),
  //       onChanged: (String? newValue) {
  //         setState(() {
  //           userTypeValue = newValue!;
  //           _registerController.userTypeValue.value = userTypeValue;
  //         });
  //       },
  //       validator: (userTypeValue) {
  //         if (userTypeValue == "Select user") {
  //           return "Please select a user";
  //         }
  //         return null;
  //       },
  //     ),
  //   );
  // }

  // Container emailField() {
  //   return Container(
  //     height: 50,
  //     width: double.infinity,
  //     decoration: BoxDecoration(
  //         color: bgTextField, borderRadius: BorderRadius.circular(12)),
  //     child: Padding(
  //       padding: const EdgeInsets.only(left: 10, right: 10),
  //       child: Row(
  //         children: [
  //           Icon(
  //             LineIcons.envelope,
  //             color: black.withOpacity(0.5),
  //           ),
  //           const SizedBox(
  //             width: 15,
  //           ),
  //           Flexible(
  //             child: TextFormField(
  //               cursorColor: black.withOpacity(0.5),
  //               decoration: const InputDecoration(
  //                   hintText: "Email", border: InputBorder.none),
  //               keyboardType: TextInputType.emailAddress,
  //               controller: _registerController.emailController,
  //               onSaved: (value) {
  //                 _registerController.email = value!; //! is null check operator
  //               },
  //               validator: (value) {
  //                 return _registerController.validateEmail(value!);
  //               },
  //             ),
  //           ),
  //         ],
  //       ),
  //     ),
  //   );
  // }

  // Container passwordField() {
  //   return Container(
  //     height: 50,
  //     width: double.infinity,
  //     decoration: BoxDecoration(
  //         color: bgTextField, borderRadius: BorderRadius.circular(12)),
  //     child: Padding(
  //       padding: const EdgeInsets.only(left: 10),
  //       child: Row(
  //         children: [
  //           Icon(
  //             LineIcons.lock,
  //             color: black.withOpacity(0.5),
  //           ),
  //           const SizedBox(
  //             width: 15,
  //           ),
  //           Flexible(
  //             child: TextFormField(
  //               cursorColor: black.withOpacity(0.5),
  //               decoration: const InputDecoration(
  //                   hintText: 'Password', border: InputBorder.none),
  //               obscureText: _obscureText,
  //               keyboardType: TextInputType.visiblePassword,
  //               controller: _registerController.passwordController,
  //               onSaved: (value) {
  //                 _registerController.password =
  //                     value!; //! is null check operator
  //               },
  //               validator: (value) {
  //                 return _registerController.validatePassword(value!);
  //               },
  //             ),
  //           ),
  //           IconButton(
  //               onPressed: _toggle,
  //               icon: Icon(
  //                 LineIcons.eyeAlt,
  //                 color: black.withOpacity(0.5),
  //               ))
  //         ],
  //       ),
  //     ),
  //   );
  // }
}
