import 'package:fitnessapp/fitness_app/controllers/User/visceralFatController.dart';
import 'package:fitnessapp/fitness_app/views/responsive_padding.dart';
import 'package:fitnessapp/routes.dart';
import 'package:fitnessapp/theme/colors.dart';
import 'package:fitnessapp/theme/text_style.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:line_icons/line_icons.dart';

class VisceralFatPage extends StatefulWidget {
  const VisceralFatPage({Key? key}) : super(key: key);

  @override
  _VisceralFatPageState createState() => _VisceralFatPageState();
}

class _VisceralFatPageState extends State<VisceralFatPage> {
  final _visceralFatController = Get.put(visceralFatController());

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return ResponsivePadding(
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.white),
            onPressed: () => Get.offNamed(Routes.root_app),
          ),
          title: const Text("Visceral Fat"),
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
          minWidth: double.infinity,
        ),
        child: SingleChildScrollView(
          child: Container(
              padding: const EdgeInsets.all(20),
              height: MediaQuery.of(context).size.height,
              child: Column(
                children: [
                  const Text(
                    "Add New Visceral Fat",
                    style: TextStylePreset.bigTitle,
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  addNewVisceralFatForm(),
                  const SizedBox(
                    height: 30,
                  ),
                  const Text(
                    "All records",
                    style: TextStylePreset.bigTitle,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  displayUserAllVisceralFat(),
                ],
              )),
        ),
      );
    });
  }

  Container addNewVisceralFatForm() {
    return Container(
      alignment: Alignment.topLeft,
      width: double.infinity,
      padding: const EdgeInsets.only(left: 20, top: 10, right: 20, bottom: 10),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey),
        borderRadius: const BorderRadius.all(Radius.circular(5.0)),
      ),
      child: Form(
        key: _visceralFatController.addNewVisceralFatFormKey,
        autovalidateMode: AutovalidateMode.always,
        child: Column(
          children: [
            ratingField(),
            const SizedBox(
              height: 15,
            ),
            InkWell(
              onTap: () {
                _visceralFatController.addNewVisceralFat();
              },
              child: addVisceralFatButton(),
            )
          ],
        ),
      ),
    );
  }

  Container ratingField() {
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
              Icons.star,
              color: black.withOpacity(0.5),
            ),
            const SizedBox(
              width: 15,
            ),
            Flexible(
              child: TextFormField(
                cursorColor: black.withOpacity(0.5),
                decoration: const InputDecoration(
                    hintText: "Rating", border: InputBorder.none),
                keyboardType: TextInputType.number,
                controller: _visceralFatController.ratingController,
                validator: (value) {
                  if (value!.isEmpty) {
                    return "Please enter systolic pressure";
                  } else if (!value.isNumericOnly) {
                    return "Please enter numeric value";
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

  Container addVisceralFatButton() {
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
            "Add Visceral Fat",
            style: TextStylePreset.btnSmallText,
          )
        ],
      ),
    );
  }

  Obx displayUserAllVisceralFat() {
    return Obx(() => ListView.builder(
          shrinkWrap: true,
          primary: false,
          itemCount: _visceralFatController.allVisceralFats.length,
          scrollDirection: Axis.vertical,
          itemBuilder: (context, index) {
            return Card(
              color: primary,
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: ListTile(
                  title: Text(
                    _visceralFatController.allVisceralFats[index].rating
                        .toString(),
                    style: TextStylePreset.bigText,
                  ),
                  subtitle: Text(
                    _visceralFatController.allVisceralFats[index].createdAt,
                    style: TextStylePreset.normalText,
                  ),
                  trailing: SizedBox(
                    width: 90,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                            child: IconButton(
                                onPressed: () {
                                  showDialog(
                                    context: context,
                                    builder: (context) => SimpleDialog(
                                      children: [
                                        editVisceralFatForm(
                                            _visceralFatController
                                                .allVisceralFats[index].vfID),
                                      ],
                                    ),
                                  );
                                },
                                icon: const Icon(Icons.edit))),
                        Expanded(
                            child: IconButton(
                                onPressed: () {
                                  //delete action
                                  _visceralFatController.deleteUserVisceralFat(
                                      _visceralFatController
                                          .allVisceralFats[index].vfID);
                                },
                                icon: const Icon(Icons.delete))),
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        ));
  }

  Form editVisceralFatForm(int vfID) {
    return Form(
      key: _visceralFatController.editVisceralFatFormKey,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      child: Column(
        children: [
          editRatingField(),
          const SizedBox(
            height: 15,
          ),
          InkWell(
            onTap: () {
              _visceralFatController.updateUserVisceralFat(vfID);
              Get.back();
            },
            child: updateVisceralFatButton(),
          )
        ],
      ),
    );
  }

  Container editRatingField() {
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
              LineIcons.star,
              color: black.withOpacity(0.5),
            ),
            const SizedBox(
              width: 15,
            ),
            Flexible(
              child: TextFormField(
                cursorColor: black.withOpacity(0.5),
                decoration: const InputDecoration(
                    hintText: "Rating", border: InputBorder.none),
                keyboardType: TextInputType.number,
                controller: _visceralFatController.updateRatingController,
                validator: (value) {
                  if (value!.isEmpty) {
                    return "Please enter systolic pressure";
                  } else if (!value.isNumericOnly) {
                    return "Please enter numeric values";
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

  Container updateVisceralFatButton() {
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
            "Update Visceral Fat",
            style: TextStylePreset.btnSmallText,
          )
        ],
      ),
    );
  }
}
