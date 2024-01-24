import 'package:fitnessapp/fitness_app/controllers/Admin/addRewardInfoController.dart';
import 'package:fitnessapp/fitness_app/views/responsive_padding.dart';
import 'package:fitnessapp/theme/colors.dart';
import 'package:fitnessapp/theme/text_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class AddRewardInfoPage extends StatefulWidget {
  const AddRewardInfoPage({Key? key}) : super(key: key);

  @override
  _AddRewardInfoPageState createState() => _AddRewardInfoPageState();
}

class _AddRewardInfoPageState extends State<AddRewardInfoPage> {
  final _addRewardInfoController = Get.put(addRewardInfoController());

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
          title: const Text("Add Reward Information"),
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
                "Add Reward info",
                style: TextStylePreset.bigTitle,
              ),
              const SizedBox(
                height: 15,
              ),
              rewardInfoForm(),
            ]),
          ),
        ),
      );
    });
  }

  Form rewardInfoForm() {
    return Form(
      key: _addRewardInfoController.addRewardInfoFormKey,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      child: Column(
        children: [
          titleField(),
          const SizedBox(
            height: 15,
          ),
          descriptionField(),
          const SizedBox(
            height: 15,
          ),
          pointField(),
          const SizedBox(
            height: 15,
          ),
          InkWell(
            onTap: () {
              _addRewardInfoController.addReward();
            },
            child: addRewardButton(),
          ),
        ],
      ),
    );
  }

  Container titleField() {
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
                    hintText: "Title", border: InputBorder.none),
                keyboardType: TextInputType.name,
                controller: _addRewardInfoController.titleController,
                validator: (value) {
                  if (value!.isEmpty) {
                    return "Please enter title";
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
                keyboardType: TextInputType.name,
                controller: _addRewardInfoController.descriptionController,
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

  Container pointField() {
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
                    hintText: "Points", border: InputBorder.none),
                keyboardType: TextInputType.number,
                inputFormatters: [
                  FilteringTextInputFormatter.allow(RegExp("[0-9]"))
                ],
                controller: _addRewardInfoController.pointController,
                validator: (value) {
                  if (value!.isEmpty) {
                    return "Please enter points";
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

  Container addRewardButton() {
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
            "Add Reward",
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
